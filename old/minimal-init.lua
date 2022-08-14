require 'jd.helpers'
require 'jd.settings'
require 'jd.cmds'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

-- statusline + bufferline
require 'jd.sl'

map('i', 'wq', '<ESC>:wq<CR>')
map('i', 'qw', '<ESC>:wq<CR>')
map('',  'wq', ':wq<CR>')
map('',  'qw', ':wq<CR>')

vim.defer_fn(
  function()
	vim.cmd [[normal i$$]]
	vim.cmd [[startinsert]]
  end,
  140
)

