-- https://github.com/kyazdani42/nvim-tree.lua
--  nvim-tree
local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then
    return
end
nvimtree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_directories = {enable = true, auto_open = true},
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        hide_root_folder = false,
        side = 'right',
        mappings = {
            custom_only = false,
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
        indent_markers = {
            enable = true,
        },
    },
    filters = {
        dotfiles = false,
        custom = { '^node_modules$' },
    },
    git = {
        enable = true,
    },
    diagnostics = {
        enable = true,
    },
})
vim.keymap.set('n', '<leader>f', '<CMD>NvimTreeToggle<CR>', { desc = 'NvimTreeToggle', noremap = true, silent = true })
