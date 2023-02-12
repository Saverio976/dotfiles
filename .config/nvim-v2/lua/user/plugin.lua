local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local oklazy, lazy = pcall(require, "lazy")
if not oklazy then
    return
end

lazy.setup({
    "lewis6991/impatient.nvim",
    "nathom/filetype.nvim",

    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    {
        "neovim/nvim-lspconfig",
        event = "BufEnter",
        dependencies = {
            "rmagatti/goto-preview",
            "j-hui/fidget.nvim",
            "kosayoda/nvim-lightbulb",
            "folke/lsp-colors.nvim",
        },
        config = function() require("user.lsp") end,
    },
    -- {
    --     "jose-elias-alvarez/null-ls.nvim",
    -- },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "lukas-reineke/cmp-rg",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
            {
                "tzachar/cmp-tabnine",
                build = "./install.sh",
            },
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind-nvim",
            {
                "jcdickinson/codeium.nvim",
                dependencies = {
                    "nvim-lua/plenary.nvim",
                    "MunifTanjim/nui.nvim",
                },
                config = function() require("codeium").setup() end,
            }
        },
        config = function() require("user.cmp") end,
    },
    {
        "folke/which-key.nvim",
        lazy = true,
        config = function() require("which-key").setup({register = true}) end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        dependencies = {
            "p00f/nvim-ts-rainbow",
        },
        confif = function() require("user.treesitter") end,
    },
    {
        "m-demare/hlargs.nvim",
        event = "BufEnter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function() require("hlargs").setup() end,
    },

    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        keys = {
            "tf",
            "tb",
            "tb",
        },
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function() require("user.telescope") end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        keys = "<leader>f",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require("user.nvim-tree") end,
    },
    {
        "feline-nvim/feline.nvim",
        lazy = false,
        config = function() require("user.feline") end,
    },
    {
        "nyngwang/NeoZoom.lua",
        keys = "<leader>m",
        cmd = "NeoZoomToggle",
        config = function() require("user.neozoom") end,
    },

    {
        "numToStr/Comment.nvim",
        keys = {
            "gcc",
            "gc",
        },
        config = function() require("user.comment") end,
    },
    {
        "vim-scripts/DoxygenToolkit.vim",
        event = "BufEnter",
    },

    {
        "jiaoshijie/undotree",
        keys = "<leader>u",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require("undotree").setup() end,
    },

    {
        "Darazaki/indent-o-matic",
        event = "BufEnter",
        opts = {
            max_lines = 2048,
            standard_widths = {2, 4, 8},
            skip_multiline = true,
        },
    },

    {
        "airblade/vim-rooter",
        event = "WinEnter",
    },

    {
        "voldikss/vim-floaterm",
        keys = "<A>=",
        cmd = {
            "FloatermFirst",
            "FloatermHide",
            "FloatermKill",
            "FloatermLast",
            "FloatermNew",
            "FloatermNext",
            "FloatermPrev",
            "FloatermSend",
            "FloatermShow",
            "FloatermToggle",
            "FloatermUpdate",
        },
        config = function()
            vim.g.floaterm_width = 0.9
            vim.g.floaterm_height = 0.9
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        event = "BufEnter",
        config = function() require("colorizer").setup() end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        config = function() require("user.indent_blankline") end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufEnter",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require("gitsigns").setup() end,
    },
    {
        "stevearc/dressing.nvim",
        lazy = false,
        config = function() require("dressing").setup() end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        config = function() require("user.themes.tokyonight") end,
    },
    {
        "Yazeed1s/minimal.nvim",
        lazy = true,
        config = function() require("user.themes.minimal") end,
    },
    {
        "mrjones2014/lighthaus.nvim",
        lazy = false,
        config = function() require("user.themes.lighthaus") end,
    },

    {
        "andweeb/presence.nvim",
        lazy = false,
    },

    {
        "heavenshell/vim-pydocstring",
        lazy = true,
        build = "make install",
        cmd = "Pydocstring",
        ft = "python",
        config = function() vim.g.pydocstring_formatter = 'numpy' end,
    },
})
