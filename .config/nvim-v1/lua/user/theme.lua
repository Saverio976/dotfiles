-- -- Tokyonight
vim.g.tokyonight_style = 'storm'
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_day_brightness = 0.3
-- pcall(vim.cmd, [[colorscheme tokyonight]])

-- -- Minimal
-- vim.g.minimal_italic_comments = false
-- vim.g.minimal_italic_keywords = true
-- vim.g.minimal_italic_functions = true
-- vim.g.minimal_transparent_background = true
-- pcall(vim.cmd, [[colorscheme minimal]])

-- -- Lighthaus
local oklightaus, lighthaus = pcall(require, "lighthaus")
if oklightaus then
    lighthaus.setup({
        bg_dark = true,
        lsp_underline_style = 'undercurl', -- 'underline' -- ''
        transparent = false,
        italic_comments = true,
        italic_keywords = true,
    })
    pcall(vim.cmd, [[colorscheme lighthaus]])
else
    pcall(vim.cmd, [[colorscheme tokyonight]])
end
