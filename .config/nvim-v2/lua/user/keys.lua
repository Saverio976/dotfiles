vim.keymap.set('n', '??', '<CMD>noh<CR>', {silent = true, desc = 'remove highlight of search'})

vim.keymap.set('n', '<A-=>', '<CMD>FloatermToggle<CR>', {desc = 'FloatTermToggle', noremap=true, silent=true})
vim.keymap.set('t', '<A-=>', '<CMD>FloatermToggle<CR>', {desc = 'FloatTermToggle', noremap=true, silent=true})

vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

local ok, undotree = pcall(require, 'undotree')
if ok then
    vim.keymap.set('n', '<leader>u', undotree.toggle, {desc = 'undotree', noremap=true, silent=true})
end

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'diagnostic.open_float', noremap=true, silent=true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'diagnostic.goto_prev', noremap=true, silent=true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'diagnostic.goto_next', noremap=true, silent=true })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'diagnostic.setloclist', noremap=true, silent=true })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp.buf.hover', noremap=true, silent=true })

vim.cmd([[
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
]])

vim.cmd([[
nnoremap <C-Up> :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap <C-Down> :<c-u>execute 'move +'. v:count1<cr>
]])

vim.cmd([[
xnoremap < <gv
xnoremap > >gv
]])
