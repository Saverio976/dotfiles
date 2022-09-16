-- https://github.com/booperlv/nvim-gomove
-- gomove
local ok, gomove = pcall(require, 'gomove')
if not ok then
    return
end
gomove.setup()
