local opts = { noremap=true, silent=true }

vim.keymap.set('n', '??', '<CMD>noh<CR>', {silent = true})

vim.keymap.set('n', '<A-=>', '<CMD>FloatermToggle<CR>', opts)
vim.keymap.set('t', '<A-=>', '<CMD>FloatermToggle<CR>', opts)

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

local ok, undotree = pcall(require, 'undotree')
if ok then
    vim.keymap.set('n', '<leader>u', undotree.toggle, opts)
end

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
