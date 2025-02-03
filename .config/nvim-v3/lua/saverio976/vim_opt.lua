local backup_dir = nil
if os.getenv("XDG_CACHE_HOME") then
    backup_dir = os.getenv("XDG_CACHE_HOME") .. '/nvim'
else
    backup_dir = vim.fn.stdpath('cache') .. '/nvim'
end

vim.opt.termguicolors = true

vim.cmd([[syntax enable]])

-- show invisble char
vim.opt.list = true

vim.opt.listchars = {
    eol = '↴',
    trail = '•',
    extends = '»',
    precedes = '«',
    nbsp = '⦸',
    space = ' ',
    tab = ' ▷',
}

vim.opt.fillchars = {
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
vim.opt.undofile = true
vim.opt.undodir = backup_dir .. '/undos'

-- swap file
vim.opt.directory = backup_dir .. '/swap'

-- clipboard
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

-- dont break line on multiple line
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 10

vim.opt.backspace = 'indent,start,eol'

vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
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
if not vim.fn.has("win32") then
    if vim.fn.executable('powershell.exe') then
        vim.opt.shell = 'powershell.exe'
    end
else
    local shell = os.getenv('SHELL')
    vim.opt.shell = shell
end

vim.opt.ttyfast = true

-- ruler
vim.opt.ruler = true
vim.opt.colorcolumn = '80'

-- line number
vim.opt.number = true
--vim.opt.relativenumber = true

-- \n (no \r\n)
vim.opt.fileformat = 'unix'

vim.opt.mouse = "nvi"

-- case insensitive except when Maj in it
vim.opt.ignorecase = true
vim.opt.smartcase = true
