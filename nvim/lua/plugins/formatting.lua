local function shfmt()
    return require('formatter.filetypes.sh').shfmt
end

local function prettier()
    require 'formatter.defaults.prettier'
end

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
                c = { require('formatter.filetypes.c').clangformat },
                zig = { require('formatter.filetypes.zig').zigfmt },
                rust = { require('formatter.filetypes.rust').rustfmt },
                lua = { require('formatter.filetypes.lua').stylua },
                python = { require('formatter.filetypes.python').black },
                go = { require('formatter.filetypes.go').goimports },
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
                javascript = { prettier() },
                typescript = { prettier() },
                sh = { shfmt() },
                bash = { shfmt() },
                zsh = { shfmt() },
                markdown = { prettier() },
                sql = { prettier() },
                yaml = { prettier() },
                json = { prettier() },
                ['*'] = {
                    require('formatter.filetypes.any').remove_trailing_whitespace,
                },
            },
        }

        local function map(key, cmd, desc)
            vim.keymap.set('n', '<LEADER>' .. key, cmd, { desc = desc })
        end

        map('=', ':Format<CR>', 'Format')
        map('+', ':FormatWrite<CR>', 'Format && Write')
    end,
}
