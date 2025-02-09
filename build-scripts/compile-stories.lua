--[[--
	Fetches the creative-writing repository and compiles works into website
	pages. The specification for the work format can be found in the
	creative-writing repo itself. This script assumes that files in said repo
	adhere to the specification.

	Does not support (yet!):
		* Multi-part stories
		* Multi-file stories (having images, etc)
]]

local utils = require("build-scripts.utils")
local lyaml = require("lyaml")
local lcmark = require("lcmark")
local cmark = require("cmark")

local STORIES_DIR = assert(arg[1], "no stories directory provided")
local OUTPUT_DIR = "build/stories/"
local WARNINGS_FILE = utils.path.join(STORIES_DIR, "warnings.yaml")
local STORY_TEMPLATE_FILE = "build/assets/story-template.html"

local LCMARK_OPTIONS = {
	yaml_metadata = true,
	safe = false,
	smart = true,
	filters = {
		-- Increase heading level by 1
		function(doc, meta, to)
			for node, entering, nodeType in cmark.walk(doc) do
				if nodeType == cmark.NODE_HEADING and entering then
					local curLevel = cmark.node_get_heading_level(node)
					cmark.node_set_heading_level(node, math.min(curLevel + 1, 6))
				end
			end
		end,
	},
}

local function warn(msg) return print("\027[33m! WARNING: " .. msg .. "\027[0m") end

local generatedAt = os.date("Automatically generated on %F %T")

local storyTemplateRaw = assert(utils.readfile(STORY_TEMPLATE_FILE))
local storyTemplate = assert(lcmark.compile_template(storyTemplateRaw))

local warningNamesRaw = assert(utils.readfile(WARNINGS_FILE))
local warningNames = assert(lyaml.load(warningNamesRaw))



local function convertWarnings(warnings)
	if not warnings then
		return
	end

	for i, id in ipairs(warnings) do
		-- Minor warning
		local name = warningNames.minor[id]
		if name then
			warnings[i] = name
			goto continue
		end

		-- Major warning
		name = warningNames.major[id]
		if name then
			warnings[i] = name
			warnings.hasMajorWarning = true
			goto continue
		end

		-- Unknown warning
		warnings[i] = name or id
		warn("unknown warning: " .. tostring(id))

		::continue::
	end
end

-- lcmark strips the paragraph from single-line metadata, which is usually what
-- we want, but can be annoying for metadata such as author's notes and so on,
-- so we need to wrap the text with a paragraph.
-- This function is very hacky, but I'm afraid there isn't a more elegant way of
-- doing it. An lcmark filter isn't an option since the paragraph stripping
-- happens *after* the filters, and re-parsing and re-rendering will break
-- markdown that was meant to be escaped.
local function wrapParagraph(text)
	if not text or text:find("^%s*<%s*p%s*>") then -- Assumes no attributes
		return text
	else
		return "<p>" .. text .. "</p>"
	end
end

local function mapWorkDir(dir)
	local mainFilePath = utils.path.join(dir, "main.md")

	if utils.path.exists(mainFilePath) then
		return {
			type = "single",
			mainPath = mainFilePath,
		}
	end

	return nil -- Multi-part works not yet supported
end

local function compileSinglePartWork(dirMap, partName)
	-- Read
	local rawContent = assert(utils.readfile(dirMap.mainPath))
	local body, meta, err = lcmark.convert(rawContent, "html", LCMARK_OPTIONS)
	assert(body, err)

	-- Process
	if not meta.publish then
		return nil
	end

	meta.body = body
	meta.generatedAt = generatedAt
	convertWarnings(meta.warnings)
	meta["note-before"] = wrapParagraph(meta["note-before"])
	meta["note-after"] = wrapParagraph(meta["note-after"])

	local rendered = lcmark.apply_template(storyTemplate, meta)

	-- Write
	local storyFileName = utils.path.join(OUTPUT_DIR, partName .. ".html")

	assert(utils.writefile(storyFileName, rendered))

	if meta.list == false then -- Pretend it wasn't published if it shouldn't be listed
		return nil
	end

	return {
		type = dirMap.type,
		name = partName,
		title = meta.title,
		description = meta.description,
		link = "./" .. partName,
	}
end

local function processWork(workName)
	local workDir = utils.path.join(STORIES_DIR, workName)

	local dirMap = mapWorkDir(workDir)
	if not dirMap then
		return nil
	end

	return compileSinglePartWork(dirMap, workName) or nil
end



local indexData = {}

print("Story dir: " .. STORIES_DIR)

-- Create stories directory
assert(utils.path.mkdir(OUTPUT_DIR))

for workName, fullName, isDir in utils.iterdir(STORIES_DIR) do
	if isDir and not workName:find("^[%._]") then
		local data = processWork(workName)
		if data then
			table.insert(indexData, data)

			print("Success: " .. workName)
		else
			print("Skipping")
		end
	end
end

assert(os.remove(STORY_TEMPLATE_FILE))
print("Removed story template")

print("STORIES DONE")
