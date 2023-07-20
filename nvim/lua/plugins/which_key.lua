-- Plugin for dynamically showing key mappings
return {
    {
        -- The popup menu plugin
        'folke/which-key.nvim',
        keys = { '<leader>', '<localleader>' },
        config = function()
            -- Set a delay for the popup to...well...pop up
            vim.o.timeout = true
            vim.o.timeoutlen = 200

            local which_key = require 'which-key'

            -- Used only for setting groups
            which_key.register({
                c = {
                    name = 'code',
                    s = { name = 'search' },
                },
                d = {
                    name = 'dap',
                    b = { name = 'breakpoints' },
                    f = { name = 'find' },
                    s = { name = 'step' },
                    w = { name = 'widget' },
                },
                f = { name = 'find' },
                t = { name = 'toggle' },
                h = { name = 'hunks' },
                g = { name = 'git' },
            }, { prefix = '<leader>' })
        end,
    },
}
