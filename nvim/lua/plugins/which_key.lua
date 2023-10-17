return {
    'folke/which-key.nvim', -- The popup menu plugin
    config = function()
        local wk = require 'which-key'

        -- Used only for setting groups
        wk.register({
            c = {
                name = 'code',
                s = 'search',
                d = 'diagnostics',
            },
            d = {
                name = 'dap',
                b = 'breakpoints',
                f = 'find',
                s = 'step',
                t = 'test',
                w = 'widget',
            },
            f = { name = 'find' },
            g = { name = 'git' },
            h = { name = 'hunks' },
            t = { name = 'toggle' },
            p = { name = 'ts-playground' },
            s = {
                name = 'swap',
                n = 'next',
                p = 'previous',
            }
        }, { prefix = '<leader>' })

        wk.register({
            e = {
                name = 'evaluate',
                c = 'comment',
            },
            g = 'get',
            l = 'log',
            r = 'run',
        }, { prefix = '<localleader>' })
    end,
}
