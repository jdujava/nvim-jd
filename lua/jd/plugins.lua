vim.cmd.packadd 'packer.nvim'

-- Start bootstrap {{{ --
local present, packer = pcall(require, 'packer')
if not present then
    local packer_path=vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
    vim.fn.delete(packer_path, "rf")

    print "Downloading packer.nvim..."
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path})

    present, packer = pcall(require, "packer")
    if present then
        print "Packer cloned successfully."
        print "( You'll need to restart now )"
        vim.cmd 'qa'
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end
-- }}} Start bootstrap --

return require('packer').startup {function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt=true} -- no lazy packer

    -- use {'folke/tokyonight.nvim', config=[[require'jd.plugins.tokyonight']]}

    use { "github/copilot.vim" }
    -- use { "zbirenbaum/copilot.lua", config=[[require'jd.plugins.copilot']], cmd = "Copilot", event = "InsertEnter"}

    -- Snippets {{{ --
    use {'SirVer/ultisnips', setup=[[require'jd.plugins.ultisnips']], event = 'CursorHold' }
    use {'L3MON4D3/LuaSnip', opt = true} -- switch to LuaSnip
    use {'honza/vim-snippets', after = 'ultisnips'}
    -- use {'reconquest/vim-pythonx', after = 'ultisnips'}
    -- }}} Snippets --
    -- Latex {{{ -- reverse search works now
    use {'lervag/vimtex', config=[[require'jd.plugins.vimtex']]}
    -- }}} Latex
    -- Nvim-cmp {{{ --
    -- use {"hrsh7th/nvim-cmp", after = "cmp-nvim-lsp", config = [[require'jd.plugins.cmp']]}
    use {"hrsh7th/nvim-cmp", config = [[require'jd.plugins.cmp']], event = 'CursorHold' }
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {"ultisnips", "nvim-cmp"}}
    use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-emoji", after = "nvim-cmp"}
    -- }}} Nvim-cmp --
    -- LSP {{{ --
    use {'williamboman/mason.nvim', config = [[require'jd.plugins.mason']], after = 'cmp-nvim-lsp'}
    use {'williamboman/mason-lspconfig.nvim', config = function() require('mason-lspconfig').setup() end, after = 'mason.nvim'}
    use {'neovim/nvim-lspconfig', config = [[require'jd.plugins.lsp']], after = 'mason-lspconfig.nvim'}

    use {'j-hui/fidget.nvim', config = [[require'jd.plugins.fidget']], after = 'nvim-lspconfig'}
    -- }}} LSP --
    -- Treesitter {{{ --
    use {'nvim-treesitter/nvim-treesitter', config=[[require'jd.plugins.treesitter']], event = 'CursorHold', run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
    end } -- better highlight
    use {'nvim-treesitter/playground', after = 'nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-context', config=[[require'jd.plugins.treesitter-context']], after = 'nvim-treesitter' }
    use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
    -- use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true}
    -- use {'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter'}

    -- }}} Treesitter --
    -- Telescope {{{ --
    -- use 'norcalli/nvim_utils' -- neovim lua utils
    use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']], event = 'CursorHold' }
    -- use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']]}

    use {'kyazdani42/nvim-web-devicons', config=function()
        require("nvim-web-devicons").set_default_icon('', '#8b929f')
    end}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'plenary.nvim'}
    use {'fhill2/telescope-ultisnips.nvim', after = 'telescope-fzf-native.nvim'}
    use {'~/.config/nvim/bundle/telescope-messages.nvim', after = 'telescope-ultisnips.nvim'}
    use {"tami5/sqlite.lua", after = 'telescope-messages.nvim'}
    use {"nvim-telescope/telescope-frecency.nvim", after = 'sqlite.lua'}
    use {'nvim-telescope/telescope-ui-select.nvim', after = 'telescope-frecency.nvim'}
    use {'nvim-telescope/telescope.nvim', after = 'telescope-ui-select.nvim',
        config = function()
            require'jd.telescope'
            require'jd.telescope.mappings'
        end,
    }

    -- Packer
    -- use({
    --     "folke/noice.nvim",
    --     config = function()
    --         require("noice").setup({
    --             lsp = {
    --                 -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true,
    --                 },
    --             },
    --             -- you can enable a preset for easier configuration
    --             presets = {
    --                 bottom_search = false, -- use a classic bottom cmdline for search
    --                 command_palette = true, -- position the cmdline and popupmenu together
    --                 long_message_to_split = true, -- long messages will be sent to a split
    --                 inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --                 lsp_doc_border = false, -- add a border to hover docs and signature help
    --             },
    --             routes = {
    --                 {
    --                     view = "notify",
    --                     filter = { event = "msg_showmode" },
    --                 },
    --                 {
    --                     filter = {
    --                         event = "msg_show",
    --                         kind = "search_count",
    --                     },
    --                     opts = { skip = true },
    --                 },
    --             },
    --         })
    --     end,
    --     requires = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --     }
    -- })
    use {'rcarriga/nvim-notify', config=[[require'jd.plugins.notify']], after = 'telescope.nvim' }

    -- }}} Telescope --
    -- Misc {{{ --

    -- use { 'glacambre/firenvim',
    --  run = function() vim.fn['firenvim#install'](0) end,
    --  config=[[require'jd.plugins.firenvim']],
    -- }
    use {'voldikss/vim-floaterm', config=[[require'jd.plugins.vim-floaterm']], event = 'CursorHold' }
    use {'mbbill/undotree', event = 'CursorHold',
        config = function()
            vim.g.undotree_WindowLayout = 2
            nmap { 'U', '<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>', {silent=true}}
        end
    }
    use {'~/.config/nvim/bundle/deadkeys', event = 'CursorHold',
        config = function()
            nmap { '<A-d>', '<Plug>DeadKeysToggle'}
            imap { '<A-d>', '<Plug>DeadKeysToggle'}
        end
    }
    use {'~/.config/nvim/bundle/indent-object', event = 'CursorHold',
        config = function()
            nmap { '<leader>I', '^vio<C-V>I', {remap=true}}
            nmap { '<leader>A', '^vio<C-V>$A', {remap=true}}
        end
    }
    -- use {'tweekmonster/startuptime.vim', event = 'CursorHold',
    --     config = function()
    --         nmap { '<A-S>', ':StartupTime<CR>' }
    --     end
    -- }
    use {'dstein64/vim-startuptime', event = 'CursorHold',
        config = function()
            nmap { '<A-S>', [[<CMD>StartupTime --tries 10<CR>]] }
        end
    }

    use {'asiryk/auto-hlsearch.nvim', event = 'CursorHold',
        config = function()
            require("auto-hlsearch").setup {
                remap_keys = { "/", "?", "*", "#", "n", "N" },
            }
        end
    }
    use {'norcalli/nvim-colorizer.lua', branch = 'color-editor', event = 'CursorHold',
        config = function()
            nmap { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>' }
            nmap { '<Leader><Leader>C', require'colorizer'.color_picker_on_cursor }
        end
    } -- high-performance color highlighter for Neovim
    use {'junegunn/vim-easy-align', config=[[require'jd.plugins.vim-easy-align']], event = 'CursorHold'}
    use {'tpope/vim-unimpaired', event = 'CursorHold'} -- mappings with [ and ]
    use {'numToStr/Comment.nvim', config=[[require'jd.plugins.Comment']], event = 'CursorHold'} -- comments
    use {'kylechui/nvim-surround', config=[[require'jd.plugins.nvim-surround']], event = 'CursorHold'}
    use {'lewis6991/gitsigns.nvim', config=[[require'jd.plugins.gitsigns']], after = 'plenary.nvim'}
    -- }}} Misc --

    -- use {
    --     "nvim-neorg/neorg",
    --     config = function()
    --         require('neorg').setup {
    --             load = {
    --                 ["core.defaults"] = {}, -- Loads default behaviour
    --                 ["core.norg.concealer"] = {
    --                     config = {
    --                         dim_code_blocks = {
    --                             padding = { left = 5, right = 5},
    --                             width = "content",
    --                         },
    --                     },
    --                 }, -- Adds pretty icons to your documents
    --                 ["core.norg.dirman"] = { -- Manages Neorg workspaces
    --                     config = {
    --                         workspaces = {
    --                             notes = "~/notes",
    --                         },
    --                         default_workspace = "notes",
    --                     },
    --                 },
    --             },
    --         }
    --     end,
    --     run = ":Neorg sync-parsers",
    --     after = {'plenary.nvim', 'telescope.nvim', 'nvim-treesitter'}
    -- }

end,
config = {
    display = {
        prompt_border = 'rounded', -- Border style of prompt popups.
    },
}}
