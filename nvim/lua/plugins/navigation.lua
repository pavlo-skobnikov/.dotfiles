local function req_telescope()
    return require 'telescope'
end

local function load_extension_for_telescope(extension)
    return req_telescope().load_extension(extension)
end

return {
    {
        'stevearc/oil.nvim', -- Vim buffer-like editing for the file system
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('oil').setup {
                view_options = {
                    show_hidden = true,
                },
            }

            vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
        end,
    },
    {
        'nvim-telescope/telescope.nvim', -- An incredibly extendable fuzzy finder over lists
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            req_telescope().setup {
                defaults = {
                    -- Default Telescope configurations to be applied for all searches
                    dynamic_preview_title = true,
                    path_display = { 'tail' },
                    layout_strategy = 'vertical',
                    layout_config = { vertical = { mirror = false } },
                    pickers = { lsp_incoming_calls = { path_display = 'tail' } },
                },
            }

            -- Telescope main commands
            local bi = require 'telescope.builtin'

            vim.keymap.set('n', '<leader>fr', bi.resume, { desc = 'from p[r]evious search' })
            vim.keymap.set('n', '<leader>ff', function()
                bi.find_files { find_command = { 'rg', '--files', '--hidden', '-g', '!.git' } }
            end, { desc = '[f]iles' })
            vim.keymap.set('n', '<leader>fF', bi.oldfiles, { desc = 'previously opened [f]iles' })
            vim.keymap.set('n', '<leader>fg', bi.live_grep, { desc = 'text ([g]rep)' })
            vim.keymap.set('n', '<leader>fb', bi.buffers, { desc = '[b]uffer' })
            vim.keymap.set('n', '<leader>fh', bi.help_tags, { desc = 'doc [h]elp' })
            vim.keymap.set('n', '<leader>fk', bi.keymaps, { desc = '[k]eymaps' })
            vim.keymap.set('n', '<leader>fs', bi.search_history, { desc = 'in [s]earch history' })
            vim.keymap.set(
                'n',
                '<leader>fS',
                bi.spell_suggest,
                { desc = '[s]pelling suggestion && replace' }
            )
            vim.keymap.set('n', '<leader>fc', bi.commands, { desc = '[c]ommand && run' })
            vim.keymap.set('n', '<leader>fC', bi.command_history, { desc = 'in [c]ommand history' })
            vim.keymap.set('n', '<leader>fq', bi.quickfix, { desc = 'in [q]flist' })
            vim.keymap.set('n', '<leader>fl', bi.loclist, { desc = 'in [l]oclist' })
            vim.keymap.set('n', '<leader>ft', bi.tags, { desc = '[t]ags' })
            vim.keymap.set('n', '<leader>fm', bi.marks, { desc = '[m]arks' })
            vim.keymap.set('n', '<leader>f"', bi.registers, { desc = 'in registers (["])' })
        end,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim', -- UI picker extension for Telescope
        dependencies = 'nvim-telescope/telescope.nvim',
        config = function()
            load_extension_for_telescope 'ui-select'
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', -- Blazingly-fast C port of FZF for Telescope
        dependencies = 'nvim-telescope/telescope.nvim',
        build = 'make',
        config = function()
            load_extension_for_telescope 'fzf'
        end,
    },
}
