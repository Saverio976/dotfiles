local lighthaus = require("lighthaus")

lighthaus.setup({
    bg_dark = true,
    lsp_underline_style = 'undercurl', -- 'underline' -- ''
    transparent = false,
    italic_comments = true,
    italic_keywords = true,
})
vim.cmd([[colorscheme lighthaus]])
