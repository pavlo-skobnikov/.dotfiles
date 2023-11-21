local function getTsCfgs()
    return require 'nvim-treesitter.configs'
end

return {
    {
        'nvim-treesitter/nvim-treesitter', -- Syntax highlighting
        build = ':TSUpdate',
        config = function()
            getTsCfgs().setup {
                ensure_installed = {
                    'c', -- Required for Treesitter to function parsers
                    'lua',
                    'vim',
                    'vimdoc',
                    'query',
                    'diff', -- Additional parsers
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
        'nvim-treesitter/nvim-treesitter-textobjects', -- Additional Vim textobjects
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'folke/which-key.nvim',
        },
        config = function()
            local function mkOpts(query, desc)
                return { query = query, desc = desc }
            end

            getTsCfgs().setup {
                textobjects = {
                    select = {
                        -- Enable textobj selection
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        keymaps = {
                            ['oia'] = mkOpts('@parameter.inner', '[A]rgument'),
                            ['oaa'] = mkOpts('@parameter.outer', '[A]rgument'),
                            ['oic'] = mkOpts('@class.inner', '[C]lass'),
                            ['oac'] = mkOpts('@class.outer', '[C]lass'),
                            ['oif'] = mkOpts('@function.inner', '[F]unction'),
                            ['oaf'] = mkOpts('@function.outer', '[F]unction'),
                            ['oib'] = mkOpts('@block.inner', '[B]lock'),
                            ['oab'] = mkOpts('@block.outer', '[B]lock'),
                            ['oil'] = mkOpts('@call.inner', 'Ca[l]l'),
                            ['oal'] = mkOpts('@call.outer', 'Ca[l]l'),
                            ['oim'] = mkOpts('@comment.inner', 'Co[m]ment'),
                            ['oam'] = mkOpts('@comment.outer', 'Co[m]ment'),
                        },
                    },
                    swap = {
                        -- Enable textobj swap
                        enable = true,
                        -- Capture groups defined in textobjects.scm are available for bindings
                        swap_next = {
                            ['<leader>sna'] = mkOpts('@parameter.inner', '[A]rgument'),
                            ['<leader>snc'] = mkOpts('@class.outer', '[C]lass'),
                            ['<leader>snf'] = mkOpts('@function.outer', '[F]unction'),
                        },
                        swap_previous = {
                            ['<leader>spa'] = mkOpts('@parameter.inner', '[A]rgument'),
                            ['<leader>spc'] = mkOpts('@class.outer', '[C]lass'),
                            ['<leader>spf'] = mkOpts('@function.outer', '[F]unction'),
                        },
                    },
                    move = {
                        -- Enable textobj move
                        enable = true,
                        -- Whether to set jumps in the jumplist
                        set_jumps = true,
                        goto_next_start = {
                            [']ca'] = mkOpts('@parameter.inner', '[A]rgument'),
                            [']cc'] = mkOpts('@class.outer', '[C]lass'),
                            [']cf'] = mkOpts('@function.outer', '[F]unction'),
                        },
                        goto_previous_start = {
                            ['[ca'] = mkOpts('@parameter.inner', '[A]rgument'),
                            ['[cc'] = mkOpts('@class.outer', '[C]lass'),
                            ['[cf'] = mkOpts('@function.outer', '[F]unction'),
                        },
                    },
                },
            }

            RegisterWK({
                o = {
                    name = 'objects',
                    i = { name = 'inside' },
                    a = { name = 'around' },
                },
                ['['] = {
                    name = 'backwards',
                    c = { name = 'context' },
                },
                [']'] = {
                    name = 'forwards',
                    c = { name = 'context' },
                },
            }, { mode = { 'o', 'x' } })
            RegisterWK({
                s = {
                    name = 'swap',
                    n = 'next',
                    p = 'previous',
                },
            }, { prefix = '<LEADER>' })

            local movePrefixes = { '[', ']' }
            for _, prefix in ipairs(movePrefixes) do
                RegisterWK({
                    c = 'context',
                }, { prefix = prefix })
            end

            local repeatMove = require 'nvim-treesitter.textobjects.repeatable_move'
            RegisterWK({
                [';'] = { repeatMove.repeat_last_move_next, 'Repeat last move forwards' },
                [','] = { repeatMove.repeat_last_move_previous, 'Repeat last move backwards' },
                ['f'] = { repeatMove.builtin_f, 'Search char forwards' },
                ['F'] = { repeatMove.builtin_F, 'Search char backwards' },
                ['t'] = { repeatMove.builtin_t, 'Search until char forwards' },
                ['T'] = { repeatMove.builtin_T, 'Search until char backwards' },
            }, { mode = { 'n', 'x', 'o' } })
        end,
    },
    {
        'nvim-treesitter/playground', -- Treesitter playground
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'folke/which-key.nvim',
        },
        config = function()
            RegisterWK({
                p = {
                    name = 'ts-playground',
                    p = { ':TSPlaygroundToggle<CR>', 'Toggle playground' },
                    h = { ':TSHighlightCapturesUnderCursor<CR>', 'Highlight captures under cursor' },
                    n = { ':TSNodeUnderCursor<CR>', 'Highlight node under cursor' },
                },
            }, { prefix = '<LEADER>' })
        end,
    },
}
