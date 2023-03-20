return {
    {
        "hrsh7th/nvim-cmp",
        event = 'VeryLazy',
        config = function()
            local cmp = require("cmp")

            local winhighlight = table.concat({
                "Normal:CmpBorderedWindow_Normal",
                "FloatBorder:CmpBorderedWindow_FloatBorder",
                "CursorLine:CmpBorderedWindow_CursorLine",
                "Search:None",
            }, ",")

            local CmpHighlights = {
                CmpGhostText = { fg = '#767676', bg = 'NONE' },
                CmpItemAbbr = { link = 'CmpGhostText' },
                CmpItemAbbrMatch = { fg = '#dbe2ef', bg = 'NONE' },
                CmpItemAbbrDeprecated = { underline = true },
                CmpBorderedWindow_Normal = { bg = '#202020' },
                CmpBorderedWindow_CursorLine = { bg = '#252525', bold = true },
                CmpBorderedWindow_FloatBorder = { bg = '#1e1e1e' },

                CmpItemKind = { bg = 'NONE', fg = '#569cd6' },
                CmpItemKindDefault = { bg = 'NONE', fg = '#569cd6' },
                CmpItemKindFunction = { bg = 'NONE', fg = '#C586C0' },
                CmpItemKindMethod = { bg = 'NONE', fg = '#C586C0' },
                CmpItemKindVariable = { bg = 'NONE', fg = '#9CDCFE' },
                CmpItemKindKeyword = { bg = 'NONE', fg = '#D4D4D4' },
            }
            for hl, col in pairs(CmpHighlights) do
                vim.api.nvim_set_hl(0, hl, col)
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn['UltiSnips#Anon'](args.body)
                    end,
                },
                formatting = {
                    format = function(entry, vim_item)
                        -- load lspkind icons
                        vim_item.kind = string.format(
                            "%s %s",
                            require("plugins.lsp.lspkind_icons").icons[vim_item.kind],
                            vim_item.kind
                        )

                        -- set a name for each source
                        vim_item.menu = ({
                            nvim_lsp      = "[L]",
                            ultisnips     = "[S]",
                            path          = "[P]",
                            buffer        = "[B]",
                            emoji         = "[E]",
                        })[entry.source.name]

                        return vim_item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered { winhighlight = winhighlight },
                    documentation = cmp.config.window.bordered { winhighlight = winhighlight },
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping(
                        function()
                            return cmp.select_prev_item() or cmp.complete()
                        end,
                        { "i", "c" }
                    ),
                    ["<C-n>"] = cmp.mapping(
                        function()
                            return cmp.select_next_item() or cmp.complete()
                        end,
                        { "i", "c" }
                    ),
                    ["<C-l>"] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { "i", "c" }
                    ),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-Space>"] = cmp.mapping(
                        function()
                            if cmp.visible() then
                                if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
                                    return vim.fn["UltiSnips#ExpandSnippet"]()
                                end
                                return cmp.select_next_item()
                            end
                            cmp.complete()
                        end,
                        { "i", "s", "c" }
                    ),
                }),
                sources = cmp.config.sources(
                    { -- main sources
                        { name = 'nvim_lsp' },
                        { name = 'ultisnips' },
                        { name = 'path' },
                    },
                    { -- extra sources
                        { name = 'buffer' },
                        { name = 'emoji' },
                    }
                ),
            }

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    {{ name = 'path' }},
                    {{ name = 'cmdline' }}
                )
            })
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-emoji",
            {"quangnguyen30192/cmp-nvim-ultisnips", dependencies = {"ultisnips"}},
        },
    },
}
