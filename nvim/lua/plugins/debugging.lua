return {
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
        vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define(
            'DapBreakpointCondition',
            { text = '🟥', texthl = '', linehl = '', numhl = '' }
        )
        vim.fn.sign_define('DapLogPoint', { text = '📍', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '➡️', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define(
            'DapBreakpointRejected',
            { text = '❌', texthl = '', linehl = '', numhl = '' }
        )

        -- Modules with mapped functionality
        local dap = require 'dap'
        local dapui = require 'dapui'
        local widgets = require 'dap.ui.widgets'
        local dap_virtual_text = require 'nvim-dap-virtual-text'
        local telescope = require 'telescope'

        -- Mappings for DAP
        -- dap-ui mappings
        vim.keymap.set('n', '<leader>dd', dapui.toggle, { desc = 'Toggle DAP UI' })

        -- nvim-dap mappings
        vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
        vim.keymap.set('n', '<leader>dsn', dap.step_over, { desc = 'Step Over (Next)' })
        vim.keymap.set('n', '<leader>dsi', dap.step_into, { desc = 'Step Into' })
        vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = 'Step Out' })
        vim.keymap.set('n', '<leader>dbt', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>dbc', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Set Conditional Breakpoint' })
        vim.keymap.set('n', '<leader>dbl', function()
            dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
        end, { desc = 'Set Log Point' })
        vim.keymap.set('n', '<leader>do', dap.repl.open, { desc = 'Open REPL' })
        vim.keymap.set('n', '<leader>dr', dap.run_last, { desc = 'Run Last' })
        vim.keymap.set({ 'n', 'v' }, '<leader>dwh', widgets.hover, { desc = 'Hover' })
        vim.keymap.set({ 'n', 'v' }, '<leader>dwp', widgets.preview, { desc = 'Preview' })
        vim.keymap.set('n', '<leader>dwf', function()
            widgets.centered_float(widgets.frames)
        end, { desc = 'Frames' })
        vim.keymap.set('n', '<leader>dws', function()
            widgets.centered_float(widgets.scopes)
        end, { desc = 'Scopes' })

        -- telescope-dap mappings
        vim.keymap.set(
            'n',
            '<leader>dfc',
            telescope.extensions.dap.commands,
            { desc = 'Find Commands' }
        )
        vim.keymap.set(
            'n',
            '<leader>dfg',
            telescope.extensions.dap.configurations,
            { desc = 'Find Configurations' }
        )
        vim.keymap.set(
            'n',
            '<leader>dfb',
            telescope.extensions.dap.list_breakpoints,
            { desc = 'Find Breakpoints' }
        )
        vim.keymap.set(
            'n',
            '<leader>dfv',
            telescope.extensions.dap.variables,
            { desc = 'Find Variables' }
        )
        vim.keymap.set(
            'n',
            '<leader>dff',
            telescope.extensions.dap.frames,
            { desc = 'Find Frames' }
        )

        -- Register DAP listeners for automatic opening/closing of DAP UI
        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Setup extension plugins for DAP
        dapui.setup()
        dap_virtual_text.setup()
        telescope.load_extension 'dap'
    end,
}
