vim.cmd([[au! BufLeave <buffer> if &modified == 1 | write | endif]])
vim.cmd([[au! FocusLost <buffer> if &modified == 1 | write | endif]])
