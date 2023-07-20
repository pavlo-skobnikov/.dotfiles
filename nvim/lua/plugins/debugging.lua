-- Debuggin in NeoVim
return {
    {
        -- Debug Adapter Protocol client
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                -- UI for DAP
                'rcarriga/nvim-dap-ui',
            },
            {
                -- Virtual Text for DAP
                'theHamsta/nvim-dap-virtual-text',
            },
            {
                -- UI picker extension for DAP
                'nvim-telescope/telescope-dap.nvim',
            },
            {
                -- Required for `telescope-dap.nvim`
                'nvim-telescope/telescope.nvim',
            },
            {
                -- Debug Adapter for Python
                'mfussenegger/nvim-dap-python',
            },
            {
                -- Debug Adapter for Go
                'leoluz/nvim-dap-go',
            },
        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'
            local dap_virtual_text = require 'nvim-dap-virtual-text'
            local telescope = require 'telescope'

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

            -- Mappings for DAP
            -- dap-ui mappings
            vim.keymap.set('n', '<leader>dd', function()
                require('dapui').toggle()
            end, { desc = 'Toggle DAP UI' })

            -- nvim-dap mappings
            vim.keymap.set('n', '<leader>dc', function()
                require('dap').continue()
            end, { desc = 'Continue' })
            vim.keymap.set('n', '<leader>dsn', function()
                require('dap').step_over()
            end, { desc = 'Step Over (Next)' })
            vim.keymap.set('n', '<leader>dsi', function()
                require('dap').step_into()
            end, { desc = 'Step Into' })
            vim.keymap.set('n', '<leader>dso', function()
                require('dap').step_out()
            end, { desc = 'Step Out' })
            vim.keymap.set('n', '<leader>dbt', function()
                require('dap').toggle_breakpoint()
            end, { desc = 'Toggle Breakpoint' })
            vim.keymap.set('n', '<leader>dbc', function()
                require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = 'Set Conditional Breakpoint' })
            vim.keymap.set('n', '<leader>dbl', function()
                require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
            end, { desc = 'Set Log Point' })
            vim.keymap.set('n', '<leader>do', function()
                require('dap').repl.open()
            end, { desc = 'Open REPL' })
            vim.keymap.set('n', '<leader>dr', function()
                require('dap').run_last()
            end, { desc = 'Run Last' })
            vim.keymap.set({ 'n', 'v' }, '<leader>dwh', function()
                require('dap.ui.widgets').hover()
            end, { desc = 'Hover' })
            vim.keymap.set({ 'n', 'v' }, '<leader>dwp', function()
                require('dap.ui.widgets').preview()
            end, { desc = 'Preview' })
            vim.keymap.set('n', '<leader>dwf', function()
                local widgets = require 'dap.ui.widgets'
                widgets.centered_float(widgets.frames)
            end, { desc = 'Frames' })
            vim.keymap.set('n', '<leader>dws', function()
                local widgets = require 'dap.ui.widgets'
                widgets.centered_float(widgets.scopes)
            end, { desc = 'Scopes' })

            -- telescope-dap mappings
            vim.keymap.set('n', '<leader>dfc', function()
                require('telescope').extensions.dap.commands {}
            end, { desc = 'Find Commands' })
            vim.keymap.set('n', '<leader>dfg', function()
                require('telescope').extensions.dap.configurations {}
            end, { desc = 'Find Configurations' })
            vim.keymap.set('n', '<leader>dfb', function()
                require('telescope').extensions.dap.list_breakpoints {}
            end, { desc = 'Find Breakpoints' })
            vim.keymap.set('n', '<leader>dfv', function()
                require('telescope').extensions.dap.variables {}
            end, { desc = 'Find Variables' })
            vim.keymap.set('n', '<leader>dff', function()
                require('telescope').extensions.dap.frames {}
            end, { desc = 'Find Frames' })

            -- Register DAP listeners for automatic opening/closing of DAP UI
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end

            -- Setup extension plugins for DAP
            dapui.setup()
            dap_virtual_text.setup()
            telescope.load_extension 'dap'
        end,
    },
}
