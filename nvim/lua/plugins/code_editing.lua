return {
    {
        'Tummetott/unimpaired.nvim', -- Useful paired mappings
        config = function()
            local keymaps = {
                previous = {
                    mapping = '[a',
                    description = 'arglist - Prev',
                    dot_repeat = true,
                },
                next = {
                    mapping = ']a',
                    description = 'arglist - Next',
                    dot_repeat = true,
                },
                first = {
                    mapping = '[A',
                    description = 'arglist - First',
                    dot_repeat = false,
                },
                last = {
                    mapping = ']A',
                    description = 'arglist - Last',
                    dot_repeat = false,
                },
                bprevious = {
                    mapping = '[b',
                    description = 'buffer - Prev',
                    dot_repeat = true,
                },
                bnext = {
                    mapping = ']b',
                    description = 'buffer - Next',
                    dot_repeat = true,
                },
                bfirst = {
                    mapping = '[B',
                    description = 'buffer - First',
                    dot_repeat = false,
                },
                blast = {
                    mapping = ']B',
                    description = 'buffer - Last',
                    dot_repeat = false,
                },
                lprevious = {
                    mapping = '[l',
                    description = 'loclist - Prev',
                    dot_repeat = true,
                },
                lnext = {
                    mapping = ']l',
                    description = 'loclist - Next',
                    dot_repeat = true,
                },
                lfirst = {
                    mapping = '[L',
                    description = 'loclist - First',
                    dot_repeat = false,
                },
                llast = {
                    mapping = ']L',
                    description = 'loclist - Last',
                    dot_repeat = false,
                },
                lpfile = {
                    mapping = '[<C-l>',
                    description = 'loclist - Prev File',
                    dot_repeat = true,
                },
                lnfile = {
                    mapping = ']<C-l>',
                    description = 'loclist - Next File',
                    dot_repeat = true,
                },
                cprevious = {
                    mapping = '[q',
                    description = 'qflist - Prev',
                    dot_repeat = true,
                },
                cnext = {
                    mapping = ']q',
                    description = 'qflist - Next',
                    dot_repeat = true,
                },
                cfirst = {
                    mapping = '[Q',
                    description = 'qflist - First',
                    dot_repeat = false,
                },
                clast = {
                    mapping = ']Q',
                    description = 'qflist - Last',
                    dot_repeat = false,
                },
                cpfile = {
                    mapping = '[<C-q>',
                    description = 'qflist - Prev File',
                    dot_repeat = true,
                },
                cnfile = {
                    mapping = ']<C-q>',
                    description = 'qflist - Next File',
                    dot_repeat = true,
                },
                tprevious = {
                    mapping = '[t',
                    description = 'Prev Matching Tag',
                    dot_repeat = true,
                },
                tnext = {
                    mapping = ']t',
                    description = 'Next Matching Tag',
                    dot_repeat = true,
                },
                tfirst = {
                    mapping = '[T',
                    description = 'First Matching Tag',
                    dot_repeat = false,
                },
                tlast = {
                    mapping = ']T',
                    description = 'Last Matching Tag',
                    dot_repeat = false,
                },
                ptprevious = {
                    mapping = '[<C-t>',
                    description = ':tprevious in the Preview Window',
                    dot_repeat = true,
                },
                ptnext = {
                    mapping = ']<C-t>',
                    description = ':tnext in the Preview Window',
                    dot_repeat = true,
                },
                previous_file = {
                    mapping = '[f',
                    description = 'Previous File in Directory',
                    dot_repeat = true,
                },
                next_file = {
                    mapping = ']f',
                    description = 'Next File in Directory',
                    dot_repeat = true,
                },
                blank_above = {
                    mapping = '[<Space>',
                    description = 'Add Blank Line(s) Above',
                    dot_repeat = true,
                },
                blank_below = {
                    mapping = ']<Space>',
                    description = 'Add Blank Line(s) Below',
                    dot_repeat = true,
                },
                exchange_above = {
                    mapping = '[e',
                    description = 'Exchange Line(s) with Above',
                    dot_repeat = true,
                },
                exchange_below = {
                    mapping = ']e',
                    description = 'Exchange Line(s) with Below',
                    dot_repeat = true,
                },
                exchange_section_above = {
                    mapping = '[E',
                    description = 'Move Section Up',
                    dot_repeat = true,
                },
                exchange_section_below = {
                    mapping = ']E',
                    description = 'Move Section Down',
                    dot_repeat = true,
                },
                enable_cursorline = false,
                disable_cursorline = false,
                toggle_cursorline = {
                    mapping = '<leader>tC',
                    description = 'Toggle cursorline',
                    dot_repeat = true,
                },
                enable_diff = false,
                disable_diff = false,
                toggle_diff = {
                    mapping = '<leader>tD',
                    description = 'Toggle diffthis',
                    dot_repeat = true,
                },
                enable_hlsearch = false,
                disable_hlsearch = false,
                toggle_hlsearch = {
                    mapping = '<leader>th',
                    description = 'Toggle hlsearch',
                    dot_repeat = true,
                },
                enable_ignorecase = false,
                disable_ignorecase = false,
                toggle_ignorecase = {
                    mapping = '<leader>ti',
                    description = 'Toggle ignorecase',
                    dot_repeat = true,
                },
                enable_list = false,
                disable_list = false,
                toggle_list = {
                    mapping = '<leader>tl',
                    description = 'Toggle listchars',
                    dot_repeat = true,
                },
                enable_number = false,
                disable_number = false,
                toggle_number = {
                    mapping = '<leader>tn',
                    description = 'Toggle Line Numbers',
                    dot_repeat = true,
                },
                enable_relativenumber = false,
                disable_relativenumber = false,
                toggle_relativenumber = {
                    mapping = '<leader>tr',
                    description = 'Toggle Relative Numbers',
                    dot_repeat = true,
                },
                enable_spell = false,
                disable_spell = false,
                toggle_spell = {
                    mapping = '<leader>ts',
                    description = 'Toggle Spell Check',
                    dot_repeat = true,
                },
                enable_background = false,
                disable_background = false,
                toggle_background = false,
                enable_colorcolumn = false,
                disable_colorcolumn = false,
                toggle_colorcolumn = {
                    mapping = '<leader>tU',
                    description = 'Toggle colorcolumn',
                    dot_repeat = true,
                },
                enable_cursorcolumn = false,
                disable_cursorcolumn = false,
                toggle_cursorcolumn = {
                    mapping = '<leader>tu',
                    description = 'Toggle cursorcolumn',
                    dot_repeat = true,
                },
                enable_virtualedit = false,
                disable_virtualedit = false,
                toggle_virtualedit = {
                    mapping = '<leader>tv',
                    description = 'Toggle virtualedit',
                    dot_repeat = true,
                },
                enable_wrap = false,
                disable_wrap = false,
                toggle_wrap = {
                    mapping = '<leader>tw',
                    description = 'Toggle Line Wrapping',
                    dot_repeat = true,
                },
                enable_cursorcross = false,
                disable_cursorcross = false,
                toggle_cursorcross = {
                    mapping = '<leader>tx',
                    description = 'Toggle cursorcross',
                    dot_repeat = true,
                },
            }

            require('unimpaired').setup {
                keymaps = keymaps,
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
    {
        -- Movements, selections, and swapping with Treesitter objects
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                textobjects = {
                    select = {
                        -- Enable textobj selection
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        keymaps = {
                            ['if'] = { query = '@function.inner', desc = 'Inside Function' },
                            ['af'] = { query = '@function.outer', desc = 'Around Function' },
                            ['ia'] = { query = '@parameter.inner', desc = 'Inside Argument' },
                            ['aa'] = { query = '@parameter.outer', desc = 'Around Argument' },
                        },
                    },
                    swap = {
                        -- Enable textobj swap
                        enable = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        swap_next = {
                            ['s'] = { query = '@swappable', desc = 'Swap with Next' },
                        },
                        swap_previous = {
                            ['S'] = { query = '@swappable', desc = 'Swap with Prev' },
                        },
                    },
                    move = {
                        -- Enable textobj move
                        enable = true,
                        -- Whether to set jumps in the jumplist
                        set_jumps = true,
                        goto_next_start = {
                            [']f'] = { query = '@function.outer', desc = 'Next Function Start' },
                            [']a'] = { query = '@parameter.inner', desc = 'Next Argument' },
                        },
                        goto_previous_start = {
                            ['[f'] = { query = '@function.outer', desc = 'Prev Function Start' },
                            ['[a'] = { query = '@parameter.inner', desc = 'Prev Argument' },
                        },
                    },
                },
            }

            local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

            -- Repeat movement with ; and , vim way -> goes to the direction you were moving
            vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
            vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

            -- Make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
            vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
            vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
            vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
        end,
    },
    {
        'ThePrimeagen/harpoon', -- Easy buffer and terminal management
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('telescope').load_extension 'harpoon'

            local mark = require 'harpoon.mark'
            local ui = require 'harpoon.ui'
            local term = require 'harpoon.term'

            vim.keymap.set(
                { 'n' },
                '<leader>a',
                mark.add_file,
                { silent = true, desc = 'Add to Harpoon Marks' }
            )
            vim.keymap.set(
                { 'n' },
                '<C-h>',
                ui.toggle_quick_menu,
                { silent = true, desc = 'View Harpoon Marks' }
            )

            for i = 1, 9, 1 do
                vim.keymap.set({ 'n' }, 'g' .. i, function()
                    ui.nav_file(i)
                end, { silent = true, desc = 'Go to Harpoon Mark ' .. i })
            end

            for i = 1, 9, 1 do
                vim.keymap.set({ 'n' }, '<Localleader>' .. i, function()
                    term.gotoTerminal(i)
                end, { silent = true, desc = 'Go to Terminal ' .. i })
            end

            vim.keymap.set(
                { 'n' },
                ']h',
                ui.nav_next,
                { silent = true, desc = 'Next Harpoon Mark' }
            )
            vim.keymap.set(
                { 'n' },
                '[h',
                ui.nav_prev,
                { silent = true, desc = 'Prev Harpoon Mark' }
            )
        end,
    },
    {
        'mbbill/undotree', -- Better undo history
        config = function()
            vim.keymap.set(
                'n',
                '<leader>u',
                vim.cmd.UndotreeToggle,
                { silent = true, desc = 'Undo Tree' }
            )
        end,
    },
}
