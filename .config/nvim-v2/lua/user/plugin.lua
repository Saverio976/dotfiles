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
            {
                "j-hui/fidget.nvim",
                branch = "legacy",
            },
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
            "lukas-reineke/cmp-rg",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "lukas-reineke/cmp-under-comparator",
            -- {
            --     "tzachar/cmp-tabnine",
            --     build = "./install.sh",
            -- },
            "L3MON4D3/LuaSnip",
            "windwp/nvim-autopairs",
            "onsails/lspkind-nvim",
        },
        config = function() require("user.cmp") end,
    },
    -- {
    --     "folke/which-key.nvim",
    --     event = { "<leader>", " ", "~" },
    --     config = function() require("which-key").setup({register = true}) end,
    -- },
    {
        "Exafunction/codeium.vim",
        lazy = false,
    },

    --------------------------------------------------------------------------
    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        dependencies = {
            "p00f/nvim-ts-rainbow",
            {
                "m-demare/hlargs.nvim",
                config = function() require("hlargs").setup() end,
            },
        },
        confif = function() require("user.treesitter") end,
    },

    --------------------------------------------------------------------------
    -- language integration
    -- {
    --     "wookayin/semshi", -- use a maintained fork
    --     ft = "python",
    --     build = ":UpdateRemotePlugins",
    --     init = function() require("user.semshi") end,
    -- },

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
            "otavioschwanck/telescope-alternate",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function() require("user.telescope") end,
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
        event = "WinEnter",
        config = function() require("user.feline") end,
    },

    --------------------------------------------------------------------------
    -- buffer enhancer
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
        "samodostal/image.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "m00qek/baleia.nvim",
        },
        config = function() require("user.image") end,
    },
    -- {
    --     'FluxxField/bionic-reading.nvim',
    --     event = "BufEnter",
    --     config = function() require("user.bionic_reading") end,
    -- },

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
    {
        "vim-scripts/DoxygenToolkit.vim",
        cmd = {
            "Dox",
            "DoxAuthor",
            "DoxBlock",
            "DoxLic",
            "DoxUndoc",
        },
    },
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
    {
        "tomiis4/hypersonic.nvim",
        cmd = "Hypersonic",
        config = function() require("user.hypersonic") end,
    },

    --------------------------------------------------------------------------
    -- auto indent
    {
        "Darazaki/indent-o-matic",
        event = "BufEnter",
        opts = {
            max_lines = 2048,
            standard_widths = {2, 4, 8},
            skip_multiline = true,
        },
    },

    --------------------------------------------------------------------------
    -- colorschemes
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     config = function() require("user.themes.tokyonight") end,
    -- },
    -- {
    --     "Yazeed1s/minimal.nvim",
    --     lazy = false,
    --     config = function() require("user.themes.minimal") end,
    -- },
    -- {
    --     "mrjones2014/lighthaus.nvim",
    --     lazy = false,
    --     config = function() require("user.themes.lighthaus") end,
    -- },
    -- {
    --     "bluz71/vim-nightfly-colors",
    --     name = "nightfly",
    --     lazy = false,
    --     config = function() require("user.themes.nightflycolors") end,
    -- -- },
    -- {
    --     "kartikp10/noctis.nvim",
    --     lazy = false,
    --     config = function() require("user.themes.noctis") end,
    --     dependencies = { "rktjmp/lush.nvim" },
    -- },
    {
        'wadackel/vim-dogrun',
        lazy = false,
        config = function() require("user.themes.dogrun") end,
    },

    --------------------------------------------------------------------------
    -- discord rich presence
    {
        "andweeb/presence.nvim",
        event = "BufEnter",
    },
})
