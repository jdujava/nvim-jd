vim.cmd [[packadd packer.nvim]]

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
        vim.cmd [[qa]]
    else
        error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
    end
end
-- }}} Start bootstrap --

return require('packer').startup {function(use)
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt=true} -- no lazy packer

	-- use { 'b0o/incline.nvim', config=function() require('incline').setup() end}
	-- use { 'vigoux/LanguageTool.nvim' }
	-- use { 'dpelle/vim-LanguageTool' }

	-- Snippets {{{ --
	use {'SirVer/ultisnips', setup=[[require'jd.plugins.ultisnips']], event = 'CursorHold' }
	use {'honza/vim-snippets', after = 'ultisnips'}
	-- use {'reconquest/vim-pythonx', after = 'ultisnips'}
	-- }}} Snippets --
	-- Filetypes: tex, lua {{{ --
	-- use {'lervag/vimtex', config=[[require'jd.plugins.vimtex']], ft = 'tex'}
	use {'lervag/vimtex', config=[[require'jd.plugins.vimtex']]} -- reverse search works now
	use {'anufrievroman/vim-angry-reviewer', event = 'CursorHold' }
	-- use {'euclidianAce/BetterLua.vim', ft = 'lua' }
	-- }}} Filetypes: tex, lua --
	-- LSP {{{ --
	-- use {'nvim-lua/lsp-status.nvim', event = 'CursorHold'}
	use {'tjdevries/nlua.nvim', event = 'CursorHold'}
	-- use {'folke/lua-dev.nvim', after = 'nlua.nvim'}
	-- use {"ray-x/lsp_signature.nvim", after = "nlua.nvim"}
	use {'neovim/nvim-lspconfig', config=[[require'jd.plugins.lsp']], after = 'nlua.nvim'}
	-- use {'neovim/nvim-lspconfig', config=[[require'jd.plugins.lsp']], after = 'lua-dev.nvim'}
	--
	-- use {'vigoux/ltex-ls.nvim', config=[[require'jd.plugins.ltex-ls']], after = 'nvim-lspconfig'}
	use {'vigoux/ltex-ls.nvim', opt = 'true'}
	-- }}} LSP --
	-- Completion nvim-cmp {{{ --
	use {"hrsh7th/nvim-cmp", after = "cmp-nvim-lsp", config = [[require'jd.plugins.cmp']]}
	-- use {"hrsh7th/nvim-cmp", branch = "dev", after = "cmp-nvim-lsp", config = [[require'jd.plugins.cmp']]}
	use {"quangnguyen30192/cmp-nvim-ultisnips", after = "nvim-cmp"}
	-- use {"ray-x/cmp-treesitter", after = "nvim-cmp"}
	use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
	-- use {"hrsh7th/cmp-nvim-lsp", event = "InsertEnter"}
	use {"hrsh7th/cmp-nvim-lsp", after = "ultisnips"}
	use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
	use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
	-- use {"octaltree/cmp-look", after = "nvim-cmp"}
	use {"hrsh7th/cmp-path", after = "nvim-cmp"}
	-- use {"hrsh7th/cmp-latex-symbols", after = "nvim-cmp"}
	use {"hrsh7th/cmp-emoji", after = "nvim-cmp"}
	-- use {"hrsh7th/cmp-calc", after = "nvim-cmp"}
	-- }}} Completion nvim-cmp --
	-- Treesitter {{{ --
	use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate', event = 'CursorHold', config=[[require'jd.plugins.treesitter']]} -- better highlight
	use {'nvim-treesitter/playground', after = 'nvim-treesitter'}
	-- use {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'}
	-- use {'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter'}
	use {'~/.config/nvim/bundle/nvim-treesitter-refactor', after = 'nvim-treesitter'}
	-- }}} Treesitter --
	-- Misc {{{ --

	use {'tweekmonster/startuptime.vim', cmd='StartupTime' }
	-- use {'dstein64/vim-startuptime', cmd='StartupTime' }

	-- use { 'glacambre/firenvim',
	-- 	run = function() vim.fn['firenvim#install'](0) end,
	-- 	config=[[require'jd.plugins.firenvim']],
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
		config = function ()
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


	use {'norcalli/nvim-colorizer.lua', branch = 'color-editor', event = 'CursorHold',
		config = function()
			nmap { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>' }
			nmap { '<Leader><Leader>C', require'colorizer'.color_picker_on_cursor }
		end
	} -- high-performance color highlighter for Neovim
	use {'unblevable/quick-scope', setup = [[vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}]], event = 'CursorHold'}
	-- use {'rstacruz/vim-closer', event = 'CursorHold'} --find alternative
	-- use {'junegunn/vim-slash', event = 'CursorHold'}
	use {'junegunn/vim-easy-align', event = 'CursorHold', config=[[require'jd.plugins.vim-easy-align']]} -- use easy-align, instead of tabular
	-- use {'tpope/vim-commentary', event = 'CursorHold', config=[[require'jd.plugins.vim-commentary']]} -- comments
	use {'numToStr/Comment.nvim', event = 'CursorHold', config=[[require'jd.plugins.comment']]} -- comments
	use {'tpope/vim-unimpaired', event = 'CursorHold'} -- mappings with [ and ]
	use {'tpope/vim-repeat', event = 'CursorHold'}
	use {'tpope/vim-surround', event = 'CursorHold'} -- new commands to vim for generic brackets

	use {'lewis6991/gitsigns.nvim', config=[[require'jd.plugins.gitsigns']], after = 'plenary.nvim'}
	-- }}} Misc --
	-- FZF {{{ --
	-- use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end, event = 'CursorHold' }
	-- use {'junegunn/fzf.vim', config=[[require'jd.plugins.fzf']], event = 'CursorHold' }
	-- }}} FZF --
	-- Telescope {{{ --
	-- use 'norcalli/nvim_utils' -- neovim lua utils
	use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']], event = 'CursorHold' }
	-- use {'nvim-lua/plenary.nvim', config=[[require'jd.plugins.plenary']]}

	-- use {'nvim-lua/popup.nvim', event = 'CursorHold'}
	use {'kyazdani42/nvim-web-devicons', event = 'CursorHold'}
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'plenary.nvim'}
	use {'fhill2/telescope-ultisnips.nvim', after = 'telescope-fzf-native.nvim'}
	use {"tami5/sqlite.lua", after = 'telescope-ultisnips.nvim'}
	use {"nvim-telescope/telescope-frecency.nvim", after = 'sqlite.lua'}
	use {'nvim-telescope/telescope-ui-select.nvim', after = 'telescope-frecency.nvim'}
	use {'nvim-telescope/telescope.nvim',
		requires = {'nvim-lua/plenary.nvim'},
		config = function()
			require'jd.telescope'
			require'jd.telescope.mappings'
		end,
		after = 'telescope-ui-select.nvim',
	}
	-- }}} Telescope --

end}
