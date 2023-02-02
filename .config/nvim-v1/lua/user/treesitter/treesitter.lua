-- https://github.com/nvim-treesitter/nvim-treesitter
-- nvim-treesitter
local ok, treeseiter = pcall(require, 'nvim-treesitter.configs')
if not ok then
    return
end
treeseiter.setup {
    ensure_installed = { "c", "bash", "python" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
    -- https://github.com/p00f/nvim-ts-rainbow
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
}
-- https://github.com/m-demare/hlargs.nvim
-- hlargs
local okhlarg, hlargs = pcall(require, 'hlargs')
if not okhlarg then
    return
end
hlargs.setup()
