local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end
local lspconfig_util = require "lspconfig.util"
local map_tele = require "jd.telescope.mappings"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function()
	local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
	if filetype ~= 'tex' and filetype ~= 'lua' then
		nmap { 'K', vim.lsp.buf.hover, {silent=true, buffer=0}}
	end

	nmap { '[e',         vim.diagnostic.goto_prev,                           {silent=true, buffer=0}}
	nmap { ']e',         vim.diagnostic.goto_next,                           {silent=true, buffer=0}}
	nmap { '<leader>vD', function() vim.diagnostic.open_float(0,{scope="line"}) end,        {silent=true, buffer=0}}
	imap { '<c-s>',      vim.lsp.buf.signature_help,                         {silent=true, buffer=0}}
	nmap { 'gD',         vim.lsp.buf.declaration,                            {silent=true, buffer=0}}
	nmap { 'gT',         vim.lsp.buf.type_definition,                        {silent=true, buffer=0}}
	nmap { '<leader>vd', vim.lsp.buf.definition,                             {silent=true, buffer=0}}
	nmap { '<leader>vs', vim.lsp.buf.signature_help,                         {silent=true, buffer=0}}
	nmap { 'gR',         vim.lsp.buf.rename,                                 {silent=true, buffer=0}}
	nmap { 'gH',         vim.lsp.buf.hover,                                  {silent=true, buffer=0}}
	nmap { 'gF',         vim.lsp.buf.formatting,                             {silent=true, buffer=0}}
	nmap { 'gA',         vim.lsp.buf.code_action,                            {silent=true, buffer=0}}
	nmap { '<leader>vS', require'lspconfig'["_root"].commands["LspStop"][1], {silent=true, buffer=0}}
	nmap { '<leader>vI', require'lspconfig'["_root"].commands["LspInfo"][1], {silent=true, buffer=0}}

	map_tele("gr",         "lsp_references",                nil,                        true)
	map_tele("gd",		   "lsp_definitions",				nil,						true)
	map_tele("gI",         "lsp_implementations",           nil,                        true)
	map_tele("<leader>wd", "lsp_document_symbols",          { ignore_filename = true }, true)
	map_tele("<leader>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

	vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = require('cmp_nvim_lsp').update_capabilities(updated_capabilities)

-- local servers = {'vimls', 'clangd', 'texlab', 'bashls', 'sumneko_lua'}
local servers = {
	vimls = false,
	texlab = true,
	-- ltex = true,
	bashls = true,
	clangd = {
		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = 50,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- Enable underline, use default values
		underline = true,
		-- Enable virtual text, override spacing to 4
		virtual_text = {
			spacing = 4,
			prefix = '',
		},
		-- Enable a feature
		update_in_insert = true,
	}
)

require('nlua.lsp.nvim').setup(lspconfig, {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,

	root_dir = function(fname)
		if string.find(vim.fn.fnamemodify(fname, ":p"), ".config/nvim/") then
			return vim.fn.expand "~/.config/nvim/"
		end

		-- ~/git/config_manager/xdg_config/nvim/...
		return lspconfig_util.find_git_ancestor(fname) or lspconfig_util.path.dirname(fname)
	end,

	-- Include globals you want to tell the LSP are real :)
	globals = {
		-- Colorbuddy
		"Color", "c", "Group", "g", "s", "map", "imap", "vmap", "nmap", "cmap",
		"tmap", "xmap", "omap"
	},
})

-- ## was sometimes needed
-- vim.cmd [[LspStart]]
