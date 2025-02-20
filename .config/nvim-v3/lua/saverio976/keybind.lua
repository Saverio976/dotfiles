require('saverio976.fterm.keybind')

local km_set = vim.keymap.set

km_set('n', '??',
    '<CMD>noh<CR>',
    { silent = true, desc = 'remove highlight of search' }
)

km_set('t', '<Esc><Esc>',
    [[<C-\><C-n>]],
    { silent = true, desc = 'exit insert mode in terminal mode' }
)

km_set('n', '<leader>l',
    [[:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>]],
    { silent = true, noremap = true, desc = 'exit insert mode in terminal mode' }
)

km_set('n', '<C-Up>',
    [[:execute 'move -1-'. v:count1<cr>]],
    { silent = true, noremap = true, desc = 'move line up' }
)

km_set('n', '<C-Down>',
    [[:execute 'move +'. v:count1<cr>]],
    { silent = true, noremap = true, desc = 'move line down' }
)

km_set('x', '<',
    [[<gv]],
    { silent = true, noremap = true, desc = 'stay selected when increment down' }
)

km_set('x', '>',
    [[>gv]],
    { silent = true, noremap = true, desc = 'stay selected when increment up' }
)

km_set('n', '<leader>a',
    [[:execute "normal! g`\""<cr>]],
    { silent = true, noremap = true, desc = 'go where cursor was before least leave' }
)
