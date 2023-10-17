return {
    {
        'mfussenegger/nvim-dap', -- Debug Adapter Protocol client
        dependencies = {
            'rcarriga/nvim-dap-ui', -- UI for DAP
            'theHamsta/nvim-dap-virtual-text', -- Virtual Text for DAP
            'nvim-telescope/telescope-dap.nvim', -- UI picker extension for DAP
            'nvim-telescope/telescope.nvim', -- Required for `telescope-dap.nvim`
            'mfussenegger/nvim-dap-python', -- Debug Adapter for Python
            'leoluz/nvim-dap-go', -- Debug Adapter for Go
        },
        config = function()
            -- Redefine DAP signs
            vim.fn.sign_define(
                'DapBreakpoint',
                { text = '🛑', texthl = '', linehl = '', numhl = '' }
            )
            vim.fn.sign_define(
                'DapBreakpointCondition',
                { text = '🟥', texthl = '', linehl = '', numhl = '' }
            )
            vim.fn.sign_define(
                'DapLogPoint',
                { text = '📍', texthl = '', linehl = '', numhl = '' }
            )
            vim.fn.sign_define(
                'DapStopped',
                { text = '➡️', texthl = '', linehl = '', numhl = '' }
            )
            vim.fn.sign_define(
                'DapBreakpointRejected',
                { text = '❌', texthl = '', linehl = '', numhl = '' }
            )

            -- Modules with mapped functionality
            local dap = require 'dap'
            local dap_ui = require 'dapui'
            local widgets = require 'dap.ui.widgets'
            local dap_virt = require 'nvim-dap-virtual-text'
            local tele = require 'telescope'

            -- Mappings for DAP
            -- dap-ui mappings
            vim.keymap.set('n', '<leader>dd', dap_ui.toggle, { desc = '[D]AP UI' })

            -- nvim-dap mappings
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[C]ontinue' })
            vim.keymap.set('n', '<leader>dsn', dap.step_over, { desc = '[n]ext' })
            vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = '[i]nto' })
            vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = '[o]ut' })

            vim.keymap.set(
                'n',
                '<leader>dbt',
                dap.toggle_breakpoint,
                { desc = '[t]oggle' }
            )
            vim.keymap.set('n', '<leader>dbc', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = '[c]onditional' })
            vim.keymap.set('n', '<leader>dbl', function()
                dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
            end, { desc = '[l]og' })

            vim.keymap.set('n', '<leader>do', dap.repl.open, { desc = '[O]pen REPL' })
            vim.keymap.set('n', '<leader>dr', dap.run_last, { desc = '[R]un last' })

            vim.keymap.set({ 'n', 'v' }, '<leader>dwh', widgets.hover, { desc = '[h]over' })
            vim.keymap.set({ 'n', 'v' }, '<leader>dwp', widgets.preview, { desc = '[p]review' })
            vim.keymap.set({ 'n', 'v' }, '<leader>dwf', function()
                widgets.centered_float(widgets.frames)
            end, { desc = '[f]rames' })
            vim.keymap.set({ 'n', 'v' }, '<leader>dws', function()
                widgets.centered_float(widgets.scopes)
            end, { desc = '[s]copes' })

            -- telescope-dap mappings
            vim.keymap.set(
                'n',
                '<leader>dfc',
                tele.extensions.dap.commands,
                { desc = '[c]ommands' }
            )
            vim.keymap.set(
                'n',
                '<leader>dfg',
                tele.extensions.dap.configurations,
                { desc = 'confi[g]urations' }
            )
            vim.keymap.set(
                'n',
                '<leader>dfb',
                tele.extensions.dap.list_breakpoints,
                { desc = '[b]reakpoints' }
            )
            vim.keymap.set(
                'n',
                '<leader>dfv',
                tele.extensions.dap.variables,
                { desc = '[v]ariables' }
            )
            vim.keymap.set('n', '<leader>dff', tele.extensions.dap.frames, { desc = '[f]rames' })

            -- Register DAP listeners for automatic opening/closing of DAP UI
            dap.listeners.after.event_initialized['dapui_config'] = dap_ui.open
            dap.listeners.before.event_terminated['dapui_config'] = dap_ui.close
            dap.listeners.before.event_exited['dapui_config'] = dap_ui.close

            -- Setup extension plugins for DAP
            dap_ui.setup()
            dap_virt.setup()
            tele.load_extension 'dap'
        end,
    },
    {
        'Olical/conjure', -- Interactive environment for evaluating code within a running program
        dependencies = {
            'tpope/vim-dispatch', -- Asynchronous build and test dispatcher
            'clojure-vim/vim-jack-in', -- Easy commands for Clojure
        },
    },
}
