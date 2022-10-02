-- https://github.com/editorconfig/editorconfig-vim
vim.cmd([[au FileType gitcommit let b:EditorConfig_disable = 1]])

local okundotree, undotree = pcall(require, 'undotree')
if okundotree then
    undotree.setup()
end

local okindentomatic, indentomatic = pcall(require, 'indent-o-matic')
if okindentomatic then
    indentomatic.setup()
end
