-- https://github.com/feline-nvim/feline.nvim
-- feline

local okfeline, feline = pcall(require, 'feline')
if not okfeline then
    return
end
local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local components = {
    active = {},
    inactive = {},
}
components.active[1] = {
    {
        provider = function ()
            local mode = vim.api.nvim_exec('echo mode()', true)
            if mode == "" then return "C" else return string.upper(mode) end
        end,
        hl = function ()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                fg = vi_mode_utils.get_mode_color(),
                style = 'bold',
            }
        end,
        right_sep = '',
    },
    {
        provider = {
            name = 'file_info',
            opts = { type = 'short-path' }
        },
        hl = { fg = 'green', bg = 'f_color' },
        left_sep = {
            ' ', 'slant_left_2',
            { str = ' ', hl = { bg = 'f_color', fg = 'NONE' } },
        },
    },
    {
        provider = function ()
            local filetype = vim.bo.filetype
            if filetype == "" then return " " else return " [" .. filetype .. "]" end
        end,
        hl = { fg = 'yellow', bg = 'f_color', style = 'NONE' },
        right_sep = { 'slant_left_2', ' ' },
    },
    {
        provider = 'git_branch',
        hl = { fg = 'cyan2', bg = 'bg', style = 'bold' },
        right_sep = function ()
            local val = { hl = { fg = 'NONE', bg = 'bg' } }
            if vim.b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
            return val
        end,
    },
    {
        provider = 'git_diff_added',
        icon = { str = '+', hl = { fg = 'green', style = 'bold' } },
        hl = { fg = 'green', style = 'bold' },
    },
    {
        provider = 'git_diff_changed',
        icon = { str = '~', hl = { fg = 'orange', style = 'bold' } },
        hl = { fg = 'orange', style = 'bold' },
    },
    {
        provider = 'git_diff_removed',
        icon = { str = '-', hl = { fg = 'red', style = 'bold' } },
        hl = { fg = 'red', style = 'bold' },
        right_sep = function ()
            local val = { hl = { fg = 'NONE', bg = 'bg' } }
            if vim.b.gitsigns_status_dict then val.str = ' ' else val.str = '' end
            return val
        end,
    },
}

components.active[2] = {
    {
        provider = 'diagnostic_errors',
        enabled = function () return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
        hl = { gf = 'red' },
    },
    {
        provider = 'diagnostic_warnings',
        enabled = function () return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
        hl = { gf = 'yellow' },
    },
    {
        provider = 'diagnostic_hints',
        enabled = function () return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
        hl = { gf = 'cyan' },
    },
    {
        provider = 'diagnostic_info',
        enabled = function () return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
        hl = { gf = 'skyblue' },
    },
    {
        provider = function ()
            local buff_ft = vim.api.nvim_buf_get_option(0, 'filetype')
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then return '' end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buff_ft) ~= -1 then
                    if client.name ~= 'null-ls' then return '[' .. client.name .. ']' end
                end
            end
	    return ''
        end,
        hl = { fg = 'black', style = 'italic' },
    }
}
feline.setup({
    components = components
})
