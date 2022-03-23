local fs = require("coro-fs")
local pathlib = require("path")

local lunamark = require("lunamark")
local gumbo = require("gumbo")
local yaml = require("yaml")

local COMPILED_STORIES_DIR = "./stories/"
local TEMPLATE_FILE = "./assets/story-template.html"

local STORY_PARENT_ELEMENT = "main"
local WARN_OVERLAY_ID = "warning-overlay"
local WARN_COMPONENT_CLASS = "story-warning-component"
local VERSION_LABEL_ID = "version-label"
local ASIDED_HEADER_CLASS = "asided-header"
local WARNS_ATTRIB_NAME = "data-warnings"

-- TODO: Support for other files and such


local opts = {}
local writer = lunamark.writer.html.new(opts)
local parseMarkdown = lunamark.reader.markdown.new(writer, opts)



local function getGenerationTimeString()
	return os.date("Automatically generated on %F %T")
end


local function iterFolderPathsIn(dir)
	local iter = assert(fs.scandir(dir))

	return function()
		local info
		repeat
			info = iter()
		until not info or (info.type == "directory" and info.name:sub(1, 1) ~= ".")

		if not info then return nil end

		return pathlib.join(dir, info.name)
	end
end


local function cleanTitle(title)
	return title
		:gsub("%W+", "_") -- Replace all non-alphanum sequences with a '_'
		:match("^_?(.+)_?$") -- Remove leading/trailing '_'s
		:lower()
end

local function truncate(str, max)
	if utf8.len(str) > max then
		local stringEnd = utf8.offset(str, max) - 1 -- Get end of previous char
		return str:sub(1, stringEnd) .. "…"
	else
		return str
	end
end
assert(truncate("…..…", 2) == "……") -- Quick test


-- gumbo doesn't add the DOCTYPE tag
local function addDoctype(html)
	return "<!DOCTYPE html>\n" .. html
end

local function addClass(element, class)
	local existing = element.className

	if existing and existing ~= "" then
		existing = existing .. " " .. class
	else
		existing = class
	end

	element.className = existing
end

local function insertAfter(new, reference)
	if reference.nextSibling then
		reference.parentNode:insertBefore(new, reference.nextSibling)
	else
		reference.parentNode:appendChild(new)
	end
end

local function insertFirstChild(new, parent)
	if parent.firstChild then
		parent:insertBefore(new, parent.firstChild)
	else
		parent:appendChild(new)
	end
end

local function setMetaTag(document, name, fieldName, fieldValue)
	local nodes = document:getElementsByTagName("meta")

	for _, node in ipairs(nodes) do
		if node:getAttribute("name") == name then
			node:setAttribute(fieldName, fieldValue)
			break
		end
	end
end



local function compileStory(dir)
	local infoRaw = fs.readFile(pathlib.join(dir, "story.yaml"))
	if not infoRaw then return end

	print("Compiling story in directory:", dir)

	local info = yaml.eval(infoRaw)
	if not info.publish then return end


	local pageDocument = gumbo.parseFile(TEMPLATE_FILE)

	local rawMarkdown = fs.readFile(pathlib.join(dir, "story.md"))
	local storyDocument = gumbo.parse(parseMarkdown(rawMarkdown), {
		contextElement = STORY_PARENT_ELEMENT
	})

	local firstHeadingNode = storyDocument:getElementsByTagName("h1")[1]
	local sampleNode = storyDocument:getElementsByTagName("p")[1]
	local bodyElements = storyDocument.documentElement.children

	local titleNode = pageDocument:getElementsByTagName("title")[1]
	local mainNode = pageDocument:getElementsByTagName(STORY_PARENT_ELEMENT)[1]
	local warningOverlayNode = pageDocument:getElementById(WARN_OVERLAY_ID)
	local warningComponents = pageDocument:getElementsByClassName(WARN_COMPONENT_CLASS)


	-- Set title
	local title = firstHeadingNode.textContent
	titleNode.textContent = title

	-- Set description
	if sampleNode then
		setMetaTag(pageDocument, "description", "content", truncate(sampleNode.textContent, 30))
	end

	-- Add generation comment
	local generatedAt = getGenerationTimeString()
	insertFirstChild(pageDocument:createComment(generatedAt), pageDocument.documentElement)

	-- Add story content
	for _, node in ipairs(bodyElements) do
		pageDocument:adoptNode(node)
		mainNode:appendChild(node)
	end

	-- Add version aside
	local versionNode = pageDocument:createElement("aside")
	versionNode.id = VERSION_LABEL_ID
	versionNode.textContent = info.version
	addClass(firstHeadingNode, ASIDED_HEADER_CLASS)
	versionNode:setAttribute("title", generatedAt)
	insertAfter(versionNode, firstHeadingNode)

	-- Add warnings
	if #info.warnings > 0 then
		warningOverlayNode:setAttribute(WARNS_ATTRIB_NAME, table.concat(info.warnings, ";"))
	else
		for _, componentNode in ipairs(warningComponents) do
			componentNode:remove()
		end
	end


	return cleanTitle(title), addDoctype(pageDocument.documentElement.outerHTML)
end

local function removeCompiled(dir)
	if fs.stat(pathlib.join(dir, "index.html")) then -- Check whether exists
		print("Removing existing story directory:", dir)
		fs.rmrf(dir)
	end
end

local function addCompiled(dir, folderName, content)
	local dirName = pathlib.join(dir, folderName)
	print("Creating story directory:", dirName)
	fs.mkdir(dirName)

	local mainName = pathlib.join(dirName, "index.html")
	print("Writing to file:", mainName)
	fs.writeFile(mainName, content)
end



local clonedDir = args[2]
print("Cloned directory:", clonedDir)

for path in iterFolderPathsIn(COMPILED_STORIES_DIR) do
	removeCompiled(path)
end

for path in iterFolderPathsIn(clonedDir) do
	local folderName, content = compileStory(path)
	if not folderName then goto continue end

	print("Compiled story:", folderName)
	addCompiled(COMPILED_STORIES_DIR, folderName, content)

	::continue::
end