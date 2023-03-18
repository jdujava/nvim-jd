if not pcall(require, "telescope") then
    return
end

SHOULD_RELOAD_TELESCOPE = false

local reloader = function()
    if SHOULD_RELOAD_TELESCOPE then
        RELOAD = require("plenary.reload").reload_module
        RELOAD "plugins.telescope.setup"
        RELOAD "plugins.telescope.mappings"
    end
end
reloader()

vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', {fg = '#ff87d7', bg = '#262626'} )
-- vim.api.nvim_set_hl(0, 'TelescopeMultiIcon', {fg = '#ff97e7'} )
vim.api.nvim_set_hl(0, 'TelescopeSelection', {bg = '#262626', bold = true} )
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

local M = {}

function M.edit_neovim()
    require("telescope.builtin").find_files {
        cwd = "~/.config/nvim/",
        prompt_title = "Neovim Dotfiles",
    }
end

function M.edit_zsh()
    require("telescope.builtin").find_files {
        cwd = "~/.config/zsh/",
        prompt_title = "Zsh Dotfiles",
    }
end

function M.builtin()
    local opts = {
        -- previewer = false,
        -- layout_config = {
        --  width = 0.4,
        --  height = 0.5,
        -- },
    }
    require("telescope.builtin").builtin(opts)
end

function M.live_grep()
    require("telescope.builtin").live_grep {
        -- shorten_path = true,
        -- previewer = true,
    }
end

function M.oldfiles()
    require("telescope").extensions.frecency.frecency {
        cwd = "~/",
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
        --  height=0.6,
        --  width=0.7,
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
    --  previewer = false,
    --  shorten_path = false,
    --  layout_config = {
    --      height=0.6,
    --      width=0.7,
    --  }
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

function M.messages()
    local opts = {
        sorting_strategy = "descending",
        layout_config = {
            prompt_position = "bottom",
        }
    }
    require("telescope").extensions.messages.messages(opts)
    -- require("telescope").extensions.ultisnips.ultisnips{}
end

function M.help_tags()
    require("telescope.builtin").help_tags {}
end

function M.search_all_files()
    require("telescope.builtin").find_files {
        cwd = "~",
        -- previewer = false,
    }
end

function M.notify()
    require('telescope').extensions.notify.notify {}
end

return setmetatable({}, {
    __index = function(_, k)
        reloader()

        if M[k] then
            return M[k]
        else
            return require("telescope.builtin")[k]
        end
    end,
})

