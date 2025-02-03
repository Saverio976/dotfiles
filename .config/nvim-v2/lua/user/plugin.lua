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
    --------------------------------------------------------------------------
    -- startup mesure
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    --------------------------------------------------------------------------
    -- language server
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspStart", "LspStop" },
        dependencies = {
            "rmagatti/goto-preview",
            "j-hui/fidget.nvim",
        },
        config = function() require("user.lsp") end,
    },

    --------------------------------------------------------------------------
    -- completions
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            -- "lukas-reineke/cmp-rg",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind-nvim",
            -- {
            --     "Exafunction/codeium.nvim",
            --     config = function() require("user.cmp.codeium") end,
            -- }
        },
        config = function() require("user.cmp") end,
    },

    --------------------------------------------------------------------------
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        dependencies = {
            {
                "m-demare/hlargs.nvim",
                config = function() require("hlargs").setup() end,
            },
        },
        confif = function() require("user.treesitter") end,
    },

    --------------------------------------------------------------------------
    -- floating window app
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = "Telescope",
        keys = {
            "tf",
            "tb",
            "tg",
        },
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function() require("saverio976.telescope") end,
    },
    {
        "jiaoshijie/undotree",
        keys = "<leader>u",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function() require("user.undotree").setup() end,
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
        "nyngwang/NeoZoom.lua",
        keys = "<leader>m",
        cmd = "NeoZoomToggle",
        config = function() require("user.neozoom") end,
    },

    --------------------------------------------------------------------------
    -- folder tree
    {
        "nvim-tree/nvim-tree.lua",
        keys = "<leader>f",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require("user.nvim-tree") end,
    },

    --------------------------------------------------------------------------
    -- status bar
    {
        "feline-nvim/feline.nvim",
        event = "VimEnter",
        config = function() require("user.feline") end,
    },

    --------------------------------------------------------------------------
    -- buffer enhancer
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

    --------------------------------------------------------------------------
    -- text interraction
    {
        "numToStr/Comment.nvim",
        keys = {
            "gc",
            {"gc", mode = "v"},
        },
        config = function() require("user.comment") end,
    },
    -- {
    --     "vim-scripts/DoxygenToolkit.vim",
    --     cmd = {
    --         "Dox",
    --         "DoxAuthor",
    --         "DoxBlock",
    --         "DoxLic",
    --         "DoxUndoc",
    --     },
    -- },
    {
        "heavenshell/vim-pydocstring",
        lazy = true,
        build = "make install",
        cmd = "Pydocstring",
        ft = "python",
        config = function() vim.g.pydocstring_formatter = 'numpy' end,
    },
    {
        "Eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
        keys = "m",
        config = function() vim.keymap.set("n", "m", ":CellularAutomaton make_it_rain<cr>", {noremap = true}) end,
    },
    {
        "TobinPalmer/rayso.nvim",
        cmd = { 'Rayso' },
        config = function() require("user.rayso") end,
    },

    --------------------------------------------------------------------------
    -- auto indent
    {
        "Darazaki/indent-o-matic",
        event = "VimEnter",
        opts = {
            max_lines = 2048,
            standard_widths = {2, 4, 8},
            skip_multiline = true,
        },
    },

    --------------------------------------------------------------------------
    -- colorschemes
    {
        "bluz71/vim-nightfly-colors",
        lasy = false,
        priority = 1000,
        config = function() vim.cmd('colorscheme nightfly') end,
    },

    --------------------------------------------------------------------------
    -- dotfyle
    {
        "creativenull/dotfyle-metadata.nvim",
        cmd = "DotfyleGenerate",
    }
})
