require('saverio976.fterm.keybind')
require('saverio976.lsp.keybind')

vim.keymap.set('n', '??',
    '<CMD>noh<CR>',
    { silent = true, desc = 'remove highlight of search' }
)

vim.keymap.set('t', '<Esc><Esc>',
    [[<C-\><C-n>]],
    { silent = true, desc = 'exit insert mode in terminal mode' }
)

vim.keymap.set('n', '<leader>l',
    [[:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>]],
    { silent = true, noremap = true, desc = 'exit insert mode in terminal mode' }
)

vim.keymap.set('n', '<C-Up>',
    [[:execute 'move -1-'. v:count1<cr>]],
    { silent = true, noremap = true, desc = 'move line up' }
)

vim.keymap.set('n', '<C-Down>',
    [[:execute 'move +'. v:count1<cr>]],
    { silent = true, noremap = true, desc = 'move line down' }
)

vim.keymap.set('x', '<',
    [[<gv]],
    { silent = true, noremap = true, desc = 'stay selected when increment down' }
)

vim.keymap.set('x', '>',
    [[>gv]],
    { silent = true, noremap = true, desc = 'stay selected when increment up' }
)

vim.keymap.set('n', '<leader>a',
    [[:execute "normal! g`\""<cr>]],
    { silent = true, noremap = true, desc = 'go where cursor was before least leave' }
)
