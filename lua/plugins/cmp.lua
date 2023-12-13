return {
    {
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-emoji',
            'micangl/cmp-vimtex',
            -- WARN: ultisnips source is slow
            -- { 'quangnguyen30192/cmp-nvim-ultisnips', dependencies = { 'ultisnips', 'nvim-treesitter' } },
        },
        opts = function()
            local cmp = require('cmp')

            local winhighlight = table.concat({
                'Normal:Pmenu',
                'FloatBorder:FloatBorder',
                'CursorLine:PmenuSel',
                'Search:None',
            }, ',')

            ---@type cmp.ConfigSchema
            return {
                enabled = function()
                    return vim.g.cmp_enabled
                end,
                completeopt = vim.o.completeopt,
                -- completion = { autocomplete = false },
                snippet = {
                    expand = function(args)
                        vim.fn['UltiSnips#Anon'](args.body)
                    end,
                },
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    format = function(_, item)
                        local icons = require('plugins.lsp.lspkind_icons').icons
                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. item.kind
                        end
                        return item
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({ winhighlight = winhighlight }),
                    documentation = cmp.config.window.bordered({ winhighlight = winhighlight }),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping(function()
                        return cmp.select_prev_item() or cmp.complete()
                    end, { 'i', 'c' }),
                    ['<C-n>'] = cmp.mapping(function()
                        return cmp.select_next_item() or cmp.complete()
                    end, { 'i', 'c' }),
                    ['<C-l>'] = cmp.mapping(
                        cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        }),
                        { 'i', 'c' }
                    ),
                    ['<C-A-l>'] = cmp.mapping(
                        cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = true,
                        }),
                        { 'i', 'c' }
                    ),
                    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    -- ['<C-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    -- ['<C-Space>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
                    --             return vim.fn['UltiSnips#ExpandSnippet']()
                    --         end
                    --         return cmp.select_next_item()
                    --     end
                    --     fallback()
                    -- end, { 'i', 's', 'c' }),
                }),
                sources = cmp.config.sources({
                    { name = 'vimtex' },
                    { name = 'nvim_lsp' },
                    -- { name = 'ultisnips' }, -- slow
                    { name = 'path' },
                }, { -- extra sources
                    { name = 'buffer' },
                    { name = 'emoji' },
                }),
            }
        end,
        ---@param opts cmp.ConfigSchema
        config = function(_, opts)
            vim.g.cmp_enabled = true
            local cmp = require('cmp')

            cmp.setup(opts)

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(opts.mapping),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })
        end,
    },
}
