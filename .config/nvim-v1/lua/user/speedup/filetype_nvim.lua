-- speed up startup time
-- https://github.com/nathom/filetype.nvim
-- filetype

local ok, filetype = pcall(require, 'filetype')
if not ok then
  return
end

filetype.setup({
  overrides = {
    extensions = {
      h = "c",
      v = "v",
      hpp = "cpp",
    }
  }
})
