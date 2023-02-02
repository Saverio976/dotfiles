local ok = require("neo-zoom")

neozoom.setup({
    left_ratio = 0.2,
    top_ratio = 0.03,
    width_ratio = 0.75,
    height_ratio = 1,
    border = "rounded",
})

vim.keymap.set("n", "<leader>m", "<cmd>NeoZoomToggle<cr>", { desc = "NeoZoomToggle", silent = true, noremap = true })
