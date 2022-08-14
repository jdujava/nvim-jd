require('ltex-ls').setup {
	-- on_attach = custom_attach,
	-- capabilities = updated_capabilities,
	use_spellfile = false,
	filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
	settings = {
		ltex = {
			enabled = { "latex", "tex", "bib", "markdown", },
			language = "en-US",
			diagnosticSeverity = {
				PASSIVE_VOICE= "hint",
				default= "information"
			},
			sentenceCacheSize = 4000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "sk-SK",
			},
			disabledRules = {
				["en-US"] = { "PASSIVE_VOICE", "TOO_LONG_SENTENCE" }
			},
			latex = {
				commands = {
					["\\includeonly{}"] = "ignore",
					["\\qedhere"] = "ignore"
				},
				environments = {
					tikzcd = "ignore",
					verbatim = "ignore"
				},
			}
			-- dictionary = (function()
			-- 	-- For dictionary, search for files in the runtime to have
			-- 	-- and include them as externals the format for them is
			-- 	-- dict/{LANG}.txt
			-- 	--
			-- 	-- Also add dict/default.txt to all of them
			-- 	local files = {}
			-- 	for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
			-- 		local lang = vim.fn.fnamemodify(file, ":t:r")
			-- 		local fullpath = vim.fs.normalize(file, ":p")
			-- 		files[lang] = { ":" .. fullpath }
			-- 	end
			--
			-- 	if files.default then
			-- 		for lang, _ in pairs(files) do
			-- 			if lang ~= "default" then
			-- 				vim.list_extend(files[lang], files.default)
			-- 			end
			-- 		end
			-- 		files.default = nil
			-- 	end
			-- 	return files
			-- end)(),
		},
	},
}

