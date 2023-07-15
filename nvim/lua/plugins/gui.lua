-- Description: Configuration for the NeoVim editor GUI (if you can call it that)
return {
    {
        -- Colorscheme
        'catppuccin/nvim',
        name = 'catppuccin',
        config = function()
            require('catppuccin').setup {
                flavour = 'frappe', -- Options: latte, frappe, macchiato, mocha
            }

            vim.cmd [[ colorscheme catppuccin ]]
        end,
    },
    {
        -- Status Line
        'nvim-lualine/lualine.nvim',
        config = function()
            local lualine = require 'lualine'

            lualine.setup {
                options = {
                    theme = 'dracula',
                },

                inactive_sections = {
                    -- Show inactive windows' number for easy switching
                    lualine_a = {
                        {
                            function()
                                return vim.api.nvim_win_get_number(0)
                            end,
                        },
                    },
                    lualine_b = { 'filename' },
                    lualine_c = {},
                },
            }
        end,
    },
    {
        'https://github.com/nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {
                sort_by = 'case_sensitive',
                view = {
                    width = 50,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            }

            vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFocus<CR>', {
                noremap = true,
                silent = true,
                desc = 'Open explorer',
            })

            vim.api.nvim_set_keymap('n', '<leader>E', ':NvimTreeFindFile<CR>', {
                noremap = true,
                silent = true,
                desc = 'Open explorer with current buffer path',
            })
        end,
    },
}
