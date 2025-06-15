local lspconfig = require('lspconfig')

local on_attach_ = function (_, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD',
        vim.lsp.buf.declaration,
        { desc = 'lsp.buf.declaration', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gd',
        vim.lsp.buf.definition,
        { desc = 'lsp.buf.definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gi',
        vim.lsp.buf.implementation,
        { desc = 'lsp.buf.implementation', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gpd',
        require('goto-preview').goto_preview_definition,
        { desc = 'goto-preview.definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gpi',
        require('goto-preview').goto_preview_implementation,
        { desc = 'goto-preview.implementation', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<C-k>',
        vim.lsp.buf.signature_help,
        { desc = 'lsp.buf.signature-help', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwa',
        vim.lsp.buf.add_workspace_folder,
        { desc = 'lsp.buf.add_workspace_folder', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwr',
        vim.lsp.buf.remove_workspace_folder,
        { desc = 'lsp.buf.remove_workspace_folder', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lwl',
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = 'lsp.buf.list_workspace_folders', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>D',
        vim.lsp.buf.type_definition,
        { desc = 'lsp.buf.type_definition', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>rn',
        vim.lsp.buf.rename,
        { desc = 'lsp.buf.rename', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>ca',
        vim.lsp.buf.code_action,
        { desc = 'lsp.buf.code_action', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', 'gr',
        vim.lsp.buf.references,
        { desc = 'lsp.buf.references', noremap=true, silent=true, buffer=bufnr })
    vim.keymap.set('n', '<space>lf',
        function() vim.lsp.buf.format({ async = true }) end,
        { desc = 'lsp.buf.format', noremap=true, silent=true, buffer=bufnr })
end

local cap = require('blink.cmp').get_lsp_capabilities()

local function try_setup_server(server, lspconf, on_attach, capabilities)
    vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
    })
    vim.lsp.enable(server)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local names = {
    -- 'marksman',              -- md           -- https://github.com/artempyanykh/marksman

    'clangd',                -- c            -- https://clangd.llvm.org/installation.html
    -- 'cmake',                 -- cmake        -- https://github.com/regen100/cmake-language-server

    -- 'pyright',               -- py           -- https://github.com/microsoft/pyright
    'basedpyright',

    -- 'bashls',                -- bash         -- https://github.com/mads-hartmann/bash-language-server
    -- 'dockerls',              -- docker       -- https://github.com/rcjsuen/dockerfile-language-server-nodejs

    'ts_ls',              -- js/ts        -- https://github.com/typescript-language-server/typescript-language-server
    -- 'cssls',                 -- css          -- https://github.com/hrsh7th/vscode-langservers-extracted
    -- 'html',                  -- html         -- https://github.com/hrsh7th/vscode-langservers-extracted
    -- 'jsonls',                -- json         -- https://github.com/hrsh7th/vscode-langservers-extracted

    'hls',                   -- haskell      -- https://github.com/haskell/haskell-language-server
    -- 'asm_lsp',               -- asm GAS/GOS  -- https://github.com/bergercookie/asm-lsp
    -- 'rust_analyzer',         -- rust         -- https://github.com/rust-analyzer/rust-analyzer
    -- 'dartls',                -- dart         -- https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server/tool/lsp_spec
    'jdtls',                 -- java         -- https://projects.eclipse.org/projects/eclipse.jdt.ls
    -- 'lua_ls',           -- lua          -- https://github.com/sumneko/lua-language-server
    -- 'ansiblels',         -- ansible      -- https://github.com/ansible/ansible-language-server
    -- 'csharp_ls',      -- dotnet       -- https://github.com/razzmatazz/csharp-language-server
}
for _, lang in ipairs(names) do
    try_setup_server(lang, lspconfig, on_attach_, cap)
end

local gotopreview = require('goto-preview')
gotopreview.setup({})

require('saverio976.lsp.keybind')
