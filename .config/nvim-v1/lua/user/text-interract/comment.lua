-- https://github.com/numToStr/Comment.nvim
-- Comment
local ok, comment = pcall(require, 'Comment')
if not ok then
    return
end
comment.setup({
    mappings = {
        extra = false,
    },
})
