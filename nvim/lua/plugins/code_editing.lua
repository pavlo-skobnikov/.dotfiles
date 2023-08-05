return {
    'tpope/vim-unimpaired', -- Useful paired mappings
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
