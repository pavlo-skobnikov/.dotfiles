return {
    'tpope/vim-vinegar', -- Enhancements to netrw, the built-in file explorer
    {
        -- Easy buffer and terminal management
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        keys = {
            '<leader>a',
            '<localleader>',
            '<C-h>',
            'g',
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
}
