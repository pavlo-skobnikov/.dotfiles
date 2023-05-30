local dap_python = require 'dap-python'

local python_cmds = vim.api.nvim_create_augroup('python_cmds', { clear = true })

local function setup_debugpy()
  local debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
    .. '/venv/bin/python'

  dap_python.setup(debugpy_path)
end

local function set_dap_keymaps()
  vim.keymap.set('n', '<leader>dtc', dap_python.test_class, { desc = 'Debug Test Class' })
  vim.keymap.set('n', '<leader>dtn', dap_python.test_method, { desc = 'Debug Nearest Test' })
  vim.keymap.set('v', '<leader>dts', dap_python.debug_selection, { desc = 'Debug Selection' })
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
