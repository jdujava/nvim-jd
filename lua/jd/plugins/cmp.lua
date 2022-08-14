local present, cmp = pcall(require, "cmp")

if not present then
	return
end

vim.opt.completeopt = { "menu", "menuone", "noselect"}

cmp.setup {
	completion = {completeopt = 'menu,menuone,noinsert'},
	snippet = {
		expand = function(args)
			-- require("luasnip").lsp_expand(args.body)
			vim.fn['UltiSnips#Anon'](args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- load lspkind icons
			vim_item.kind = string.format(
				"%s %s",
				require("jd.plugins.lspkind_icons").icons[vim_item.kind],
				vim_item.kind
			)

			-- set a name for each source
			vim_item.menu = ({
				treesitter    = "[T]",
				nvim_lsp      = "[L]",
				nvim_lua      = "[L]",
				ultisnips     = "[S]",
				luasnip       = "[S]",
				buffer        = "[B]",
				look          = "[W]",
				path          = "[P]",
				latex_symbols = "[λ]",
				emoji         = "[E]",
				calc          = "[C]",
			})[entry.source.name]

			return vim_item
		end,
	},
	experimental = {
		-- ghost_text = {
		-- 	hl_group = "CmpGhostText",
		-- },
	},
	window = {
		completion = cmp.config.window.bordered({
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
			winhighlight = 'Normal:CmpBorderedWindow_Normal,FloatBorder:CmpBorderedWindow_FloatBorder,CursorLine:CmpBorderedWindow_CursorLine,Search:None'
		}),
		documentation = cmp.config.window.bordered({
			border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
			winhighlight = 'Normal:CmpBorderedWindow_Normal,FloatBorder:CmpBorderedWindow_FloatBorder,CursorLine:CmpBorderedWindow_CursorLine,Search:None'
		}),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i"}),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i"}),
		["<C-l>"] = cmp.mapping(
			cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			},
			{ "i", "c" }
		),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		-- ['<C-e>'] = cmp.mapping({
		-- 	i = cmp.mapping.abort(),
		-- 	c = cmp.mapping.abort(),
		-- 	-- c = cmp.mapping.close(),
		-- }),
        ["<C-Space>"] = cmp.mapping(
			function()
				if cmp.visible() then
					if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
						return vim.fn["UltiSnips#ExpandSnippet"]()
					end

					cmp.select_next_item()
				else
					cmp.complete()
				end
			end,
			{ "i", "s", "c" }
		),
	}),
	sources = cmp.config.sources({
		-- { name = 'treesitter' },
		-- { name = "nvim_lua", ft='lua' },
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = 'emoji' },
		-- { name = "look" },
		-- { name = "latex_symbols" },
		-- { name = 'calc' },
	}),
	-- sorting = {
	-- 	comparators = {
	-- 		cmp.config.compare.offset,
	-- 		cmp.config.compare.exact,
	-- 		cmp.config.compare.score,
	-- 		cmp.config.compare.kind,
	-- 		-- cmp.config.compare.sort_text,
	-- 		cmp.config.compare.length,
	-- 		cmp.config.compare.order,
	-- 	}
	-- },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- vim.cmd[[autocmd FileType firenvim lua require('cmp').setup.buffer { enabled = false }]]
