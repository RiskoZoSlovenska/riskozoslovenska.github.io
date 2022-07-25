--[[--
	Goes through all the html files in the website and compiles then
	search_data.json object. Only pages whose body has the data-searchable
	attribute are processed.
	For the specification of the resulting object, see /assets/scripts/search.js
]]

-- TODO: Make sure parsing/processing doesn't fail on malformed HTML pages

local fs = require("coro-fs")
local pathlib = require("path")
local json = require("json")

local gumbo = require("gumbo")

local SEARCHABLE_ATTRIB = "data-searchable"

local RES_FILE_PATH = "search_data.json"
local IGNORE_PATHS = { -- Paths to fully ignore
	"assets",
}



local function mustIgnorePath(path)
	for _, mustIgnore in ipairs(IGNORE_PATHS) do
		if pathlib.pathsEqual(mustIgnore, path) then
			return true
		end
	end

	return false
end

local function pathToLink(path)
	-- Remove trailing "index.html"
	if pathlib.basename(path) == "index.html" then
		path = pathlib.dirname(path)
	end

	-- Add leading slash
	if path:sub(1, 1) ~= "/" then
		path = "/" .. path
	end

	return path
end

local function countWordsInString(str)
	local words = {}

	for word in string.gmatch(str:lower(), "[%w']+") do
		word = word:gsub("%W+", "") -- Collapse punctuation
		words[word] = (words[word] or 0) + 1
	end

	return words
end

local function addDataForFile(data, fileIndex, path)
	local document = gumbo.parseFile(path)

	if document.body:hasAttribute(SEARCHABLE_ATTRIB) then
		print("Searchable: " .. path)
	else
		print("Not searchable: " .. path)
		return false
	end

	-- Count and insert words
	for word, count in pairs(countWordsInString(document.body.textContent)) do
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
		local path = table.remove(pathStack)

		for info in fs.scandir(path) do
			local childPath = pathlib.join(path, info.name)

			if mustIgnorePath(childPath) then
				print("Ignoring: " .. childPath) -- Ignore

			elseif info.type == "directory" then
				table.insert(pathStack, childPath) -- Push to stack

			elseif info.name:find(".%.html$") then
				if addDataForFile(data, nextFileIndex, childPath) then -- Process
					nextFileIndex = nextFileIndex + 1
				end
			end
		end
	end

	return data
end


--- LOGIC STARTS ---

local data = getDataForFolder(".")
local encoded = json.encode(data)
fs.writeFile(RES_FILE_PATH, encoded)

print("Finished")