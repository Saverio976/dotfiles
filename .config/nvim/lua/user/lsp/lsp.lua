---------------------------------------------------
-- LSPCONFIG
-- https://github.com/neovim/nvim-lspconfig
-- lspconfig
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
local on_attach = function (_, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>lf', vim.lsp.buf.formatting, bufopts)
end
local okcmplsp, cmplsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = nil
if not okcmplsp then
    capabilities = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end
local function try_setup_server(server, _lspconfig, _on_attach, _capabilities)
    _lspconfig[server].setup({
        on_attach = _on_attach,
        capabilities = _capabilities,
    })
end
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
try_setup_server('clangd', lspconfig, on_attach, capabilities)
try_setup_server('pyright', lspconfig, on_attach, capabilities)
try_setup_server('jsonls', lspconfig, on_attach, capabilities)
try_setup_server('bashls', lspconfig, on_attach, capabilities)
try_setup_server('tsserver', lspconfig, on_attach, capabilities)
try_setup_server('clangd', lspconfig, on_attach, capabilities)

---------------------------------------------------
-- LSPKIND
-- https://github.com/onsails/lspkind-nvim
-- lspkind
local oklspkind, lspkind = pcall(require, 'lspkind')
if not oklspkind then
    return
end
lspkind.init({
    modes = 'symbol_text',
    preset = 'default',
})

---------------------------------------------------
-- NULL-LS
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- null-ls
local oknulls, null_ls = pcall(require, 'null-ls')
if not oknulls then
    return
end
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.spell,
}
null_ls.setup({
    sources = sources,
})

---------------------------------------------------
-- TROUBLE
-- https://github.com/folke/trouble.nvim
-- trouble
local oktroubl, trouble = pcall(require, 'trouble')
if not oktroubl then
    return
end
opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gt', '<CMD>TroubleToggle<CR>', opts)
trouble.setup({
    position = "bottom",
	height = 7,
	width = 50,
	icons = true,
	mode = "workspace_diagnostics",
	fold_open = "",
	fold_closed = "",
	indent_lines = true,
	auto_open = false,
	auto_close = true,
	auto_preview = false,
	auto_fold = false,
	signs = {
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
	use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    action_keys = {
        close = 'q',
        cancel = '<ESC>',
        jump = {'<CR>'},
        open_split = {'<c-x>'},
        open_vsplit = {'<c-v>'},
        jump_close = {'<TAB>'},
        hover = 'K',
    },
})
