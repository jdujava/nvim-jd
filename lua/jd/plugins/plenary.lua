function _G.P(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	function _G.R(name)
		RELOAD(name)
		return require(name)
	end
end

