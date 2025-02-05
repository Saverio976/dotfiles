local data_dir = nil
if os.getenv('XDG_DATA_HOME') then
    data_dir = os.getenv('XDG_DATA_HOME') .. '/nvim'
else
    data_dir = vim.fn.stdpath('data') .. '/nvim'
end

local lazypath = data_dir .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({
    --------------------------------------------------------------------------
    -- startup mesure
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
    },

    --------------------------------------------------------------------------
    -- language server
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { 'LspInfo', 'LspStart', 'LspStop' },
        dependencies = {
            'rmagatti/goto-preview',
        },
        config = function() require('saverio976.lsp') end,
    },

    --------------------------------------------------------------------------
    -- completion
    {
        'saghen/blink.cmp',
        version = 'v0.11.0',
        keymap = { preset = 'default' },
        config = function() require('saverio976.blink') end,
    },

    --------------------------------------------------------------------------
    -- floating window app
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = 'Telescope',
        keys = { 'tf', 'tb', 'tg' },
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function() return vim.fn.executable 'make' == 1 end,
            },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function() require('saverio976.telescope') end,
    },

    {
        'jiaoshijie/undotree',
        keys = '<leader>u',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('saverio976.undotree') end,
    },

    {
        'numToStr/FTerm.nvim',
        keys = '<A>=',
        config = function() require('saverio976.fterm') end,
    },

    --------------------------------------------------------------------------
    -- buffer enhancer
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require('gitsigns').setup() end,
    },

    --------------------------------------------------------------------------
    -- text interraction
    {
        'numToStr/Comment.nvim',
        keys = {
            'gc',
            { 'gc', mode = 'v' },
        },
        config = function() require('saverio976.comment') end,
    },

    --------------------------------------------------------------------------
    -- auto indent
    {
        'Darazaki/indent-o-matic',
        event = 'VimEnter',
        opts = {
            max_lines = 2048,
            standard_widths = { 2, 4, 8 },
            skip_multiline = true,
        },
    },

    --------------------------------------------------------------------------
    -- colorscheme
    {
        'scottmckendry/cyberdream.nvim',
        lazy = false,
        priority = 1000,
        config = function() require('saverio976.colorscheme') end,
    },
})
