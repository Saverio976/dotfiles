vim.cmd([[au! BufLeave <buffer> if &modified == 1 | write | endif]])
vim.cmd([[au! FocusLost <buffer> if &modified == 1 | write | endif]])

vim.cmd([[au! BufEnter *.h set filetype=c]])

vim.cmd([[
augroup ImageAutocmdGroup
au! BufEnter *.png set filetype=png
au! BufEnter *.jpg set filetype=jpg
au! BufEnter *.jpeg set filetype=jpeg
au! BufEnter *.webp set filetype=webp
augroup END
]])
