local neozoom = require("neo-zoom")

neozoom.setup({
    winopts = {
        offset = {
            width = 0.95,
            height = 0.95,
        },
        border = "rounded",
    },
})

vim.keymap.set("n", "<leader>m", "<cmd>NeoZoomToggle<cr>", { desc = "NeoZoomToggle", silent = true, noremap = true })
