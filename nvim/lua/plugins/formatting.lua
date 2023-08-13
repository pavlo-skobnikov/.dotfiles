return {
    'mhartington/formatter.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        require('formatter').setup {
            logging = true,
            log_level = vim.log.levels.WARN,

            filetype = {
                lua = { require('formatter.filetypes.lua').stylua },
                sh = { require('formatter.filetypes.sh').shfmt },
                zsh = { require('formatter.filetypes.sh').shfmt },
                java = {
                    function()
                        return {
                            exe = 'google-java-format',
                            args = {
                                '-a',
                                vim.api.nvim_buf_get_name(0),
                            },
                            stdin = true,
                        }
                    end,
                },
                kotlin = { require('formatter.filetypes.kotlin').ktlint },
                ['*'] = {
                    require('formatter.filetypes.any').remove_trailing_whitespace,
                },
            },
        }

        vim.keymap.set('n', '<leader>=', ':Format<CR>', { silent = true, desc = 'Format' })
        vim.keymap.set(
            'n',
            '<leader>+',
            ':FormatWrite<CR>',
            { silent = true, desc = 'Format & Write' }
        )
    end,
}
