local cmp = require("cmp")

local lspkind = require("lspkind")

local cmpunder = require("cmp-under-comparator")
local func_cmp_under = cmpunder.under

local cmp_buffer = require("cmp_buffer")

cmp.setup({
    snippet = {
        expand = function(args)
            local oksnip, luasnip = pcall(require, "luasnip")
            if not oksnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    }),
    completion = {
        completopt = "menuone,preview,noinsert,noselect,"
    },
    sorting = {
        comparators = {
            function(...) return cmp_buffer:compare_locality(...) end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            func_cmp_under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            symbol_map = { Codeium = "", },
            before = function (entry, vim_item)
                return vim_item
            end
        })
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    local bufs = {}
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                        if byte_size <= 1024 * 1024 then -- 1 Megabyte max
                            bufs[buf] = true
                        end
                    end
                    return vim.tbl_keys(bufs)
                end
            },
        },
        { name = "path" },
        -- {
        --     name = "rg",
        --     option = {
        --         additional_arguments = "--max-depth 4 --hidden",
        --         debounce = 100
        --     },
        --     keyword_length = 2
        -- },
        { name = "luasnip" },
        -- { name = "codeium" },
    },
})

-- auto pairs () [] {} ...
-- https://github.com/windwp/nvim-autopairs
local autopairs = require("nvim-autopairs")
local del_keymaps = function() -- found at https://github.com/windwp/nvim-autopairs/blob/master/lua/nvim-autopairs.lua#L140
    local status, autopairs_keymaps = pcall(vim.api.nvim_buf_get_var, 0, "autopairs_keymaps")
    if status and autopairs_keymaps and #autopairs_keymaps > 0 then
        for _, key in pairs(autopairs_keymaps) do
            pcall(vim.api.nvim_buf_del_keymap, 0, "i", key)
        end
    end
end
autopairs.setup({
    enable_check_bracket_line = true,
    ignored_next_char = "[%w%.]",
})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done()
)
del_keymaps()
