--[[--
	Fetches the creative-writing repository and compiles works into website
	pages. The specification for the work format can be found in the
	creative-writing repo itself. This script assumes that files in said repo
	adhere to the specification.

	Does not support (yet!):
		* Multi-part stories
		* Multi-file stories (having images, etc)

	Other TODO:
		* Make story links on the index page show description?
]]

local fs = require("fs")
local pathlib = require("path")
local cmark = require("cmark")
local lcmark = require("lcmark")

local SOURCE_DIR = "../creative-writing"
local OUTPUT_DIR = "./stories/"
local STORY_TEMPLATE_FILE = "./assets/story-template.html"
local STORY_INDEX_FILE = "./stories/index.html"

local WARN_DESCS = {
	gore = "Graphic violence/injury",
	shocking = "Other shocking content",
	cringe = "Very bad and cringy writing",
}

local LCMARK_OPTIONS = {
	yaml_metadata = true,
	safe = false,
	smart = true,
	filters = {
		-- Increase heading level by 1
		function(doc, meta, to)
			for node, entering, nodeType in cmark.walk(doc) do
				if nodeType == cmark.NODE_HEADING and entering then
					local curLevel = cmark.get_heading_level(node)
					cmark.set_heading_level(node, math.min(curLevel + 1, 6))
				end
			end
		end,
		-- Make sure notes are wrapped in paragraphs
		function(doc, meta, to)

			local function wrap(field)
				local fieldNode = meta[field]
				if not fieldNode then
					return
				end

				local first = cmark.node_first_child(fieldNode)

				if cmark.node_get_type(first) == cmark.NODE_CUSTOM_INLINE and not cmark.node_next(first) then

				end
			end
		end,
	},
}

local generatedAt = os.date("Automatically generated on %F %T")

local storyTemplateRaw = assert(fs.readFileSync(STORY_TEMPLATE_FILE))
local storyTemplate = assert(lcmark.compile_template(storyTemplateRaw))

local indexTemplateRaw = assert(fs.readFileSync(STORY_INDEX_FILE))
local indexTemplate = assert(lcmark.compile_template(indexTemplateRaw))



local function convertWarnings(warnings)
	if not warnings then
		return
	end

	for i, name in ipairs(warnings) do
		warnings[i] = assert(WARN_DESCS[name], "invalid warning")
	end
end

local function wrapParagraph(text)
	if not text or text:sub(1, 3) == "<p>" then
		return text
	else
		return "<p>" .. text .. "</p>"
	end
end

local function compileSinglePartWork(name, dir)
	-- Read
	local contentPath = pathlib.join(dir, "main.md")
	local raw = assert(fs.readFileSync(contentPath))

	local body, meta, err = lcmark.convert(raw, "html", LCMARK_OPTIONS)
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
	local compiledDirName = pathlib.join(OUTPUT_DIR, name)
	local storyFileName = pathlib.join(compiledDirName, "index.html")

	assert(fs.mkdirSync(compiledDirName))
	assert(fs.writeFileSync(storyFileName, rendered))

	return {
		name = name,
		title = meta.title,
		desc = meta.description,
		link = "./" .. name,
	}
end

local function compileIndex(indexData)
	local rendered = lcmark.apply_template(indexTemplate, {
		data = indexData,
		generatedAt = generatedAt,
	})
	assert(fs.writeFileSync(STORY_INDEX_FILE, rendered))
end



local indexData = {}

for name, t in assert(fs.scandirSync(SOURCE_DIR)) do
	if t == "directory" and name:sub(1, 1) ~= "." then
		local path = pathlib.join(SOURCE_DIR, name)
		local data = compileSinglePartWork(path)
		if data then
			table.insert(indexData, data)

			print("SUCCESS: " .. name)
		else
			print("SKIP")
		end
	end
end

compileIndex(indexData)

print("WROTE INDEX")
print("DONE")