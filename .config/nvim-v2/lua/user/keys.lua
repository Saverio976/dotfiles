local set_km = vim.keymap.set

set_km('n', '??', '<CMD>noh<CR>', {silent = true, desc = 'remove highlight of search'})

set_km('n', '<A-=>', '<CMD>FloatermToggle<CR>', {desc = 'FloatTermToggle', noremap=true, silent=true})
set_km('t', '<A-=>', '<CMD>FloatermToggle<CR>', {desc = 'FloatTermToggle', noremap=true, silent=true})

set_km('t', '<Esc><Esc>', [[<C-\><C-n>]])

set_km('n', '<space>e', vim.diagnostic.open_float, { desc = 'diagnostic.open_float', noremap=true, silent=true })
set_km('n', '[d', vim.diagnostic.goto_prev, { desc = 'diagnostic.goto_prev', noremap=true, silent=true })
set_km('n', ']d', vim.diagnostic.goto_next, { desc = 'diagnostic.goto_next', noremap=true, silent=true })
set_km('n', '<space>q', vim.diagnostic.setloclist, { desc = 'diagnostic.setloclist', noremap=true, silent=true })
set_km('n', 'K', vim.lsp.buf.hover, { desc = 'lsp.buf.hover', noremap=true, silent=true })

vim.cmd([[
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

nnoremap <C-Up> :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap <C-Down> :<c-u>execute 'move +'. v:count1<cr>

xnoremap < <gv
xnoremap > >gv
]])
