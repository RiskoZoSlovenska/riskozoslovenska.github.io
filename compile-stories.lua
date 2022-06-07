--[[--
	Fetches the creative-writing repository and compiles works into website
	pages. The specification for the work format can be found in the
	creative-writing repo itself. This script assumes that files in said repo
	adhere to the specification.

	Does not support (yet!):
		* Author's notes
		* Contributors
		* Multi-part stories
		* Multi-file stories (having images, etc)

	Other TODO:
		* Make story links on the index page show description?
]]

local fs = require("coro-fs")
local pathlib = require("path")

local lunamark = require("lunamark")
local gumbo = require("gumbo")
local yaml = require("yaml")

local COMPILED_STORIES_DIR = "./stories/"
local STORY_INDEX_FILE = "./stories/index.html"
local PAGE_TEMPLATE_FILE = "./assets/story-template.html"

local TITLE_HEADER_ID = "title-header"
local VERSION_LABEL_ID = "version-label"
local BODY_CONTAINER_ID = "body-container"
local BODY_CONTAINER_TAG = "div"
local WARNS_LIST_ID = "story-warnings-list"
local WARN_COMPONENT_CLASS = "story-warning-component"
local WARN_PENDING_ATTRIB = "data-warning-accept-pending"

local STORY_LIST_ID = "story-list"

local WARN_DESCS = {
	gore = "Graphic descriptions of violence/injury",
}


local opts = {}
local writer = lunamark.writer.html.new(opts)
do
	-- Make sure the headers found in the body are one level higher than the
	-- ones on the story page itself
	local oldHeader = writer.header

	function writer.header(s, level)
		return oldHeader(s, level + 1)
	end
end

local parseMarkdown = lunamark.reader.markdown.new(writer, opts)



local function getGenerationTimeString()
	return os.date("Automatically generated on %F %T")
end


--[[--
	Reads the contents of file in a directory. Returns nil if the file doesn't
	exist.
]]
local function read(dir, name)
	local path = pathlib.join(dir, name)

	return fs.stat(path) and fs.readFile(path) or nil
end

--[[--
	Returns an iterator which iterates over all the full paths of all non-hidden
	subdirectories in a directory.
]]
local function iterFolderPathsIn(dir)
	local iter = assert(fs.scandir(dir))

	return function()
		local info
		repeat
			info = iter()
		until not info or (info.type == "directory" and info.name:sub(1, 1) ~= ".")

		if info then
			return pathlib.join(dir, info.name), info.name
		else
			return nil, nil
		end
	end
end

local function insertFirstChild(new, parent)
	parent:insertBefore(new, parent.firstChild)
end

--[[--
	Returns the metatag whose `name` attribute matches a certain name.
]]
local function getMetaTagOfName(document, name)
	local nodes = document:getElementsByTagName("meta")

	for _, node in ipairs(nodes) do
		if node:getAttribute("name") == name then
			return node
		end
	end

	return nil
end


local function compileSinglePartWork(workId, dir)
	local metadata = yaml.eval(read(dir, "info.yaml"))

	if metadata.publish then
		print("Compiling single-part work in directory:", dir)
	else
		print("Skipping unpublished")
		return
	end

	local rawBody = parseMarkdown(read(dir, "body.md"))
	local partBodyDocument = gumbo.parse(rawBody, {
		contextElement = BODY_CONTAINER_TAG,
	})

	local page = gumbo.parseFile(PAGE_TEMPLATE_FILE)

	local pageTitleNode = page:getElementsByTagName("title")[1]
	local descMetaNode = getMetaTagOfName(page, "description")
	local titleHeaderNode = page:getElementById(TITLE_HEADER_ID)
	local versionLabelNode = page:getElementById(VERSION_LABEL_ID)
	local bodyContainerNode = page:getElementById(BODY_CONTAINER_ID)
	local warningsListNode = page:getElementById(WARNS_LIST_ID)
	local warningNodes = page:getElementsByClassName(WARN_COMPONENT_CLASS)

	local generatedAt = getGenerationTimeString()

	-- Title
	pageTitleNode.textContent = metadata.title
	titleHeaderNode.textContent = metadata.title

	-- Description
	if metadata.description then
		descMetaNode:setAttribute("content", metadata.description)
	else
		descMetaNode:remove()
	end

	-- Version
	versionLabelNode.textContent = metadata.version
	versionLabelNode:setAttribute("title", generatedAt)

	-- Generated-at comment
	insertFirstChild(page:createComment(generatedAt), page.documentElement)

	-- Content
	-- bodyContainerNode.innerHTML = rawBody -- Not implemented by gumbo yet
	for _, child in ipairs(partBodyDocument.documentElement.children) do
		bodyContainerNode:appendChild(child)
	end

	-- Warnings
	if #metadata.warnings > 0 then
		-- Append warning list items to the warnings list
		for _, warning in ipairs(metadata.warnings) do
			local itemNode = page:createElement("li")
			itemNode.textContent = assert(WARN_DESCS[warning], "invalid warning")

			warningsListNode:appendChild(itemNode)
		end
	else
		-- Remove all warning-related nodes and attributes
		for _, componentNode in ipairs(warningNodes) do
			componentNode:remove()
		end
		page.body:removeAttribute(WARN_PENDING_ATTRIB)
	end


	-- Create folder
	local compiledDirName = pathlib.join(COMPILED_STORIES_DIR, workId)
	print("Creating story directory:", compiledDirName)
	fs.mkdir(compiledDirName)

	-- Create index.html
	local indexFileName = pathlib.join(compiledDirName, "index.html")
	print("Writing to file:", indexFileName)
	fs.writeFile(indexFileName, page:serialize())


	return {
		title = metadata.title,
		dirName = workId,
	}
end

local function updateIndex(infos)
	-- Parse story index file
	local indexDocument = gumbo.parseFile(STORY_INDEX_FILE)
	local storyList = indexDocument:getElementById(STORY_LIST_ID)

	-- Append autogeneration notice
	storyList:appendChild(
		indexDocument:createComment(getGenerationTimeString())
	)

	-- Sort by title
	table.sort(infos, function(a, b)
		return a.title < b.title
	end)

	-- Create link and list item for each story
	for _, info in ipairs(infos) do
		local textNode = indexDocument:createTextNode(info.title)

		local linkNode = indexDocument:createElement("a")
		linkNode:setAttribute("href", "./" .. info.dirName)
		linkNode:appendChild(textNode)

		local itemNode = indexDocument:createElement("li")
		itemNode:appendChild(linkNode)

		storyList:appendChild(itemNode)
	end

	print("Writing to story index file")
	fs.writeFile(STORY_INDEX_FILE, indexDocument:serialize())
end



--- LOGIC STARTS ---

local compilationInfos = {}
local clonedDir = args[2]
print("Cloned directory:", clonedDir)

-- Compile stories
for path, workId in iterFolderPathsIn(clonedDir) do
	local compilationInfo = compileSinglePartWork(workId, path)
	if compilationInfo then
		print("Compiled story:", compilationInfo.title, compilationInfo.dirName)

		table.insert(compilationInfos, compilationInfo)
	end
end

-- Update story index file
updateIndex(compilationInfos)