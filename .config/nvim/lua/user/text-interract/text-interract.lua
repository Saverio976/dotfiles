-- https://github.com/editorconfig/editorconfig-vim
vim.cmd([[au FileType gitcommit let b:EditorConfig_disable = 1]])

local ok, undotree = pcall(require, 'undotree')
if not ok then
    return
end
undotree.setup()
