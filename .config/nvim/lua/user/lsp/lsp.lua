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
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gpd', require('goto-preview').goto_preview_definition, bufopts)
    vim.keymap.set('n', 'gpi', require('goto-preview').goto_preview_implementation, bufopts)
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
    vim.keymap.set('n', '<space>lf', function() vim.lsp.buf.format { async = true } end, bufopts)
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
local names = {'clangd', 'pylsp', 'jsonls', 'bashls', 'tsserver', 'rust_analyzer'}
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
        null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.diagnostics.cmake_lint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.hover.dictionary,
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
    local opts = { noremap=true, silent=true }
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
