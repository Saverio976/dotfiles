local opt = vim.opt
local fn = vim.fn

local backup_dir = nil
if os.getenv('XDG_CACHE_HOME') then
    backup_dir = os.getenv('XDG_CACHE_HOME') .. '/nvim'
else
    backup_dir = fn.stdpath('cache') .. '/nvim'
end

opt.termguicolors = true

vim.cmd([[syntax enable]])

-- show invisble char
opt.list = true

opt.listchars = {
    eol = '↴',
    trail = '•',
    extends = '»',
    precedes = '«',
    nbsp = '⦸',
    space = ' ',
    tab = ' ▷',
}

opt.fillchars = {
    eob = ' ',
    horiz = '━',
    horizup = '┻',
    horizdown = '┳',
    vert = '┃',
    vertleft = '┫',
    vertright = '┣',
    verthoriz = '╋',
}

-- persistence undofile
opt.undofile = true
opt.undodir = backup_dir .. '/undos'

-- swap file
opt.directory = backup_dir .. '/swap'

-- clipboard
opt.clipboard = vim.opt.clipboard + 'unnamedplus'

-- dont break line on multiple line
opt.wrap = false
opt.scrolloff = 3
opt.sidescrolloff = 10

opt.backspace = 'indent,start,eol'

opt.shiftwidth = 4
opt.expandtab = true
opt.tabstop = 4
-- tab round to multiple of shiftwidth
opt.shiftround = true

-- only one status line
opt.laststatus = 3
opt.cmdheight = 1

-- preview result of :s
opt.inccommand = 'split'
-- show matching pair [] {} ()
opt.showmatch = true

-- default shell
if not fn.has('win32') then
    if fn.executable('powershell.exe') then
        opt.shell = 'powershell.exe'
    end
else
    local shell = os.getenv('SHELL')
    opt.shell = shell
end

opt.ttyfast = true

-- ruler
opt.ruler = true
opt.colorcolumn = '80'

-- line number
opt.number = true
--vim.opt.relativenumber = true

-- \n (no \r\n)
opt.fileformat = 'unix'

opt.mouse = 'nvi'

-- case insensitive except when Maj in it
opt.ignorecase = true
opt.smartcase = true
