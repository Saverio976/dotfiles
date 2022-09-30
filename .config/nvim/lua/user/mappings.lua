vim.keymap.set('n', '??', '<CMD>noh<CR>', {silent = true})

vim.keymap.set('n', '<A-=>', '<CMD>FloatermToggle<CR>', {silent= true, noremap= true})
vim.keymap.set('t', '<A-=>', '<CMD>FloatermToggle<CR>', {silent= true, noremap= true})

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])


local ok, undotree = pcall(require, 'undotree')
if ok then
    vim.keymap.set('n', '<leader>u', undotree.toggle, { noremap= true, silent= true })
end
	
