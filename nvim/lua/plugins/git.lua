return {
    {
        'tpope/vim-fugitive', -- Powerful Git wrapper for many-many simple and coml
        dependencies = 'nvim-telescope/telescope.nvim',
        config = function()
            local tb = require 'telescope.builtin'

            vim.keymap.set('n', '<leader>gb', tb.git_branches, { desc = '[b]ranches' })
            vim.keymap.set('n', '<leader>gB', ':Git blame<CR>', { desc = '[b]lame' })
            vim.keymap.set('n', '<leader>gc', tb.git_commits, { desc = '[c]ommits' })
            vim.keymap.set('n', '<leader>gC', tb.git_bcommits, { desc = '[c]urrent' })
            vim.keymap.set('n', '<leader>gd', ':Gvdiff<CR>', { desc = '[d]iff' })
            vim.keymap.set('n', '<leader>gf', ':Git fetch<SPACE>', { desc = '[f]etch' })
            vim.keymap.set('n', '<leader>gg', ':Git<CR>', { desc = 'fu[g]itive' })
            vim.keymap.set('n', '<leader>gh', ':0Gclog<CR>', { desc = 'file [h]istory' })
            vim.keymap.set('n', '<leader>gl', ':Git log<CR>', { desc = '[l]og' })
            vim.keymap.set('n', '<leader>go', ':Git checkout<SPACE>', { desc = '[c]heckout' })
            vim.keymap.set('n', '<leader>gp', ':Git push<SPACE>', { desc = '[p]ush' })
            vim.keymap.set('n', '<leader>gu', ':Git pull<SPACE>', { desc = 'p[u]ll' })
            vim.keymap.set('n', '<leader>gs', tb.git_status, { desc = '[s]tatus' })
            vim.keymap.set('n', '<leader>gS', tb.git_stash, { desc = '[s]tash' })
            vim.keymap.set('n', '<leader>g?', ':Git help<CR>', { desc = 'help ([?])' })

            vim.keymap.set('n', '<leader>tb', ':Git blame<CR>', { desc = 'git [b]lame' })
        end,
    },
    {
        'lewis6991/gitsigns.nvim', -- Git gutters and hunk navigation
        config = function()
            require('gitsigns').setup {
                on_attach = function()
                    local gs = package.loaded.gitsigns

                    -- Navigation between changes
                    vim.keymap.set('n', ']h', function()
                        if vim.wo.diff then
                            return ']h'
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Next [h]unk' })
                    vim.keymap.set('n', '[h', function()
                        if vim.wo.diff then
                            return '[h'
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Previous [h]unk' })

                    -- Actions
                    vim.keymap.set(
                        { 'n', 'v' },
                        '<leader>hs',
                        gs.stage_hunk,
                        { desc = '[S]tage hunk' }
                    )
                    vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { desc = '[S]tage buffer' })
                    vim.keymap.set(
                        'n',
                        '<leader>hu',
                        gs.undo_stage_hunk,
                        { desc = '[U]ndo stage Hunk' }
                    )
                    vim.keymap.set(
                        { 'n', 'v' },
                        '<leader>hr',
                        gs.reset_hunk,
                        { desc = '[R]eset hunk' }
                    )
                    vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { desc = '[R]eset buffer' })
                    vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc = '[P]review hunk' })
                    vim.keymap.set('n', '<leader>hb', function()
                        gs.blame_line { full = true }
                    end, { desc = '[B]lame line' })
                    vim.keymap.set('n', '<leader>hd', gs.diffthis, { desc = '[D]iff' })
                    vim.keymap.set('n', '<leader>hD', function()
                        gs.diffthis(vim.fn.input 'Ref > ')
                    end, { desc = '[D]iff against ref' })

                    -- Toggles
                    vim.keymap.set(
                        'n',
                        '<leader>tL',
                        gs.toggle_current_line_blame,
                        { desc = 'current [l]ine blame' }
                    )
                    vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { desc = '[d]eleted' })

                    -- Text object
                    vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            }
        end,
    },
}
