local b = {}

local api = vim.api
local icons   = require('jd.sl.devicon')
local builder = require('jd.sl.builder')

local getBufLabel = function(n)
	local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(n), ":t")
	if filename == '' then
		filename = "[No name]"
	end
	filename = icons.deviconTable[filename]..' '..filename
	if vim.bo[n].readonly then
		filename = filename.."🔐"
	end
	if vim.bo[n].modified then
		filename = filename.."[+]"
	end
	return filename
end

function BufferLine()
	b.active_bufs = {}
	local bufferline = ''
	local buf_list = api.nvim_list_bufs()
	local current_buf = api.nvim_get_current_buf()
	for _, val in pairs(buf_list) do
		if api.nvim_buf_is_loaded(val) and vim.bo[val].buftype ~= 'nofile' then
			table.insert(b.active_bufs, val)
			local bufHi = "SlBufferLine"..(val == current_buf and "Sel" or "")
			bufferline = bufferline..builder.item(bufHi,getBufLabel(val))
		end
	end
	return bufferline
end

-- Buffer jumping
function b.jumpBuf(buf)
	if b.active_bufs then
		vim.cmd("b!"..b.active_bufs[math.min(#b.active_bufs,buf)])
	else
		vim.cmd [[echom "no BufferLine"]]
	end
end

for i=1,9 do
	api.nvim_set_keymap('', '<A-'..i..'>', "<cmd>lua require'jd.sl.buffers'.jumpBuf("..i..")<CR>", {noremap = true, silent = true})
end


return b
