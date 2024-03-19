require("bluloco").setup({
    style = "dark",
    transparent = false,
    italics = vim.fn.has("gui_running") == 1,
})

vim.cmd('colorscheme bluloco')
