-- https://github.com/norcalli/nvim-colorizer.lua
-- colorizer
local okcolo, colorizer = pcall(require, 'colorizer')
if not okcolo then
    return
end
colorizer.setup()
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- indent_blankline
local okblankline, blankline = pcall(require, 'indent_blankline')
if not okblankline then
    return
end
blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
-- https://github.com/lewis6991/gitsigns.nvim
-- gitsigns
local okgit, gitsigns = pcall(require, 'gitsigns')
if not okgit then
    return
end
gitsigns.setup()
-- https://github.com/stevearc/dressing.nvim
-- dressing
local okdressing, dressing = pcall(require, 'dressing')
if not okdressing then
    return
end
dressing.setup()
-- https://github.com/rcarriga/nvim-notify
-- notify
local oknotif, notify = pcall(require, 'notify')
if not oknotif then
    return
end
notify.setup({ background_color = '#000000' })
vim.notify = notify
-- https://github.com/kyazdani42/nvim-web-devicons
-- nvim-web-devicons
local okdevicon, devicons = pcall(require, 'nvim-web-devicons')
if not okdevicon then
    return
end
if not devicons.has_loaded() then
    devicons.setup({
        default = true,
    })
end
