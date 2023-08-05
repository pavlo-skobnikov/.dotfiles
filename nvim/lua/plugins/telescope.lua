local telescope_lazy_cmds = {
    'Telescope',
    'Tel',
}

local telescope_lazy_keys = {
    '<leader>f',
    '<leader>df',
}

return {
    {
        'nvim-telescope/telescope.nvim', -- An incredibly extendable fuzzy finder over lists
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        cmd = telescope_lazy_cmds,
        keys = telescope_lazy_keys,
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
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim', -- UI picker extension for Telescope
        dependencies = 'nvim-telescope/telescope.nvim',
        cmd = telescope_lazy_cmds,
        keys = telescope_lazy_keys,
        config = function()
            local telescope = require 'telescope'

            telescope.load_extension 'ui-select'
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', -- Blazingly-fast C port of FZF for Telescope
        build = 'make',
        cmd = telescope_lazy_cmds,
        keys = telescope_lazy_keys,
        config = function()
            require('telescope').load_extension 'fzf'
        end,
    },
}
