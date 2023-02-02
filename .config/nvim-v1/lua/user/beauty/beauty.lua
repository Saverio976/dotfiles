-- https://github.com/norcalli/nvim-colorizer.lua
-- colorizer
local okcolo, colorizer = pcall(require, 'colorizer')
if okcolo then
    colorizer.setup()
end
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- indent_blankline
local okblankline, blankline = pcall(require, 'indent_blankline')
if okblankline then
    blankline.setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    })
end

-- https://github.com/lewis6991/gitsigns.nvim
-- gitsigns
local okgit, gitsigns = pcall(require, 'gitsigns')
if okgit then
    gitsigns.setup()
end
-- https://github.com/stevearc/dressing.nvim
-- dressing
local okdressing, dressing = pcall(require, 'dressing')
if okdressing then
    dressing.setup()
end
-- https://github.com/rcarriga/nvim-notify
-- notify
local oknotif, notify = pcall(require, 'notify')
if oknotif then
    notify.setup({
        background_colour = '#000000',
        stages = 'static',
        fps = 2,
        timeout = 4000
    })
    vim.notify = notify
end
-- https://github.com/kyazdani42/nvim-web-devicons
-- nvim-web-devicons
local okdevicon, devicons = pcall(require, 'nvim-web-devicons')
if okdevicon then
    if not devicons.has_loaded() then
        devicons.setup({
            default = true,
        })
    end
end

local okmodicator, modicator = pcall(require, 'modicator')
if okmodicator then
    modicator.setup()
end
