return {
    {
        'tpope/vim-fugitive', -- Git wrapper
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'folke/which-key.nvim',
        },
        config = function()
            local tb = require 'telescope.builtin'

            RegisterWK({
                name = 'git',
                b = { tb.git_branches, '[B]ranches' },
                c = { tb.git_commits, 'All [c]ommits' },
                d = { ':Gvdiff<CR>', '[D]iff' },
                f = { ':Git fetch<SPACE>', '[F]etch' },
                g = { ':Git<CR>', 'Fu[g]itive' },
                h = { ':0Gclog<CR>', 'File [h]istory' },
                l = { ':Git log<CR>', 'Changes [l]og' },
                o = { ':Git checkout<SPACE>', 'Check[o]ut' },
                p = { ':Git push<SPACE>', '[P]ush' },
                u = { ':Git pull<SPACE>', 'P[u]ll' },
                i = { tb.git_status, 'Commit [i]nfo (status)' },
                s = { tb.git_stash, '[S]tash' },
                ['?'] = { ':Git help<CR>', 'Help ([?])' },
            }, { prefix = '<LEADER>g' })

            RegisterWK({
                b = { ':Git blame<CR>', 'git [b]lame' },
            }, { prefix = '<LEADER>t' })
        end,
    },
    {
        'lewis6991/gitsigns.nvim', -- Git gutter && hunks
        dependencies = {
            'nvim-lua/plenary.nvim',
            'folke/which-key.nvim',
        },
        config = function()
            require('gitsigns').setup {
                on_attach = function()
                    local gs = package.loaded.gitsigns

                    -- Navigation between hunks
                    local function getHunkMoveFunc(mapping, action)
                        return function()
                            if vim.wo.diff then
                                return mapping
                            end

                            vim.schedule(action)
                            return '<Ignore>'
                        end
                    end

                    RegisterWK {
                        [']h'] = { getHunkMoveFunc(']h', gs.next_hunk), 'Next [h]unk' },
                        ['[h'] = { getHunkMoveFunc('[h', gs.prev_hunk), 'Previous [h]unk' },
                    }

                    -- Hunk actions
                    RegisterWK({
                        name = 'hunks',
                        s = { gs.stage_hunk, '[S]tage hunk' },
                        u = { gs.undo_stage_hunk, '[U]ndo stage hunk' },
                        h = { gs.reset_hunk, 'Reset [h]unk' },
                        b = { gs.reset_buffer, 'Reset [b]uffer' },
                        p = { gs.preview_hunk, '[P]review hunk' },
                        i = {
                            function()
                                gs.blame_line { full = true }
                            end,
                            'Git [i]nfo for current line',
                        },
                        d = { gs.diffthis, '[D]iff' },
                        r = {
                            function()
                                gs.diffthis(vim.fn.input 'Ref > ')
                            end,
                            'Diff against [r]ef',
                        },
                    }, { prefix = '<LEADER>h' })

                    -- Toggle removed hunks
                    RegisterWK({
                        d = { gs.toggle_deleted, '[D]eleted hunks' },
                    }, { prefix = '<LEADER>t' })

                    -- Hunk as a text object
                    RegisterWK({
                        h = { ':<C-U>Gitsigns select_hunk<CR>', 'Select [h]unk' },
                    }, {
                        prefix = 'i',
                        mode = { 'o', 'x' },
                    })
                end,
            }
        end,
    },
}
