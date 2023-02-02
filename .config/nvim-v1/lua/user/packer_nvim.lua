-- package manager
-- https://github.com/wbthomason/packer.nvim
-- packer

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path
    })
    execute 'packadd packer.nvim'
end

vim.cmd([[packadd packer.nvim]])

local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

packer.init({
    config = {
        compile_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
    },
    luarocks = {
        python_cmd = 'python3'
    }
})

packer.startup(function (use)
    use { 'wbthomason/packer.nvim' }

    -- speedup startup
    use { 'lewis6991/impatient.nvim' }
    use { 'nathom/filetype.nvim' }

    -- lsp
    use { 'neovim/nvim-lspconfig' }
    use { 'onsails/lspkind-nvim' }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use { 'folke/trouble.nvim' }
    use { 'rmagatti/goto-preview' }
    use { 'folke/lsp-colors.nvim' }
    use { 'j-hui/fidget.nvim' }
    use { 'kosayoda/nvim-lightbulb' }

    -- (auto)completion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'lukas-reineke/cmp-rg',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'lukas-reineke/cmp-under-comparator',
        },
    }
    use {
        'tzachar/cmp-tabnine',
        after = "nvim-cmp",
        run = './install.sh',
        requires = {
            'hrsh7th/nvim-cmp'
        }
    }
    use { 'L3MON4D3/LuaSnip' }
    -- use { 'LunarWatcher/auto-pairs' }
    use { 'windwp/nvim-autopairs' }
    use { 'folke/which-key.nvim' }
    use { 'RishabhRD/nvim-cheat.sh' }
    -- use { 'gelguy/wilder.nvim' }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter' }
    use { 'p00f/nvim-ts-rainbow' }
    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    -- finder
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        }
    }

    -- nomenclature
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
    use { 'feline-nvim/feline.nvim' }

    -- zoom buffer
    use { 'nyngwang/NeoZoom.lua' }

    -- interract on text
    use { 'numToStr/Comment.nvim' }
    use { 'editorconfig/editorconfig-vim' }
    use { 'mg979/vim-visual-multi' }
    use { 'booperlv/nvim-gomove' }
    use { 'vim-scripts/DoxygenToolkit.vim' }
    use {
        'jiaoshijie/undotree',
        requires = { 'nvim-lua/plenary.nvim' },
    }
    use { 'Darazaki/indent-o-matic' }
    -- interract on cwd
    use { 'airblade/vim-rooter' }
    -- terminal
    use { 'voldikss/vim-floaterm' }

    -- beauty
    use { 'norcalli/nvim-colorizer.lua' }
    use { 'lukas-reineke/indent-blankline.nvim' }
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use { 'MunifTanjim/nui.nvim' }
    use { 'stevearc/dressing.nvim' }
    use { 'rcarriga/nvim-notify' }
    use { 'kyazdani42/nvim-web-devicons' }

    use { 'folke/tokyonight.nvim' }
    use { 'Yazeed1s/minimal.nvim' }
    use { 'mrjones2014/lighthaus.nvim' }
    use { 'mawkler/modicator.nvim' }

    -- discord
    use { 'andweeb/presence.nvim' }

    -- music
    use {
        'Saverio976/music.nvim',
        run = ':MusicInstall',
        requires = { 'voldikss/vim-floaterm' }
    }

    use {
        'heavenshell/vim-pydocstring',
        run = 'make install',
        ft = 'python',
    }
end)
