---------------------------------------------------
-- LSPCONFIG
-- https://github.com/neovim/nvim-lspconfig
-- see https://langserver.org/ full list of language server
-- lspconfig
local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end
local on_attach_ = function (_, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'lsp.buf.declaration', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp.buf.definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'lsp.buf.implementation', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gpd', require('goto-preview').goto_preview_definition, { desc = 'goto-preview.definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gpi', require('goto-preview').goto_preview_implementation, { desc = 'goto-preview.implementation', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'lsp.buf.signature-help', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwa', vim.lsp.buf.add_workspace_folder, { desc = 'lsp.buf.add_workspace_folder', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwr', vim.lsp.buf.remove_workspace_folder, { desc = 'lsp.buf.remove_workspace_folder', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { desc = 'lsp.buf.list_workspace_folders', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = 'lsp.buf.type_definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = 'lsp.buf.rename', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = 'lsp.buf.code_action', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'lsp.buf.references', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, { desc = 'lsp.buf.format', noremap=true, silent=true, buffer=bufnr })
end
local okcmplsp, cmplsp = pcall(require, 'cmp_nvim_lsp')
local cap = nil
if not okcmplsp then
    cap = cmplsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
end
local function try_setup_server(server, lspconf, on_attach, capabilities)
    lspconf[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local names = {'clangd', 'pyright', 'jsonls', 'bashls', 'tsserver', 'rust_analyzer', 'hls'} -- 'pylsp'
for _, lang in ipairs(names) do
    try_setup_server(lang, lspconfig, on_attach_, cap)
end

---------------------------------------------------
-- LSPKIND
-- https://github.com/onsails/lspkind-nvim
-- lspkind
local oklspkind, lspkind = pcall(require, 'lspkind')
if oklspkind then
    lspkind.init({
        modes = 'symbol_text',
        preset = 'default',
    })
end

---------------------------------------------------
-- NULL-LS
-- https://github.com/jose-elias-alvarez/null-ls.nvim
-- null-ls
local oknulls, null_ls = pcall(require, 'null-ls')
if oknulls then
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local sources = {
        null_ls.builtins.diagnostics.luacheck,
    }
    null_ls.setup({
        sources = sources,
    })
end

---------------------------------------------------
-- TROUBLE
-- https://github.com/folke/trouble.nvim
-- trouble
local oktroubl, trouble = pcall(require, 'trouble')
if oktroubl then
    vim.keymap.set('n', 'gt', '<CMD>TroubleToggle<CR>', { desc = 'TroubleToggle', noremap=true, silent=true })
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
end

local okgotopreview, gotopreview = pcall(require, 'goto-preview')
if okgotopreview then
    gotopreview.setup({})
end

local oklspcolor, lspcolor = pcall(require, 'lsp-colors')
if oklspcolor then
    lspcolor.setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
    })
end

local oklsprogress, lsprogress = pcall(require, 'fidget')
if oklsprogress then
    lsprogress.setup({})
end
