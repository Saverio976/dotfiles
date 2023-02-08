local api = vim.api

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
local okimp, impatient = pcall(require, 'impatient')
if okimp then
    impatient.enable_profile()
end
-- filetype
local ok, filetype = pcall(require, 'filetype')
if ok then
    filetype.setup({
        overrides = {
            extensions = {
                h = "c",
                hpp = "cpp",
                v = "v",
            }
        }
    })
end


require("user")
