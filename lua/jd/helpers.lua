local k = vim.keymap

-- helper keymap functions (map, nmap, imap, ...)
for _,mode in ipairs({"", "i", "v", "n", "c", "t", "x", "o"}) do
	_G[mode.."map"] = function(tbl)
		k.set(mode, tbl[1], tbl[2], tbl[3])
	end
end

function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, {...})
	print(unpack(objects))
end

function _G.P(...)
    vim.pretty_print(...)
end

