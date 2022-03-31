local fs = require("coro-fs")
local pathlib = require("path")
local json = require("json")

local gumbo = require("gumbo")

local SEARCHABLE_ATTRIB = "data-searchable"

local RES_FILE_PATH = "search_data.json"
local IGNORE_PATHS = {
	"assets",
}



local function joinTables(tbl1, tbl2)
	local len = #tbl1

	for i, value in ipairs(tbl2) do
		tbl1[len + i] = value
	end

	return tbl1
end


local function mustIgnorePath(path)
	for _, mustIgnore in ipairs(IGNORE_PATHS) do
		if pathlib.pathsEqual(mustIgnore, path) then
			return true
		end
	end

	return false
end

local function cleanFilePath(path)
	-- Remove trailing "index.html"
	if pathlib.basename(path) == "index.html" then
		path = pathlib.dirname(path)
	end

	-- Remove leading comma
	if path:sub(1, 1) ~= "/" then
		path = "/" .. path
	end

	return path
end

local function countWordsInString(str)
	local words = {}

	for word in string.gmatch(str:lower(), "%w+") do
		words[word] = (words[word] or 0) + 1
	end

	return words
end

local function getDataForFile(path)
	local document = gumbo.parseFile(path)

	if not document.body:hasAttribute(SEARCHABLE_ATTRIB) then
		print("Not searchable: " .. path)

		return nil, nil
	else
		print("Searchable: " .. path)

		local text = document.body.textContent

		return {
			title = document.title,
			counts = countWordsInString(text),
			link = cleanFilePath(path),
		}
	end
end

local function addFileDataToMainData(mainData, fileData, nextFileIndex)
	local mainCounts = mainData.counts

	-- Add to the counts table
	for word, count in pairs(fileData.counts) do
		local countsArr = mainCounts[word]
		if not countsArr then
			countsArr = {}
			mainCounts[word] = countsArr
		end

		table.insert(countsArr, nextFileIndex)
		table.insert(countsArr, count)
	end

	-- Add others
	table.insert(mainData.links, fileData.link)
	table.insert(mainData.titles, fileData.title)
end

local function addFolderDataToMainData(mainData, folderData)
	-- Merge counts
	for word, countsArr in pairs(folderData.counts) do
		local mainCountsArr = mainData.counts[word]

		if not mainCountsArr then
			mainData.counts[word] = countsArr
		else
			joinTables(mainCountsArr, countsArr)
		end
	end

	joinTables(mainData.links, folderData.links)
	joinTables(mainData.titles, folderData.titles)
end


local function getDataForFolder(path, startFileIndex)
	local data = {
		counts = {},
		links = {},
		titles = {}
	}
	local nextFileIndex = startFileIndex or 0

	for info in fs.scandir(path) do
		local newPath = pathlib.join(path, info.name)

		if mustIgnorePath(newPath) then
			print("Ignoring: " .. newPath)
			goto continue

		elseif info.type == "directory" then
			local folderData; folderData, nextFileIndex = getDataForFolder(newPath, nextFileIndex)

			addFolderDataToMainData(data, folderData)

		elseif info.name:find(".%.html$") then
			local fileData = getDataForFile(newPath)

			if fileData then
				addFileDataToMainData(data, fileData, nextFileIndex)

				nextFileIndex = nextFileIndex + 1
			end
		end

		::continue::
	end

	return data, nextFileIndex
end


local data = getDataForFolder(".")
local encoded = json.encode(data)
fs.writeFile(RES_FILE_PATH, encoded)

print("Finished")