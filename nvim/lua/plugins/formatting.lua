return {
    'mhartington/formatter.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        -- Utilities for creating configurations
        local util = require 'formatter.util'

        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require('formatter').setup {
            logging = true,
            log_level = vim.log.levels.WARN,

            filetype = {
                lua = { require('formatter.filetypes.lua').stylua },
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
