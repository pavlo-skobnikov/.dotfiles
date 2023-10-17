local python_cmds = vim.api.nvim_create_augroup('python_cmds', { clear = true })

local function setup_debugpy()
    local dap_python = require 'dap-python'

    local debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
        .. '/venv/bin/python'

    dap_python.setup(debugpy_path)
end

local function set_dap_keymaps()
    local dap_python = require 'dap-python'

    vim.keymap.set('n', '<leader>dtc', dap_python.test_class, { desc = '[c]lass' })
    vim.keymap.set('n', '<leader>dtn', dap_python.test_method, { desc = '[n]earest' })
    vim.keymap.set('v', '<leader>dts', dap_python.debug_selection, { desc = '[s]election' })
end

local function python_setup()
    setup_debugpy()
    set_dap_keymaps()
end

vim.api.nvim_create_autocmd('FileType', {
    group = python_cmds,
    pattern = { 'python' },
    desc = 'Setup Python',
    callback = python_setup,
})
