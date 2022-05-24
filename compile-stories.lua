local fs = require("coro-fs")
local pathlib = require("path")

local lunamark = require("lunamark")
local gumbo = require("gumbo")
local yaml = require("yaml")

local COMPILED_STORIES_DIR = "./stories/"
local STORY_INDEX_FILE = "./stories/index.html"
local TEMPLATE_FILE = "./assets/story-template.html"

local STORY_PARENT_ELEMENT = "main"
local WARN_OVERLAY_ID = "warning-overlay"
local WARN_COMPONENT_CLASS = "story-warning-component"
local VERSION_LABEL_ID = "version-label"
local ASIDED_HEADER_CLASS = "asided-header"
local WARNS_ATTRIB_NAME = "data-warnings"
local STORY_LIST_ID = "story-list"

-- TODO: Support for other files and such


local opts = {}
local writer = lunamark.writer.html.new(opts)
local parseMarkdown = lunamark.reader.markdown.new(writer, opts)



local function getGenerationTimeString()
	return os.date("Automatically generated on %F %T")
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

		return info and pathlib.join(dir, info.name) or nil -- Make full path
	end
end


local function cleanTitle(title)
	return title
		:gsub("%W+", "_") -- Replace all non-alphanum sequences with a '_'
		:match("^_?(.+)_?$") -- Remove leading/trailing '_'s
		:lower()
end

-- Truncates a string to a max codepoints length, possibly appending an ellipsis
local function truncate(str, max)
	if utf8.len(str) > max then
		local stringEnd = utf8.offset(str, max) - 1 -- Get end of previous char
		return str:sub(1, stringEnd) .. "…"
	else
		return str
	end
end
assert(truncate("…..…", 2) == "……") -- Quick test


-- Correctly appends to an element's class list string
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
	reference.parentNode:insertBefore(new, reference.nextSibling)
end

local function insertFirstChild(new, parent)
	parent:insertBefore(new, parent.firstChild)
end

--[[--
	Looks for a <meta> tag that matches a certain name, and then overwrites one
	of its attributes.
]]
local function setMetaTag(document, name, attribName, attribValue)
	local nodes = document:getElementsByTagName("meta")

	for _, node in ipairs(nodes) do
		if node:getAttribute("name") == name then
			node:setAttribute(attribName, attribValue)
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

	return {
		title = title,
		dirName = cleanTitle(title),
		content = pageDocument:serialize(),
	}
end

local function removeCompiled(dir)
	if fs.stat(pathlib.join(dir, "index.html")) then -- Check whether exists
		print("Removing existing story directory:", dir)
		fs.rmrf(dir)
	end
end

local function addCompiled(dir, compiledInfo)
	-- Create folder
	local dirName = pathlib.join(dir, compiledInfo.dirName)
	print("Creating story directory:", dirName)
	fs.mkdir(dirName)

	-- Create index.html
	local mainName = pathlib.join(dirName, "index.html")
	print("Writing to file:", mainName)
	fs.writeFile(mainName, compiledInfo.content)
end

local function updateIndex(infos)
	-- Parse story index file
	local indexDocument = gumbo.parseFile(STORY_INDEX_FILE)
	local storyList = indexDocument:getElementById(STORY_LIST_ID)

	-- Remove all children of list
	while storyList.firstChild do
		storyList:removeChild(storyList.lastChild)
	end

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

	--[[
		For whatever reason, gumbo adds an extra newline right after the
		</main> tag and these newlines accumulate. This is a HACK to get rid
		of them.
	]]
	local content = indexDocument:serialize()
		:gsub("</main>%s*</body>%s*</html>%s*$", "</main>\n</body></html>")

	print("Writing to story index file")
	fs.writeFile(STORY_INDEX_FILE, content)
end



--- LOGIC STARTS ---

local compiledInfos = {}
local clonedDir = args[2]
print("Cloned directory:", clonedDir)

-- Remove existing folders
for path in iterFolderPathsIn(COMPILED_STORIES_DIR) do
	removeCompiled(path)
end

-- Compile stories
for path in iterFolderPathsIn(clonedDir) do
	local compiledInfo = compileStory(path)
	if not compiledInfo then goto continue end

	print("Compiled story:", compiledInfo.title, compiledInfo.dirName)
	addCompiled(COMPILED_STORIES_DIR, compiledInfo) -- Create the folder
	table.insert(compiledInfos, compiledInfo)

	::continue::
end

-- Update story index file
updateIndex(compiledInfos)