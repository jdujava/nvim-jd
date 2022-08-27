local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  vim.notify("This plugins requires nvim-telescope/telescope.nvim", vim.log.levels.ERROR)
end

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function prepare_output_table()
  local lines = {}
  local messages = vim.api.nvim_exec("messages", true)

  for message in messages:gmatch("[^\r\n]+") do
      table.insert(lines, 1, message)
  end
  return lines
end

local function show_messages(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "Messages",
    finder = finders.new_table {
      results = prepare_output_table()
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

return telescope.register_extension({
  exports = {
    -- Default when to argument is given, i.e. :Telescope changes
    messages = show_messages,
  },
})
