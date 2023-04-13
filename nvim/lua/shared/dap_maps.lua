local M = {}

-- local utility_fns = require 'utility.functions'

-- Use an on_attach function to only map the following keys
--  after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  -- local map_w_buf_opts = utility_fns.create_mapping_fn_with_default_opts_and_desc {
  --   noremap = true,
  --   silent = true,
  --   buffer = bufnr,
  -- }

  -- map_w_buf_opts('n', '<leader>dct', '<cmd>lua require"dap".continue()<CR>')
  -- map_w_buf_opts('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>')
  -- map_w_buf_opts('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>')
  -- map_w_buf_opts('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>')
  -- map_w_buf_opts('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>')
  --
  -- map_w_buf_opts('n', '<leader>dsc', '<cmd>lua require"dap.ui.variables".scopes()<CR>')
  -- map_w_buf_opts('n', '<leader>dhh', '<cmd>lua require"dap.ui.variables".hover()<CR>')
  -- map_w_buf_opts('v', '<leader>dhv', '<cmd>lua require"dap.ui.variables".visual_hover()<CR>')
  --
  -- map_w_buf_opts('n', '<leader>duh', '<cmd>lua require"dap.ui.widgets".hover()<CR>')
  -- map_w_buf_opts(
  --   'n',
  --   '<leader>duf',
  --   "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>"
  -- )
  --
  -- map_w_buf_opts(
  --   'n',
  --   '<leader>dsbr',
  --   '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
  -- )
  -- map_w_buf_opts(
  --   'n',
  --   '<leader>dsbm',
  --   '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>'
  -- )
  -- map_w_buf_opts('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>')
  -- map_w_buf_opts('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>')
  --
  -- -- telescope-dap
  -- map_w_buf_opts('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
  -- map_w_buf_opts(
  --   'n',
  --   '<leader>dco',
  --   '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>'
  -- )
  -- map_w_buf_opts(
  --   'n',
  --   '<leader>dlb',
  --   '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>'
  -- )
  -- map_w_buf_opts('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
  -- map_w_buf_opts('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')
end

return M
