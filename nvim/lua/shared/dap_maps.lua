local M = {}

local utility_fns = require 'utility.functions'

-- Use an on_attach function to only map the following keys
--  after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
  local map_w_buf_opts = utility_fns.create_mapping_fn_with_default_opts_and_desc {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  map_w_buf_opts('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>', 'Continue')
  map_w_buf_opts('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>', 'Step Over')
  map_w_buf_opts('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>', 'Step Into')
  map_w_buf_opts('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>', 'Step Out')
  map_w_buf_opts(
    'n',
    '<leader>dtb',
    '<cmd>lua require"dap".toggle_breakpoint()<CR>',
    'Toggle Breakpoint'
  )

  map_w_buf_opts('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>', 'Scopes')
  map_w_buf_opts('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>', 'Hover')
  map_w_buf_opts(
    'v',
    '<leader>dhv',
    '<cmd>lua require"dap.ui.variables".visual_hover()<CR>',
    'Visual Hover'
  )

  map_w_buf_opts(
    'n',
    '<leader>duh',
    '<cmd>lua require"dap.ui.widgets".hover()<CR>',
    'Widgets Hover'
  )
  map_w_buf_opts(
    'n',
    '<leader>duf',
    "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
    'Widgets Scopes'
  )

  map_w_buf_opts(
    'n',
    '<leader>dsbr',
    '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
    'Set Breakpoint Condition'
  )
  map_w_buf_opts(
    'n',
    '<leader>dsbm',
    '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
    'Set Log Point'
  )
  map_w_buf_opts('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>', 'Open REPL')
  map_w_buf_opts('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>', 'Run Last REPL')

  -- telescope-dap
  map_w_buf_opts(
    'n',
    '<leader>dcc',
    '<cmd>lua require"telescope".extensions.dap.commands{}<CR>',
    'Commands'
  )
  map_w_buf_opts(
    'n',
    '<leader>dco',
    '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>',
    'Configurations'
  )
  map_w_buf_opts(
    'n',
    '<leader>dlb',
    '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>',
    'List Breakpoints'
  )
  map_w_buf_opts(
    'n',
    '<leader>dv',
    '<cmd>lua require"telescope".extensions.dap.variables{}<CR>',
    'Variables'
  )
  map_w_buf_opts(
    'n',
    '<leader>df',
    '<cmd>lua require"telescope".extensions.dap.frames{}<CR>',
    'Frames'
  )
end

return M
