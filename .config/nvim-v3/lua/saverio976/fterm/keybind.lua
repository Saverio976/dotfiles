local km_set = vim.keymap.set

km_set('n', '<A-=>',
    '<CMD>lua require("FTerm").toggle()<CR>',
    { desc = 'FTermToggle', noremap=true, silent=true }
)

km_set('t', '<A-=>',
    '<CMD>lua require("FTerm").toggle()<CR>',
    { desc = 'FTermToggle', noremap=true, silent=true}
)
