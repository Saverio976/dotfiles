local fterm = require('FTerm')

fterm.setup({
    border = 'double',
    cmd = vim.opt.shell:get(),
    dimensions = {
        height = 1.0,
        width = 1.0,
    },
})
