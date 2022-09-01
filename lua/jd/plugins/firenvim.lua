vim.g.firenvim_config = {
	['globalSettings']= {
		['alt']= 'all',
	},
	['localSettings']= {
		['.*']= {
			['cmdline'] = 'firenvim',
			['priority'] = 0,
			['selector'] = 'textarea:not([readonly]), div[role="textbox"]',
			['takeover'] = 'never',
		},
	}
}

if vim.g.started_by_firenvim then
	vim.cmd [[ au UIEnter * startinsert! ]]
	nmap { '<Esc><Esc>', ':call firenvim#focus_page()<CR>', {silent=true}}
	nmap { '<C-z>', ':call firenvim#hide_frame()<CR>', {silent=true}}
	imap { 'wq', '<Cmd>wq<CR>' }
	imap { 'qw', '<Cmd>wq<CR>' }
	nmap { 'wq', ':wq<CR>' }
	nmap { 'qw', ':wq<CR>' }
	nmap { '<PageUp>', ':set lines=20 columns=100<CR>' }
	vim.o.laststatus = 0
	vim.o.showtabline = 0
	vim.o.signcolumn = 'no'
	vim.o.relativenumber = false
	vim.o.guifont = "SauceCodePro Nerd Font Mono:h12"
end
