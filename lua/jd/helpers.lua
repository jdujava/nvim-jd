local k = vim.keymap

-- termcodes like \<Tab>
function _G.termcode(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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
