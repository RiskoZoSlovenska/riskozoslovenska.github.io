local pl_path = require("pl.path")
local pl_utils = require("pl.utils")


local function iterdir(dir)
	local iter, dir_obj = pl_path.dir(dir)

	return function()
		::retry::

		local name = iter(dir_obj)
		if not name then
			return nil, nil, nil
		elseif name == "." or name == ".." then
			goto retry
		end

		local full = pl_path.join(dir, name)
		return name, full, pl_path.isdir(full)
	end
end


return {
	path = pl_path,
	readfile = pl_utils.readfile,
	writefile = pl_utils.writefile,
	iterdir = iterdir,
}
