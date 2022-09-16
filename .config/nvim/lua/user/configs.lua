--

local backup_dir = vim.fn.stdpath('cache')

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.termguicolors = true

-- show invisble char
vim.opt.list = true
local listchars = vim.opt.listchars
listchars['nbsp'] = '⦸'
listchars['extends'] = '»'
listchars['precedes'] = '«'
listchars['tab'] = '▷'
listchars['trail'] = '•'
listchars['space'] = '•'
listchars['eol'] = '↴'
vim.opt.listchars = listchars
-- vim.opt.listchars = {
--   nbsp = '⦸',
--   extends = '»',
--   precedes = '«',
--   tab = '───▷',
--   trail = '•',
--   space = ' ',
-- }

vim.opt.fillchars = {
  eob = ' ',
}

-- persistence undofile
vim.opt.undofile = true
vim.opt.undodir = backup_dir .. '/undos'

-- swap file
vim.opt.directory = backup_dir .. '/swap'

-- clipboard
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

-- dont break line on multiple line
vim.opt.wrap = false
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2

vim.opt.backspace = 'indent,start,eol'

vim.opt.shiftwidth = 4
-- tab round to multiple of shiftwidth
vim.opt.shiftround = true

-- only one status line
vim.opt.laststatus = 3
vim.opt.cmdheight = 1

-- preview result of :s
vim.opt.inccommand = 'split'
-- show matching pair [] {} ()
vim.opt.showmatch = true

-- default shell
local shell = os.getenv('SHELL')
vim.opt.shell = shell

vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- ruler
vim.opt.ruler = true
vim.opt.colorcolumn = '80'

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- \n (no \r\n)
vim.opt.fileformat = 'unix'
