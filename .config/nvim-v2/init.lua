local api = vim.api

-- https://github.com/jdhao/nvim-config/blob/master/lua/utils.lua
function get_nvim_version()
    local actual_ver = vim.version()

    local nvim_ver_str = string.format("%d.%d.%d", actual_ver.major, actual_ver.minor, actual_ver.patch)
    return nvim_ver_str
end
local expected_ver = "0.8.2"
local nvim_ver = get_nvim_version()

-- https://github.com/jdhao/nvim-config/blob/master/init.lua
if nvim_ver ~= expected_ver then
    local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
    api.nvim_err_writeln(msg)
    return
end

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
                hpp = "cpp",
            }
        }
    })
end


require("user")
