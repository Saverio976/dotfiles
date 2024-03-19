local treeseiter = require("nvim-treesitter.configs")

treeseiter.setup({
    ensure_installed = { "c", "bash", "python", "lua", "markdown", "javascript", "typescript", "vim" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = true,
    },
})
