local blink = require('blink.cmp')

blink.setup({
    keymap = { preset = 'super-tab' },
    completion = {
        menu = { border = 'single' },
        documentation = { window = { border = 'single' } },
    },
    signature = { window = { border = 'single' } },
    sources = {
        default = { 'lsp', 'path', 'buffer' },
        min_keyword_length = function(ctx)
            -- only applies when typing a command, doesn't apply to arguments
            if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 2 end
            return 0
        end
    },
})
