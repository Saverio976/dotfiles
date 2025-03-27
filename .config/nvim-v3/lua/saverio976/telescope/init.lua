local telescope = require("telescope")

local actions = require("telescope.actions")

local fb_actions = telescope.extensions.file_browser.actions

local vimgrep_arguments = {
    'grep',

    '--color=never',
    '--dereference-recursive', -- recurse subdirectory
    '--with-filename', -- show filename
    '--line-number', -- show line number
    '-b', -- show byte offset from start,
          -- this is not telescope want, but it shows the line, and when
          -- the line is selected, it goes to the last character of the line
          -- because it is out of column

    '--binary-files=without-match',
    '--exclude-dir=.bzr',
    '--exclude-dir=.CVS',
    '--exclude-dir=.git',
    '--exclude-dir=.hg',
    '--exclude-dir=.svn',
    '--exclude-dir=.idea',
    '--exclude-dir=.tox',
    '--exclude-dir=__pycache__',
    '--exclude-dir=node_modules',
    '--exclude-dir=.gradle'
}

telescope.setup({
    defaults = {
        initial_mode = 'insert',
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {
            '__pycache__/', '__pycache__/*',
            'node_modules/', 'node_modules/*',
            'dist/', 'dist/*', 'build/', 'build/*',
            '\\.git/', '\\.git/*',
            '\\.gradle', '\\.idea/', '\\.vscode/',
            '\\.dll', '\\.idea/*', '\\.vscode/*',
            '*\\.o', '*\\.a', '*\\.lib',
        },
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        live_grep = {
            preview = {
                treesitter = false
            }
        },
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<ESC>'] = actions.close,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            case_mode = 'smart_case'
        },
        file_browser = {
            hijack_netrw = true,
            mappings = {
                ['i'] = {
                    ['<C-a>'] = fb_actions.create,
                    ['<C-r>'] = fb_actions.rename,
                    ['<C-c>'] = fb_actions.copy,
                    ['<C-d>'] = fb_actions.remove,
                },
                ['n'] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
    pickers = {
        find_files = {
            find_command = { 'find', '.', '(', '!', '-path', '*/.git/*', '-and', '-type', 'f', ')' }
        },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')

require('saverio976.telescope.keybind')
