-- Description: Telescope configuration
return {
    {
        -- An incredibly extendable fuzzy finder over lists
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-tree/nvim-web-devicons' },
        },
        cmd = { 'Telescope', 'Tel' }, -- Lazy loads on these commands
        keys = { '<leader>f' },       -- Lazy loads on this pattern
        config = function()
            local telescope = require 'telescope'

            telescope.setup {
                defaults = {
                    -- Default Telescope configurations to be applied for all searches
                    dynamic_preview_title = true,
                    path_display = {
                        'tail',
                    },
                    layout_strategy = 'vertical',
                    layout_config = {
                        vertical = {
                            mirror = false,
                        },
                    },
                    pickers = {
                        lsp_incoming_calls = {
                            path_display = 'tail',
                        },
                    },
                },
            }

            -- For access to Telescope function and further key map assignments
            local builtin = require 'telescope.builtin'

            -- Telescope main commands
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume Previous Find' })
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files { find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } }
            end, { desc = 'Find Files' })
            vim.keymap.set(
                'n',
                '<leader>fF',
                builtin.oldfiles,
                { desc = 'Find Previously Open Files' }
            )
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find Text in Files' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Recent Buffer' })
            vim.keymap.set(
                'n',
                '<leader>fh',
                builtin.help_tags,
                { desc = 'Find Documentation Help' }
            )
            vim.keymap.set(
                'n',
                '<leader>fk',
                builtin.keymaps,
                { desc = 'Find Normal Mode Keymaps' }
            )
            vim.keymap.set(
                'n',
                '<leader>fS',
                builtin.spell_suggest,
                { desc = 'Find Spelling Suggestion and Replace' }
            )
            vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find Command and Run' })
            vim.keymap.set(
                'n',
                '<leader>fC',
                builtin.command_history,
                { desc = 'Find Previous Command' }
            )
            vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Find in QuickFix List' })
            vim.keymap.set(
                'n',
                '<leader>fQ',
                builtin.quickfixhistory,
                { desc = 'Find from QuickFix History' }
            )
            vim.keymap.set('n', '<leader>fl', builtin.loclist, { desc = 'Find in Local List' })
            vim.keymap.set('n', '<leader>f"', builtin.registers, { desc = 'Find in Registers' })

            -- Git-related Telescope commands
            vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git Status' })
            vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Git Stash' })
            vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = ' Git Commits' })
            vim.keymap.set(
                'n',
                '<leader>gC',
                builtin.git_bcommits,
                { desc = 'Current File Commits' }
            )

            vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Switch Branch' })
        end,
    },
    {
        -- UI picker extension for Telescope
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local telescope = require 'telescope'

            telescope.load_extension 'ui-select'
        end,
    },
    {
        -- Blazingly-fast C port of FZF for Telescope
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        config = function()
            require('telescope').load_extension 'fzf'
        end,
    },
}
