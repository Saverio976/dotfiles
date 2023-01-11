-- https://github.com/editorconfig/editorconfig-vim
vim.cmd([[au FileType gitcommit let b:EditorConfig_disable = 1]])

local okundotree, undotree = pcall(require, 'undotree')
if okundotree then
    undotree.setup()
end

local okindentomatic, indentomatic = pcall(require, 'indent-o-matic')
if okindentomatic then
    indentomatic.setup({
        max_lines = 2048,
        standard_widths = { 2, 4, 8 },
        skip_multiline = true,
    })
end

vim.g.pydocstring_formatter = 'numpy'
