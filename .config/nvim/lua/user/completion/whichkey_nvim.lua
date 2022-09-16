-- https://github.com/folke/which-key.nvim
-- which-key
local ok, whichkey = pcall(require, 'which-key')
if not ok then
    return
end
whichkey.setup({
    registers = true,
})
