require('undotree').setup()

vim.keymap.set('n', '<leader>u',
    require('undotree').toggle,
    { desc = 'undotree', noremap=true, silent=true })
