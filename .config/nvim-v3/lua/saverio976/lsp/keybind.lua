local km_set = vim.keymap.set

km_set('n', '<space>e',
    vim.diagnostic.open_float,
    { desc = 'diagnostic.open_float', noremap=true, silent=true }
)

km_set('n', '[d',
    vim.diagnostic.goto_prev,
    { desc = 'diagnostic.goto_prev', noremap=true, silent=true }
)

km_set('n', ']d',
    vim.diagnostic.goto_next,
    { desc = 'diagnostic.goto_next', noremap=true, silent=true }
)

km_set('n', '<space>q',
    vim.diagnostic.setloclist,
    { desc = 'diagnostic.setloclist', noremap=true, silent=true }
)

km_set('n', 'K',
    vim.lsp.buf.hover,
    { desc = 'lsp.buf.hover', noremap=true, silent=true }
)
