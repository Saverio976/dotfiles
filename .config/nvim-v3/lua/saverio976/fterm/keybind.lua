vim.keymap.set('n', '<A-=>',
    '<CMD>lua require("FTerm").toggle()<CR>',
    { desc = 'FTermToggle', noremap=true, silent=true })

vim.keymap.set('t', '<A-=>',
    '<CMD>lua require("FTerm").toggle()<CR>',
    { desc = 'FTermToggle', noremap=true, silent=true})
