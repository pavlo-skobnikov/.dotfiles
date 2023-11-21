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
            local function setDapSign(name, sign)
                vim.fn.sign_define(name, { text = sign, texthl = '', linehl = '', numhl = '' })
            end

            setDapSign('DapBreakpoint', '🛑')
            setDapSign('DapBreakpointCondition', '🟥')
            setDapSign('DapLogPoint', '📍')
            setDapSign('DapStopped', '➡️')
            setDapSign('DapBreakpointRejected', '❌')

            -- Setup mappings
            local dap = require 'dap'
            local dap_ui = require 'dapui'
            local widgets = require 'dap.ui.widgets'
            local dap_virt = require 'nvim-dap-virtual-text'
            local tele = require 'telescope'

            RegisterWK({
                name = 'dap',
                d = { dap_ui.toggle, '[D]AP UI' },
                c = { dap.continue, '[C]ontinue' },
                o = { dap.repl.open, '[O]pen REPL' },
                r = { dap.run_last, '[R]un last' },
                b = {
                    name = 'breakpoint',
                    t = { dap.toggle_breakpoint, '[T]oggle simple' },
                    c = {
                        function()
                            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
                        end,
                        'Toggle [c]onditional',
                    },
                    l = {
                        function()
                            dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
                        end,
                        'Toggle [l]ogging',
                    },
                },
                f = {
                    name = 'find',
                    c = { tele.extensions.dap.commands, '[C]ommands' },
                    g = { tele.extensions.dap.configurations, 'Confi[g]urations' },
                    b = { tele.extensions.dap.list_breakpoints, '[B]reakpoints' },
                    v = { tele.extensions.dap.variables, '[V]ariables' },
                    f = { tele.extensions.dap.frames, '[F]rames' },
                },
                s = {
                    name = 'step',
                    n = { dap.step_over, '[N]ext' },
                    i = { dap.step_into, '[I]nto' },
                    o = { dap.step_out, '[O]ut' },
                },
            }, { prefix = '<leader>d' })

            RegisterWK({
                name = 'widgets',
                h = { widgets.hover, '[H]over' },
                p = { widgets.preview, '[P]review' },
                f = {
                    function()
                        widgets.centered_float(widgets.frames)
                    end,
                    '[F]rames',
                },
                s = {
                    function()
                        widgets.centered_float(widgets.scopes)
                    end,
                    '[S]copes',
                },
            }, { mode = { 'n', 'v' }, prefix = '<leader>dw' })

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
            'folke/which-key.nvim',
        },
        config = function()
            RegisterWK({
                e = {
                    name = 'evaluate',
                    c = 'comment',
                },
                g = 'get',
                l = 'log',
                r = 'run',
            }, { prefix = '<LOCALLEADER>' })
        end
    },
}
