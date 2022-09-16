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
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            before = function (entry, vim_item)
                vim_item.menu = ({
                    buffer = "[Buff]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[Latex]",
                    rg = '[RG]'
                })[entry.source.name]
                return vim_item
            end
        })
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'path' },
        { name = 'rg' },
        { name = 'luasnip' },
    },
})
