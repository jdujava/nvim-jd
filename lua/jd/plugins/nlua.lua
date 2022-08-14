require('nlua.lsp.nvim').setup(require('lspconfig'), {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,

	-- Include globals you want to tell the LSP are real :)
	globals = {
		-- Colorbuddy
		"Color", "c", "Group", "g", "s",
	},
})

