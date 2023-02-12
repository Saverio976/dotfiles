vim.keymap.set('i', '<S-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true })
vim.keymap.set('i', '<S-Down>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
vim.keymap.set('i', '<S-Up>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
vim.g.codeium_disable_bindings = 1
