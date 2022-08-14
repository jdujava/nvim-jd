local has_status, lsp_status = pcall(require, "lsp-status")
if not has_status then
  return false
end

local status = {}

status.select_symbol = function(cursor_pos, symbol)
	if symbol.valueRange then
		local value_range = {
			["start"] = {
				character = 0,
				line = vim.fn.byte2line(symbol.valueRange[1])
			},
			["end"] = {
				character = 0,
				line = vim.fn.byte2line(symbol.valueRange[2])
			}
		}

		return require("lsp-status.util").in_range(cursor_pos, value_range)
	end
end

status.activate = function()
	lsp_status.config {
		select_symbol = status.select_symbol,

		indicator_errors = '',
		indicator_warnings = '',
		indicator_info = '🛈',
		indicator_hint = '!',
		indicator_ok = '',
		spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
	}

	lsp_status.register_progress()
end

status.on_attach = function(client)
	lsp_status.on_attach(client)

	vim.cmd [[augroup my_lsp_status]]
	vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
	vim.cmd [[augroup END]]
end


status.status = function()
	return lsp_status.status()
end

status.current_function = function()
	local current_func = vim.b.lsp_current_function
	if current_func and #current_func > 0 then
		return string.format('[ %s ]', current_func)
	end

	return ''
end

status.server_progress = function()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffer_clients = vim.lsp.buf_get_clients(current_buf)
	local buffer_client_set = {}
	for _, v in pairs(buffer_clients) do
		buffer_client_set[v.name] = true
	end
	-- dump(current_buf)

	local all_messages = lsp_status.messages()

	for _, msg in ipairs(all_messages) do
		if msg.name and buffer_client_set[msg.name] then
			local contents = ''
			if msg.progress then
				contents = msg.title
				if msg.message then
					contents = contents .. ' ' .. msg.message
				end

				if msg.percentage then
					contents = contents .. ' (' .. msg.percentage .. ')'
				end

				if msg.spinner then
					contents = lsp_status.config.spinner_frames[(msg.spinner % #lsp_status.config.spinner_frames) + 1] .. ' ' .. contents
				end
			elseif msg.status then
				contents = msg.content
			else
				contents = msg.content
			end

			return ' ' .. contents .. ' '
		end
	end

	return ''
end

return status
