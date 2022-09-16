-- https://github.com/airblade/vim-rooter
local patterns = [['.git', 'Makefile', 'CMakeLists.txt', 'node_modules']]
vim.cmd("let g:rooter_patterns = [" .. patterns .. "]")
