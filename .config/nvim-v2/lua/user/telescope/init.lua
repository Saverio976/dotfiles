local telescope = require("telescope")

local actions = require("telescope.actions")

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")

telescope.setup({
    defaults = {
        initial_mode = "insert",
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {
            "__pycache__/", "__pycache__/*",
            "node_modules/", "node_modules/*",
            "dist/", "dist/*", "build/", "build/*",
            ".git/", ".git/*",
            ".gradle", ".idea/", ".vscode/",
            ".dll", ".idea/*", ".vscode/*"
        },
        file_previewer = require"telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require"telescope.previewers".vim_buffer_vimgrep.new,
        live_grep = {
            preview = {
                treesitter = false
            }
        },
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<ESC>"] = actions.close,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            case_mode = "smart_case"
        },
        ["telescope-alternate"] = {
            mappings = {
                -- cpp/hpp
                { pattern = "(.*).cpp", targets = {
                    { template = "[1].hpp", label = "C++ Header", enable_new = true }
                }},
                { pattern = "(.*).hpp", targets = {
                    { template = "[1].cpp", label = "C++ Source", enable_new = true }
                }},
            },
            open_only_one_with = 'current_pane',
        }
    },
    pickers = {
        find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
    },
})
pcall(telescope.load_extension, "fzf")
telescope.load_extension("telescope-alternate")

-- " Find files using Telescope command-line sugar.
vim.keymap.set("n", "tf", "<cmd>Telescope find_files<cr>", { desc = "Telescope find_files", noremap = true, silent = true })
vim.keymap.set("n", "tg", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live_grep", noremap = true, silent = true })
vim.keymap.set("n", "tb", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers", noremap = true, silent = true })
vim.keymap.set("n", "th", "<cmd>Telescope help_tags<cr>", { desc = "Telescope help_tags", noremap = true, silent = true })
vim.keymap.set("n", "ta", "<cmd>Telescope telescope-alternate alternate_file<cr>", { desc = "Telescope alternate_file", noremap = true, silent = true })
