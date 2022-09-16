-- https://github.com/nyngwang/NeoZoom.lua
-- neo-zoom
local ok, neozoom = pcall(require, 'neo-zoom')
if not ok then
    return
end
neozoom.setup({
    left_ratio = 0.2,
    top_ratio = 0.03,
    width_ratio = 0.75,
    height_ratio = 1,
    border = 'rounded',
})
local opts = { silent = true, noremap = true }
vim.keymap.set('n', '<leader>m', '<cmd>NeoZoomToggle<cr>', opts)
