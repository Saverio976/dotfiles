-- https://github.com/hrsh7th/nvim-cmp
-- cmp
local okcmp, cmp = pcall(require, 'cmp')
if not okcmp or not cmp then
    return
end
local oklspkind, lspkind = pcall(require, 'lspkind')
if not oklspkind then
    lspkind = {}
    function lspkind.cmp_format(_)
        print('error loading lspkind')
        return nil
    end
end
local okcmpunder, cmpunder = pcall(require, 'cmp-under-comparator')
local func_cmp_under
if okcmpunder then
    func_cmp_under = cmpunder.under
else
    func_cmp_under = function (_entry1, _entry2) end
end
local oktabninecmp, tabninecmp = pcall(require, 'cmp_tabnine.compare')
local func_cmp_tabnine
if oktabninecmp then
    func_cmp_tabnine = tabninecmp
else
    func_cmp_tabnine = function (_entry1, _entry2) end
end

local source_mapping = {
    nvim_lsp = "[LSP]",
    luasnip = "[LuaSnip]",
    rg = '[RG]',
    buffer = "[Buffer]",
    cmp_tabnine = "[TN]",
    path = "[Path]",
}

cmp.setup({
    snippet = {
        expand = function(args)
            local oksnip, luasnip = pcall(require, 'luasnip')
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
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    completion = {
        completopt = 'menuone,preview,noinsert,noselect,'
    },
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            func_cmp_under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
            func_cmp_tabnine,
        },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol_text"})
            vim_item.menu = source_mapping[entry.source.name]
            if entry.source.name == "cmp_tabnine" then
                local detail = (entry.completion_item.data or {}).detail
                vim_item.kind = ""
                if detail and detail:find('.*%%.*') then
                    vim_item.kind = vim_item.kind .. ' ' .. detail
                end

                if (entry.completion_item.data or {}).multiline then
                    vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                end
            end
            local maxwidth = 80
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
        end,

    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        {
            name = 'rg',
            option = {
                additional_arguments = "--max-depth 4 --hidden",
                debounce = 100
            },
            keyword_length = 2
        },
        { name = 'luasnip' },
        { name = 'cmp_tabnine' }
    },
})

-- auto pairs () [] {} ...
-- https://github.com/windwp/nvim-autopairs
local okautopairs, autopairs = pcall(require, 'nvim-autopairs')
if okautopairs then
    local del_keymaps = function() -- found at https://github.com/windwp/nvim-autopairs/blob/master/lua/nvim-autopairs.lua#L140
        local status, autopairs_keymaps = pcall(vim.api.nvim_buf_get_var, 0, 'autopairs_keymaps')
        if status and autopairs_keymaps and #autopairs_keymaps > 0 then
            for _, key in pairs(autopairs_keymaps) do
                pcall(vim.api.nvim_buf_del_keymap, 0, 'i', key)
            end
        end
    end
    autopairs.setup({
        enable_check_bracket_line = true,
        ignored_next_char = "[%w%.]",
    })
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
    )
    del_keymaps()
end
