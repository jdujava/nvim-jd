TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = termcode(key .. f)

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = function() require('jd.telescope')[f](TelescopeMapArgs[map_key]) end
  -- always automatically update
  -- local rhs = function() R('jd.telescope')[f](TelescopeMapArgs[map_key]) end

  local map_options = {
    noremap = true,
    silent = true,
  }

  if buffer then
	  map_options.buffer = 0
  end

  vim.keymap.set(mode, key, rhs, map_options)
end

cmap {"<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", {nowait=true}}


-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ec", "edit_config")
map_tele("<leader>ed", "edit_custom")
map_tele("<leader>ez", "edit_zsh")
map_tele("<leader>ei", "installed_plugins")

map_tele("<leader><leader>f", "find_files")
map_tele("<leader>f", "search_all_files")
map_tele("<leader>R", "reloader")
map_tele("<leader>b", "buffers")
map_tele("<leader>B", "builtin")
map_tele("<leader>g", "live_grep")
map_tele("<leader>F", "oldfiles")
map_tele("<leader>c", "curbuf")
map_tele("<leader>C", "commands")
map_tele("<leader>O", "vim_options")
map_tele("<leader>M", "keymaps")
map_tele("<leader>H", "help_tags")

map_tele("<A-Tab>", "ultisnips")

map_tele("<leader>p", "project_search")
map_tele("<leader>/", "grep_last_search", {
  layout_strategy = "vertical",
})


-- -- Search
-- -- TODO: I would like to completely remove _mock from my search results here when I'm in SG/SG
-- map_tele("<space>gw", "grep_string", {
--   short_path = true,
--   word_match = "-w",
--   only_sort_text = true,
--   layout_strategy = "vertical",
--   sorter = sorters.get_fzy_sorter(),
-- })

-- -- Files
-- map_tele("<space>ft", "git_files")
-- -- map_tele("<space>fg", "live_grep")
-- map_tele("<space>fg", "multi_rg")
-- map_tele("<space>fo", "oldfiles")
-- map_tele("<space>fd", "fd")
-- map_tele("<space>pp", "project_search")
-- map_tele("<space>fv", "find_nvim_source")
-- map_tele("<space>fz", "search_only_certain_files")

-- -- Git
-- map_tele("<space>gs", "git_status")
-- map_tele("<space>gc", "git_commits")

-- -- Nvim
-- map_tele("<space>fb", "buffers")
-- map_tele("<space>fp", "my_plugins")
-- map_tele("<space>fa", "installed_plugins")
-- map_tele("<space>fi", "search_all_files")
-- map_tele("<space>ff", "curbuf")
-- map_tele("<space>fh", "help_tags")
-- map_tele("<space>vo", "vim_options")
-- map_tele("<space>gp", "grep_prompt")

return map_tele
