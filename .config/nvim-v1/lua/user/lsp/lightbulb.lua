local oklightbulb, _ = pcall(require, 'nvim-lightbulb')
if not oklightbulb then
    return
end
vim.cmd([[au! BufEnter * lua require('nvim-lightbulb').update_lightbulb()]])
vim.cmd([[au! BufWritePost * lua require('nvim-lightbulb').update_lightbulb()]])
