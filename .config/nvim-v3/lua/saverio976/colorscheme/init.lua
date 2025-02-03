local cyberdream = require('cyberdream')

cyberdream.setup({
    italic_comments = true,
    cache = true,
    theme = {
        variant = 'auto'
    }
})

vim.cmd([[colorscheme cyberdream]])
