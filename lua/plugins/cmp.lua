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
            { 'quangnguyen30192/cmp-nvim-ultisnips', dependencies = { 'ultisnips' } },
        },
        config = function()
            local cmp = require('cmp')

            local winhighlight = table.concat({
                'Normal:Pmenu',
                'FloatBorder:FloatBorder',
                'CursorLine:PmenuSel',
                'Search:None',
            }, ',')

            cmp.setup({
                completeopt = vim.o.completeopt,
                snippet = {
                    expand = function(args)
                        vim.fn['UltiSnips#Anon'](args.body)
                    end,
                },
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
                    ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(function()
                        if cmp.visible() then
                            if vim.fn['UltiSnips#CanExpandSnippet']() == 1 then
                                return vim.fn['UltiSnips#ExpandSnippet']()
                            end
                            return cmp.select_next_item()
                        end
                        cmp.complete()
                    end, { 'i', 's', 'c' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'ultisnips' },
                    { name = 'path' },
                }, { -- extra sources
                    { name = 'buffer' },
                    { name = 'emoji' },
                }),
            })

            -- Use cmdline & path source for ':'.
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
            })
        end,
    },
}
