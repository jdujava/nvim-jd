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
    local buf_opts = {silent=true, buffer=0}
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype ~= 'tex' and filetype ~= 'lua' then
        nmap { 'K', vim.lsp.buf.hover, buf_opts}
    end

    nmap { '[e',         vim.diagnostic.goto_prev,                                   buf_opts}
    nmap { ']e',         vim.diagnostic.goto_next,                                   buf_opts}
    nmap { '<leader>vD', function() vim.diagnostic.open_float(0,{scope="line"}) end, buf_opts}
    imap { '<c-s>',      vim.lsp.buf.signature_help,                                 buf_opts}
    nmap { 'gD',         vim.lsp.buf.declaration,                                    buf_opts}
    nmap { 'gT',         vim.lsp.buf.type_definition,                                buf_opts}
    nmap { '<leader>vd', vim.lsp.buf.definition,                                     buf_opts}
    nmap { '<leader>vs', vim.lsp.buf.signature_help,                                 buf_opts}
    nmap { 'gR',         vim.lsp.buf.rename,                                         buf_opts}
    nmap { 'gH',         vim.lsp.buf.hover,                                          buf_opts}
    nmap { 'gF',         function() vim.lsp.buf.format { async = true } end,         buf_opts}
    nmap { 'gA',         vim.lsp.buf.code_action,                                    buf_opts}
    nmap { '<leader>vS', require'lspconfig'["_root"].commands["LspStop"][1],         buf_opts}
    nmap { '<leader>vI', require'lspconfig'["_root"].commands["LspInfo"][1],         buf_opts}

    map_tele("gr",         "lsp_references",                nil,                        true)
    map_tele("gd",         "lsp_definitions",               nil,                        true)
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
