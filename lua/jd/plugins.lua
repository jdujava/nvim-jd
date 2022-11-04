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

    -- Snippets {{{ --
    use {'SirVer/ultisnips', setup=[[require'jd.plugins.ultisnips']], event = 'CursorHold' }
    use {'L3MON4D3/LuaSnip', opt = true} -- switch to LuaSnip
    use {'honza/vim-snippets', after = 'ultisnips'}
    -- use {'reconquest/vim-pythonx', after = 'ultisnips'}
    -- }}} Snippets --
    -- Latex {{{ -- reverse search works now
    use {'lervag/vimtex', config=[[require'jd.plugins.vimtex']], event = 'CursorHold', cmd = 'VimtexInverseSearch'}
    -- use {'lervag/vimtex', config=[[require'jd.plugins.vimtex']], opt=true}
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
    -- use {'tjdevries/nlua.nvim', after = "mason-lspconfig.nvim"}
    use {'neovim/nvim-lspconfig', config = [[require'jd.plugins.lsp']], after = 'mason-lspconfig.nvim'}

    use {'j-hui/fidget.nvim', config = [[require'jd.plugins.fidget']], after = 'nvim-lspconfig'}
    -- }}} LSP --
    -- Treesitter {{{ --
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', config=[[require'jd.plugins.treesitter']], event = 'CursorHold'} -- better highlight
    use {'nvim-treesitter/playground', after = 'nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-context', config=[[require'jd.plugins.treesitter-context']], after = 'nvim-treesitter' }
    use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
    -- use {'nvim-treesitter/nvim-treesitter-textobjects', opt = true}
    -- use {'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter'}

    use {'lukas-reineke/indent-blankline.nvim', config=[[require'jd.plugins.indent-blankline']], after = 'nvim-treesitter-context'}

    -- }}} Treesitter --
    -- Telescope {{{ --
    -- use 'norcalli/nvim_utils' -- neovim lua utils
    use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']], event = 'CursorHold' }
    -- use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']]}

    -- use {'kyazdani42/nvim-web-devicons', config=function()
    --     require("nvim-web-devicons").set_default_icon('', '#8b929f')
    -- end, event = 'CursorHold'}
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
    use {'rcarriga/nvim-notify', config=[[require'jd.plugins.notify']], after = 'telescope.nvim' }
    -- use { "vigoux/notifier.nvim", after = 'telescope.nvim',
    use { "vigoux/notifier.nvim", opt = true,
        config = function()
            require'notifier'.setup {
                -- You configuration here
                ignore_messages = {}, -- Ignore message from LSP servers with this name
                -- status_width = something, -- COmputed using 'columns' and 'textwidth'
                components = {  -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
                    "nvim",  -- Nvim notifications (vim.notify and such)
                    "lsp"  -- LSP status updates
                },
                notify = {
                    clear_time = 5000, -- Time in milisecond before removing a vim.notifiy notification, 0 to make them sticky
                    min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
                },
                component_name_recall = true -- Whether to prefix the title of the notification by the component name
            }
        end,
    }

    -- }}} Telescope --
    -- Misc {{{ --

    -- use { 'glacambre/firenvim',
    --  run = function() vim.fn['firenvim#install'](0) end,
    --  config=[[require'jd.plugins.firenvim']],
    -- }
    use {'voldikss/vim-floaterm', config=[[require'jd.plugins.vim-floaterm']], event = 'CursorHold' }
    -- use {'is0n/fm-nvim', event = 'CursorHold'}
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


    use {'norcalli/nvim-colorizer.lua', branch = 'color-editor', event = 'CursorHold',
        config = function()
            nmap { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>' }
            nmap { '<Leader><Leader>C', require'colorizer'.color_picker_on_cursor }
        end
    } -- high-performance color highlighter for Neovim
    -- use {'phaazon/hop.nvim', config = [[require'jd.plugins.hop']], event = 'CursorHold'}
    use {'phaazon/hop.nvim', config = [[require'jd.plugins.hop']], opt = true}
    use {'junegunn/vim-easy-align', config=[[require'jd.plugins.vim-easy-align']], event = 'CursorHold'} -- use easy-align, instead of tabular
    use {'tpope/vim-unimpaired', event = 'CursorHold'} -- mappings with [ and ]
    -- use {'tpope/vim-scriptease', event = 'CursorHold'} -- mappings with [ and ]

    use {'numToStr/Comment.nvim', config=[[require'jd.plugins.Comment']], event = 'CursorHold'} -- comments
    use {'kylechui/nvim-surround', config=[[require'jd.plugins.nvim-surround']], event = 'CursorHold'}
    use {'lewis6991/gitsigns.nvim', config=[[require'jd.plugins.gitsigns']], after = 'plenary.nvim'}
    -- }}} Misc --

end,
config = {
    display = {
        prompt_border = 'rounded', -- Border style of prompt popups.
    },
}}
