--[[--
	Goes through all the HTML files in the website and compiles them into a
	search_data.json object. All elements (and their descendants) with the
	`data-unsearchable` atttribute are removed prior to parsing. If the body is
	thusly removed, the page is ignored completely. For the specification of the
	resulting object, see /assets/scripts/search.js.
]]

local utils = require("build-scripts.utils")
local json = require("dkjson")
local gumbo = require("gumbo")

local UNSEARCHABLE_ATTRIB = "data-unsearchable"

local SITE_DIR = "build"
local RES_FILE_PATH = "build/search_data.json"
local IGNORE_PATHS = { -- Paths to fully ignore
	"build/assets",
}



local function mustIgnorePath(path)
	for _, mustIgnore in ipairs(IGNORE_PATHS) do
		if utils.path.normpath(mustIgnore) == utils.path.normpath(path) then
			return true
		end
	end

	return false
end

local function pathToLink(path)
	-- Make relative
	path = utils.path.relpath(utils.path.abspath(path), utils.path.abspath(SITE_DIR))

	-- Remove trailing extension and "index.html"
	path = path
		:gsub("/index%.html$", "/")
		:gsub("%.html$", "")

	return path
end

local function countWordsInString(str)
	local words = {}

	-- (’ (U+2019) should be handled the same as ')
	for word in str:gsub("\u{2019}", "'"):lower():gmatch("[%w']+") do
		word = word:gsub("%W+", "") -- We only care about alphanumerics
		words[word] = (words[word] or 0) + 1
	end

	return words
end

local function addDataForFile(data, fileIndex, path)
	local document = gumbo.parseFile(path)

	-- Remove all unsearchable elements
	for element in document.documentElement:walk() do
		if element.hasAttribute and element:hasAttribute(UNSEARCHABLE_ATTRIB) then
			element:remove()
		end
	end

	local body = document:getElementsByTagName("body")[1]
	if not body then
		print("Not searchable: " .. path)
		return false
	else
		print("Searchable: " .. path)
	end

	-- Count and insert words
	for word, count in pairs(countWordsInString(body.textContent)) do
		local arr = data.counts[word]
		if not arr then
			-- Create pair if it doesn't exist
			arr = {}
			data.counts[word] = arr
		end

		table.insert(arr, fileIndex)
		table.insert(arr, count)
	end

	-- Insert link and title
	-- Must account for the fact that Lua arrays start at 1
	data.titles[fileIndex + 1] = document.title
	data.links[fileIndex + 1] = pathToLink(path)

	return true
end

local function getDataForFolder(startPath)
	local pathStack = { startPath }
	local data = {
		counts = {},
		links = {},
		titles = {},
	}
	local nextFileIndex = 0

	while pathStack[1] do
		for name, fullPath, isDir in utils.iterdir(table.remove(pathStack)) do
			if mustIgnorePath(fullPath) then
				print("Ignoring: " .. fullPath) -- Ignore

			elseif isDir then
				table.insert(pathStack, fullPath) -- Push to stack

			elseif name:find(".%.html$") then
				if addDataForFile(data, nextFileIndex, fullPath) then -- Process
					nextFileIndex = nextFileIndex + 1
				end
			end
		end
	end

	return data
end


--- LOGIC STARTS ---

local data = getDataForFolder(SITE_DIR)
local encoded = json.encode(data)

print("Writing to " .. RES_FILE_PATH)
assert(utils.writefile(RES_FILE_PATH, encoded))

print("SEARCH DATA DONE")
