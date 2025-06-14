local cyberdream = require('cyberdream')

cyberdream.setup({
    italic_comments = true,
    borderless_pickers = true,
    cache = true,
    variant = 'auto',
})

vim.cmd([[colorscheme cyberdream]])
