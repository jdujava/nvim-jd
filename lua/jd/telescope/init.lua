if not pcall(require, "telescope") then
	return
end

SHOULD_RELOAD_TELESCOPE = false

local reloader = function()
	if SHOULD_RELOAD_TELESCOPE then
		RELOAD "jd.telescope"
		RELOAD "jd.telescope.mappings"
	end
end

reloader()

local actions = require "telescope.actions"
local actions_layout = require "telescope.actions.layout"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"


local set_prompt_to_entry_value = function(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry or not type(entry) == "table" then
		return
	end

	action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = "🔭 ",
		selection_caret = "> ",

		sorting_strategy = "ascending",
		layout_config = {
			width = 0.85,
			height = 0.85,
			prompt_position = "top",

			horizontal = {
			},
			vertical = {
				-- width_padding = 0.05,
				-- height_padding = 1,
				width = 0.9,
				height = 0.95,
				preview_height = 0.5,
			},
		},
		-- file_ignore_patterns = {
		-- 	".zwc",
		-- },
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        prompt_title = '';
        results_title = '';
        preview_title = '';
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-y>"] = set_prompt_to_entry_value,
				["<C-l>"] = actions.select_default,
				["?"] = actions_layout.toggle_preview,
			},
		}
	},
	pickers = {
		-- Your special builtin config goes in here
		buffers = {
			sort_lastused = true,
			theme = "dropdown",
			previewer = false,
			mappings = {
				i = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
					-- Right hand side can also be the name of the action as a string
					-- ["<c-d>"] = "delete_buffer",
				},
				n = {
					["<c-d>"] = require("telescope.actions").delete_buffer,
				}
			}
		},
		find_files = {
            find_command = {
                "fd", "--type", "f",
                -- "--base-directory", "/home/jonas",
                "--hidden",
                "--follow",
                "--strip-cwd-prefix",
                "--ignore-file", "/home/jonas/.config/fd/ignore",
                "--ignore-file", "/home/jonas/.config/fd/nvim-ignore",
            },
		}
	},
	extensions = {
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		frecency = {
			show_scores = true,
			show_unindexed = true,
			ignore_patterns = {"*.git/*", "*.github/*", "*/tmp/*"},
			disable_devicons = false,
			workspaces = {
				["conf"] = "/home/jonas/.config",
				["data"] = "/home/jonas/.local/share",
				["doc"]  = "/home/jonas/Documents",
				["cus"]  = "/home/jonas/Documents/customfiles",
			}
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				-- even more opts
			}
		}

	},
}

vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = '#ff87d7', bg = '#3e4452'} )
-- local TelescopePrompt = {
--     TelescopePromptNormal = {
--         bg = '#2d3149',
--     },
--     TelescopePromptBorder = {
--         bg = '#2d3149',
--     },
--     TelescopePromptTitle = {
--         fg = '#2d3149',
--         bg = '#2d3149',
--     },
--     TelescopePreviewTitle = {
--         fg = '#1F2335',
--         bg = '#1F2335',
--     },
--     TelescopeResultsTitle = {
--         fg = '#1F2335',
--         bg = '#1F2335',
--     },
-- }
-- for hl, col in pairs(TelescopePrompt) do
--     vim.api.nvim_set_hl(0, hl, col)
-- end

require("telescope").load_extension "ultisnips"
-- pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension "fzf"
require("telescope").load_extension "frecency"
require("telescope").load_extension "ui-select"

local M = {}

function M.edit_neovim()
	require("telescope.builtin").find_files {
		cwd = "~/.config/nvim/",
		prompt_title = "~ neovim dotfiles ~",
	}
end

function M.edit_zsh()
	require("telescope.builtin").find_files {
		shorten_path = false,
		cwd = "~/.config/zsh/",
		prompt_title = "~ zsh dotfiles ~",
		hidden = true,

		layout_strategy = "horizontal",
		layout_config = {
			preview_width = 0.50,
		},
	}
end

function M.edit_config()
	require('telescope').extensions.frecency.frecency {
		default_text=":conf:",
		sorter = require'telescope.config'.values.file_sorter()
	}
end
function M.edit_custom()
	require('telescope').extensions.frecency.frecency {
		default_text=":cus:",
		sorter = require'telescope.config'.values.file_sorter()
	}
end

function M.fd()
	local opts = themes.get_ivy { hidden = true }
	require("telescope.builtin").fd(opts)
end

function M.builtin()
	local opts = {
		-- previewer = false,
		-- layout_config = {
		-- 	width = 0.4,
		-- 	height = 0.5,
		-- },
	}
	require("telescope.builtin").builtin(opts)
end

function M.git_files()
	local path = vim.fn.expand "%:h"
	if path == "" then
		path = nil
	end

	local width = 0.25
	if string.find(path, "sourcegraph.*sourcegraph", 1, false) then
		width = 0.5
	end

	local opts = themes.get_dropdown {
		-- winblend = 5,
		previewer = false,
		shorten_path = false,

		cwd = path,

		layout_config = {
			width = width,
		},
	}

	require("telescope.builtin").git_files(opts)
end

function M.buffer_git_files()
	require("telescope.builtin").git_files(themes.get_dropdown {
		cwd = vim.fn.expand "%:p:h",
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})
end

function M.live_grep()
	require("telescope.builtin").live_grep {
		-- shorten_path = true,
		-- previewer = true,
		-- fzf_separator = "|>",
	}
end

function M.grep_prompt()
	require("telescope.builtin").grep_string {
		path_display = { "shorten" },
		search = vim.fn.input "Grep String > ",
	}
end

function M.grep_last_search(opts)
	opts = opts or {}

	-- \<getreg\>\C
	-- -> Subs out the search things
	local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

	opts.path_display = { "shorten" }
	opts.word_match = "-w"
	opts.search = register

	require("telescope.builtin").grep_string(opts)
end

function M.oldfiles()
	require("telescope").extensions.frecency.frecency {
		cwd = "~/",
		sorter = require'telescope.config'.values.file_sorter(),
		-- sorter = require "telescope.sorters".fuzzy_with_index_bias(),
	}
end

function M.my_plugins()
	require("telescope.builtin").find_files {
		cwd = "~/.config/nvim/bundle/",
	}
end

function M.installed_plugins()
	require("telescope.builtin").find_files {
		cwd = vim.fn.stdpath "data" .. "/site/pack/packer/",
	}
end

function M.project_search()
	local opts = {
		-- previewer = false,
		shorten_path = false,
		cwd = require("lspconfig.util").root_pattern ".git"(vim.fn.expand "%:p"),
		-- layout_config = {
		-- 	height=0.6,
		-- 	width=0.7,
		-- }
	}
	require("telescope.builtin").find_files(opts)
end

function M.buffers()
	require("telescope.builtin").buffers {
		path_display = {"absolute"},
		cwd = "~"
	}
end

function M.curbuf()
	-- local opts = themes.get_dropdown {
	-- 	previewer = false,
	-- 	shorten_path = false,
	-- 	layout_config = {
	-- 		height=0.6,
	-- 		width=0.7,
	-- 	}
	-- }
	-- require("telescope.builtin").current_buffer_fuzzy_find(opts)
	require("telescope.builtin").current_buffer_fuzzy_find{}
end

function M.ultisnips()
	local opts = {
		-- previewer = true,
		layout_strategy = 'vertical',
		layout_config = {
			height = 0.95,
			width = 0.5
		}
	}
	require("telescope").extensions.ultisnips.ultisnips(opts)
	-- require("telescope").extensions.ultisnips.ultisnips{}
end

function M.help_tags()
	require("telescope.builtin").help_tags {
		show_version = true,
	}
end

function M.search_all_files()
	require("telescope.builtin").find_files {
		cwd = "~",
		-- previewer = false,
	}
end

function M.git_status()
	local opts = themes.get_dropdown {
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	}

	-- Can change the git icons using this.
	-- opts.git_icons = {
	-- 	changed = "M"
	-- }

	require("telescope.builtin").git_status(opts)
end

function M.git_commits()
	require("telescope.builtin").git_commits {
		winblend = 5,
	}
end

function M.search_only_certain_files()
	require("telescope.builtin").find_files {
		find_command = {
			"rg",
			"--files",
			"--type",
			vim.fn.input "Type: ",
		},
	}
end

function M.lsp_references()
	require("telescope.builtin").lsp_references {
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	}
end

function M.lsp_implementations()
	require("telescope.builtin").lsp_implementations {
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	}
end

return setmetatable({}, {
	__index = function(_, k)
		reloader()

		local has_custom, custom = pcall(require, string.format("jd.telescope.custom.%s", k))

		if M[k] then
			return M[k]
		elseif has_custom then
			return custom
		else
			return require("telescope.builtin")[k]
		end
	end,
})

