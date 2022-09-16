-- speed up startup time
-- https://github.com/lewis6991/impatient.nvim
-- impatient

_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}

pcall(require, 'imaptient')
