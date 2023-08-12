return {
    'folke/which-key.nvim', -- The popup menu plugin
    config = function()
        local which_key = require 'which-key'

        -- Used only for setting groups
        which_key.register({
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
            f = 'find',
            g = 'git',
            h = 'hunks',
            t = 'toggle',
        }, { prefix = '<leader>' })

        which_key.register({
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
