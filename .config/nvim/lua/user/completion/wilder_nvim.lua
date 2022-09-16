-- https://github.com/gelguy/wilder.nvim
-- wilder
local ok, wilder = pcall(require, 'wilder')
if not ok then
    return
end
wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
        highlights = {
            border = 'Normal',
        },
        border = 'rounded',
    })
))
