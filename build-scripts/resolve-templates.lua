local plt = require("pl.template")
local utils = require("build-scripts.utils")

local TEMPLATES_DIR = "build-templates"
local FILES_DIR = "build"

-- Load templates
local templates = {
	_parent = _G
}
for name, fullPath in utils.iterdir(TEMPLATES_DIR) do
	local raw = assert(utils.readfile(fullPath))
	local template = assert(plt.compile(raw))
	local templateName = name:match("^[%w_]+")

	templates[templateName] = function(env)
		return template:render({
			env = env,
		}, _G)
	end
	print("Loaded template " .. templateName)
end

-- Apply templates
local stack = { FILES_DIR }
while stack[1] do
	for name, fullPath, isDir in utils.iterdir(table.remove(stack)) do
		if isDir then
			table.insert(stack, fullPath)
			goto continue
		end

		if name:find("%.plt$") then
			local raw = assert(utils.readfile(fullPath))
			local outContent = assert(plt.substitute(raw, templates))
			local outPath, _ = utils.path.splitext(fullPath) -- Just remove the .plt extension

			print(string.format("Rendering template %s -> %s", fullPath, outPath))
			assert(os.remove(fullPath))
			assert(utils.writefile(outPath, outContent))
		end

		::continue::
	end
end

print("TEMPLATES DONE")
