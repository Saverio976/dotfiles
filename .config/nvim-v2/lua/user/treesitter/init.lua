local treeseiter = require("nvim-treesitter.configs")

treeseiter.setup({
    ensure_installed = { "c", "bash", "python", "lua", "markdown", "javascript", "typescript", "vim" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    -- https://github.com/p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
})
