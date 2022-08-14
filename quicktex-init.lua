require 'jd.helpers'
require 'jd.settings'
require 'jd.cmds'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

-- statusline + bufferline
require 'jd.sl'

imap {'wq', '<ESC>:wq<CR>'}
imap {'qw', '<ESC>:wq<CR>'}
imap {'<CR>', '<ESC>:wq<CR>'}
map {'wq', ':wq<CR>'}
map {'qw', ':wq<CR>'}
map {'<CR>', ':wq<CR>'}

vim.defer_fn(
  function()
	vim.cmd [[normal i$$]]
	vim.cmd [[startinsert]]
  end,
  100
)

