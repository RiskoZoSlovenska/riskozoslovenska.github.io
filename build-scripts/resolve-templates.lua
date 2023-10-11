local plt = require("pl.template")
local utils = require("build-scripts.utils")

local DIR = "build"

local stack = { DIR }
while stack[1] do
	for name, fullPath, isDir in utils.iterdir(table.remove(stack)) do
		if isDir then
			table.insert(stack, fullPath)
			goto continue
		end

		if name:find("%.plt$") then
			local raw = assert(utils.readfile(fullPath))
			local outContent = assert(plt.substitute(raw, { _parent = _G }))
			local outPath, _ = utils.path.splitext(fullPath) -- Just remove the .plt extension

			print(string.format("Rendering template %s -> %s", fullPath, outPath))
			assert(os.remove(fullPath))
			assert(utils.writefile(outPath, outContent))
		end

		::continue::
	end
end

print("TEMPLATES DONE")
