local function ts_configs()
    return require 'nvim-treesitter.configs'
end

return {
    {
        'nvim-treesitter/nvim-treesitter', -- AST-based highlighting, indentation, and more...
        build = ':TSUpdate',
        config = function()
            ts_configs().setup {
                ensure_installed = {
                    -- Required for Treesitter to function parsers
                    'c',
                    'lua',
                    'vim',
                    'vimdoc',
                    'query',
                    -- Additional parsers
                    'diff',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    'http',
                    'comment',
                    'markdown',
                    'json',
                    'dockerfile',
                    'yaml',
                    'terraform',
                    'hcl',
                    'sql',
                    'java',
                },

                sync_install = false, -- Install parsers synchronously
                auto_install = true, -- Auto-install missing parsers when entering buffer

                highlight = {
                    -- Enable Treesitter-based syntax highlighting
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    additional_vim_regex_highlighting = false,
                },

                indent = { enable = false },
                incremental_selection = { enable = true },
            }
        end,
    },
    {
        -- Movements, selections, and swapping with Treesitter objects
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            ts_configs().setup {
                textobjects = {
                    select = {
                        -- Enable textobj selection
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        keymaps = {
                            ['ia'] = { query = '@parameter.inner', desc = 'inner [a]rgument' },
                            ['aa'] = { query = '@parameter.outer', desc = 'an [a]rgument' },
                            ['ic'] = { query = '@class.inner', desc = 'inner [c]lass' },
                            ['ac'] = { query = '@class.outer', desc = 'a [c]lass' },
                            ['if'] = { query = '@function.inner', desc = 'inner [f]unction' },
                            ['af'] = { query = '@function.outer', desc = 'a [f]unction' },
                            ['ik'] = { query = '@block.inner', desc = 'inner bloc[k]' },
                            ['ak'] = { query = '@block.outer', desc = 'a bloc[k]' },
                            ['il'] = { query = '@call.inner', desc = 'inner ca[l]l' },
                            ['al'] = { query = '@call.outer', desc = 'a ca[l]l' },
                            ['im'] = { query = '@comment.inner', desc = 'inner co[m]ment' },
                            ['am'] = { query = '@comment.outer', desc = 'a co[m]ment' },
                        },
                    },
                    swap = {
                        -- Enable textobj swap
                        enable = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        swap_next = {
                            ['<leader>sna'] = { query = '@parameter.inner', desc = '[a]rgument' },
                            ['<leader>snc'] = { query = '@class.outer', desc = '[c]lass' },
                            ['<leader>snf'] = { query = '@function.outer', desc = '[f]unction' },
                        },
                        swap_previous = {
                            ['<leader>spa'] = { query = '@parameter.inner', desc = '[a]rgument' },
                            ['<leader>spc'] = { query = '@class.outer', desc = '[c]lass' },
                            ['<leader>spf'] = { query = '@function.outer', desc = '[f]unction' },
                        },
                    },
                    move = {
                        -- Enable textobj move
                        enable = true,
                        -- Whether to set jumps in the jumplist
                        set_jumps = true,
                        goto_next_start = {
                            [']a'] = { query = '@parameter.inner', desc = 'Next [a]rgument' },
                            [']f'] = { query = '@function.outer', desc = 'Next [f]unction' },
                        },
                        goto_previous_start = {
                            ['[a'] = { query = '@parameter.inner', desc = 'Previous [a]rgument' },
                            ['[f'] = { query = '@function.outer', desc = 'Previous [f]unction' },
                        },
                    },
                },
            }

            local repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

            -- Repeat movement with ; and , -> Goes to the direction you were moving
            vim.keymap.set({ 'n', 'x', 'o' }, ';', repeat_move.repeat_last_move_next)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', repeat_move.repeat_last_move_previous)

            -- Make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ 'n', 'x', 'o' }, 'f', repeat_move.builtin_f)
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', repeat_move.builtin_F)
            vim.keymap.set({ 'n', 'x', 'o' }, 't', repeat_move.builtin_t)
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', repeat_move.builtin_T)
        end,
    },
    {
        'nvim-treesitter/playground', -- Treesitter playground -> awesome for debugging queries
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            vim.keymap.set(
                'n',
                '<leader>pp',
                ':TSPlaygroundToggle<cr>',
                { desc = 'Toggle playground' }
            )
            vim.keymap.set(
                'n',
                '<leader>ph',
                ':TSHighlightCapturesUnderCursor<cr>',
                { desc = 'Highlight captures under cursor' }
            )
            vim.keymap.set(
                'n',
                '<leader>pn',
                ':TSNodeUnderCursor<cr>',
                { desc = 'Highlight node under cursor' }
            )
        end,
    },
    {
        'mbbill/undotree', -- Better undo history
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undo tree' })
        end,
    },
    {
        'Tummetott/unimpaired.nvim', -- Useful paired mappings
        config = function()
            require('unimpaired').setup {
                keymaps = {
                    previous = false,
                    next = false,
                    first = false,
                    last = false,
                    bprevious = {
                        mapping = '[b',
                        description = 'Previous [b]uffer',
                        dot_repeat = true,
                    },
                    bnext = {
                        mapping = ']b',
                        description = 'Next [b]uffer',
                        dot_repeat = true,
                    },
                    bfirst = {
                        mapping = '[B',
                        description = 'First [b]uffer',
                        dot_repeat = true,
                    },
                    blast = {
                        mapping = ']B',
                        description = 'Last [b]uffer',
                        dot_repeat = true,
                    },
                    lprevious = {
                        mapping = '[l',
                        description = 'Previous [l]oclist',
                        dot_repeat = true,
                    },
                    lnext = {
                        mapping = ']l',
                        description = 'Next [l]oclist',
                        dot_repeat = true,
                    },
                    lfirst = {
                        mapping = '[L',
                        description = 'First [l]oclist',
                        dot_repeat = true,
                    },
                    llast = {
                        mapping = ']L',
                        description = 'Last [l]oclist',
                        dot_repeat = true,
                    },
                    lpfile = {
                        mapping = '[<C-l>',
                        description = 'Previous [l]oclist file',
                        dot_repeat = true,
                    },
                    lnfile = {
                        mapping = ']<C-l>',
                        description = 'Next [l]oclist file',
                        dot_repeat = true,
                    },
                    cprevious = {
                        mapping = '[q',
                        description = 'Previous [q]flist',
                        dot_repeat = true,
                    },
                    cnext = {
                        mapping = ']q',
                        description = 'Next [q]flist',
                        dot_repeat = true,
                    },
                    cfirst = {
                        mapping = '[Q',
                        description = 'First [q]flist',
                        dot_repeat = true,
                    },
                    clast = {
                        mapping = ']Q',
                        description = 'Last [q]flist',
                        dot_repeat = true,
                    },
                    cpfile = {
                        mapping = '[<C-q>',
                        description = 'Previous [q]flist file',
                        dot_repeat = true,
                    },
                    cnfile = {
                        mapping = ']<C-q>',
                        description = 'Next [q]flist file',
                        dot_repeat = true,
                    },
                    tprevious = {
                        mapping = '[t',
                        description = 'Previous matching [t]ag',
                        dot_repeat = true,
                    },
                    tnext = {
                        mapping = ']t',
                        description = 'Next matching [t]ag',
                        dot_repeat = true,
                    },
                    tfirst = {
                        mapping = '[T',
                        description = 'First matching [t]ag',
                        dot_repeat = true,
                    },
                    tlast = {
                        mapping = ']T',
                        description = 'Last matching [t]ag',
                        dot_repeat = true,
                    },
                    ptprevious = {
                        mapping = '[<C-t>',
                        description = ':[t]previous in preview',
                        dot_repeat = true,
                    },
                    ptnext = {
                        mapping = ']<C-t>',
                        description = ':[t]next in preview',
                        dot_repeat = true,
                    },
                    previous_file = {
                        mapping = '[<C-f>',
                        description = 'Previous directory [f]ile',
                        dot_repeat = true,
                    },
                    next_file = {
                        mapping = ']<C-f>',
                        description = 'Next directory [f]ile',
                        dot_repeat = true,
                    },
                    blank_above = {
                        mapping = '[<space>',
                        description = 'Add blank line(s) above',
                        dot_repeat = true,
                    },
                    blank_below = {
                        mapping = ']<space>',
                        description = 'Add blank line(s) below',
                        dot_repeat = true,
                    },
                    exchange_above = {
                        mapping = '[e',
                        description = '[e]xchange above line(s)',
                        dot_repeat = true,
                    },
                    exchange_below = {
                        mapping = ']e',
                        description = '[e]xchange below line(s)',
                        dot_repeat = true,
                    },
                    exchange_section_above = {
                        mapping = '[E',
                        description = 'Move s[e]ction up',
                        dot_repeat = true,
                    },
                    exchange_section_below = {
                        mapping = ']E',
                        description = 'Move s[e]ction down',
                        dot_repeat = true,
                    },
                    enable_cursorline = false,
                    disable_cursorline = false,
                    toggle_cursorline = {
                        mapping = '<leader>tC',
                        description = '[c]ursorline',
                        dot_repeat = true,
                    },
                    enable_diff = false,
                    disable_diff = false,
                    toggle_diff = {
                        mapping = '<leader>tD',
                        description = '[d]iffthis',
                        dot_repeat = true,
                    },
                    enable_hlsearch = false,
                    disable_hlsearch = false,
                    toggle_hlsearch = {
                        mapping = '<leader>th',
                        description = '[h]lsearch',
                        dot_repeat = true,
                    },
                    enable_ignorecase = false,
                    disable_ignorecase = false,
                    toggle_ignorecase = {
                        mapping = '<leader>ti',
                        description = '[i]gnorecase',
                        dot_repeat = true,
                    },
                    enable_list = false,
                    disable_list = false,
                    toggle_list = {
                        mapping = '<leader>tl',
                        description = '[l]istchars',
                        dot_repeat = true,
                    },
                    enable_number = false,
                    disable_number = false,
                    toggle_number = {
                        mapping = '<leader>tn',
                        description = 'line [n]umbers',
                        dot_repeat = true,
                    },
                    enable_relativenumber = false,
                    disable_relativenumber = false,
                    toggle_relativenumber = {
                        mapping = '<leader>tr',
                        description = '[r]elative numbers',
                        dot_repeat = true,
                    },
                    enable_spell = false,
                    disable_spell = false,
                    toggle_spell = {
                        mapping = '<leader>ts',
                        description = '[s]pell check',
                        dot_repeat = true,
                    },
                    enable_background = false,
                    disable_background = false,
                    toggle_background = false,
                    enable_colorcolumn = false,
                    disable_colorcolumn = false,
                    toggle_colorcolumn = {
                        mapping = '<leader>tU',
                        description = 'colorcol[u]mn',
                        dot_repeat = true,
                    },
                    enable_cursorcolumn = false,
                    disable_cursorcolumn = false,
                    toggle_cursorcolumn = {
                        mapping = '<leader>tu',
                        description = 'c[u]rsorcolumn',
                        dot_repeat = true,
                    },
                    enable_virtualedit = false,
                    disable_virtualedit = false,
                    toggle_virtualedit = {
                        mapping = '<leader>tv',
                        description = '[v]irtualedit',
                        dot_repeat = true,
                    },
                    enable_wrap = false,
                    disable_wrap = false,
                    toggle_wrap = {
                        mapping = '<leader>tw',
                        description = 'line [w]rapping',
                        dot_repeat = true,
                    },
                    enable_cursorcross = false,
                    disable_cursorcross = false,
                    toggle_cursorcross = {
                        mapping = '<leader>tx',
                        description = 'cursorcross ([x])',
                        dot_repeat = true,
                    },
                },
            }
        end,
    },
    {
        -- Improved `vim-sexp` mappings
        'tpope/vim-sexp-mappings-for-regular-people',
        dependencies = {
            'tpope/vim-surround', -- Cool surround actions for `cs`, `cS`, and `ds` mappings
            'tpope/vim-repeat', -- Repeat plugin maps
            'guns/vim-sexp', -- The Vim philosophy of precision editing for S-expressions
        },
        config = function()
            -- Extend `vim-sexp` to more filetypes
            vim.g.sexp_filetypes = 'clojure,scheme,lisp,timl,fennel,janet'
        end,
    },
    {
        -- A powerful character autopair plugin
        'windwp/nvim-autopairs',
        config = true,
    },
    {
        -- Comment shenanigans
        'numToStr/Comment.nvim',
        config = true,
    },
}
