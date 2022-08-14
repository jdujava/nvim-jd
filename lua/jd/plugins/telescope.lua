local actions = require "telescope.actions"

require('telescope').setup{
	defaults = {
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		-- prompt_prefix = "❯ ",
		-- selection_caret = "•> ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,

		mappings = {
			i = {
				["<Esc>"] = actions.close,
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
			theme = "dropdown"
		}
	},
	extensions = {
		-- Your extension config goes in here
	}
}

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  -- local rhs = string.format("<cmd>lua R('telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)
  local rhs = string.format("<cmd>lua require'telescope.builtin'.%s{}<CR>", f)
  -- local rhs = "<cmd>lua require'telescope.builtin'."..f.."{}<CR>"

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

cmap { "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", {nowait=true}}

map_tele("<leader>R", "reloader")
map_tele("<leader>B", "builtin")
map_tele("<leader>F", "live_grep")
map_tele("<leader>h", "oldfiles")
map_tele("<leader>L", "lsp_references")
map_tele("<leader>b", "buffers")
map_tele("<leader>c", "buffers")
map_tele("<leader>C", "commands")
map_tele("<leader>M", "keymaps")
map_tele("<leader>H", "help_tags")
