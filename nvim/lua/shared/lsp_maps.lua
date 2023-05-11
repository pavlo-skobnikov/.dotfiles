local M = {}

local utility_fns = require 'utility.functions'

local builtin = require 'telescope.builtin' -- For access to Telescope function and further key map assignments

local map_w_opts =
  utility_fns.create_mapping_fn_with_default_opts_and_desc { noremap = true, silent = true }

-- Create LSP mappings that should be available outside of a buffer
function M.on_startup()
  map_w_opts('n', '<space>Q', builtin.diagnostics, 'Show Global Diagnostics')

  map_w_opts('n', 'gS', builtin.lsp_workspace_symbols, 'Go to Workspace Symbols')
end

-- Use an on_attach function to only map the following keys
--  after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
  local map_w_buf_opts = utility_fns.create_mapping_fn_with_default_opts_and_desc {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  map_w_opts('n', '<space>x', vim.diagnostic.open_float, 'Explain Diagnostic')

  map_w_opts('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
  map_w_opts('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')

  map_w_opts('n', '<space>q', function()
    builtin.diagnostics { bufnr = 0 }
  end, 'Show Local Diagnostics')

  map_w_opts('n', '<space>W', function()
    builtin.diagnostics { severity = vim.diagnostic.severity.WARN }
  end, 'Show All Warnings')

  map_w_opts('n', '<space>X', function()
    builtin.diagnostics { severity = vim.diagnostic.severity.ERROR }
  end, 'Show All Errors')

  map_w_opts('n', 'gs', builtin.lsp_document_symbols, 'Go to Buffer Symbols')

  map_w_opts('n', 'gi', builtin.lsp_incoming_calls, 'Go to Incoming Calls')
  map_w_buf_opts('n', 'gI', builtin.lsp_implementations, 'Go to Implementation')

  map_w_opts('n', 'go', builtin.lsp_outgoing_calls, 'Go to Outgoing Calls')

  map_w_buf_opts('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
  map_w_buf_opts('n', 'gd', builtin.lsp_definitions, 'Go to Definition')

  map_w_buf_opts('n', 'gr', builtin.lsp_references, 'Go to References')

  map_w_buf_opts('n', 'K', vim.lsp.buf.hover, 'Show Documentation')

  map_w_buf_opts('n', 'gl', vim.lsp.codelens.run, 'Go to CodeLens')

  map_w_buf_opts({ 'n', 'i' }, '<C-S-k>', vim.lsp.buf.signature_help, 'Signature Help')

  map_w_buf_opts('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add Folder to Workspace')
  map_w_buf_opts(
    'n',
    '<space>wr',
    vim.lsp.buf.remove_workspace_folder,
    'Remove Folder from Workspace'
  )
  map_w_buf_opts('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List Workspace Folders')

  map_w_buf_opts('n', 'gt', builtin.lsp_type_definitions, 'Jump to Type Definition for Symbol')

  map_w_buf_opts('n', '<space>n', function()
    -- Save buffer before renaming
    vim.cmd 'w'

    vim.lsp.buf.rename()
  end, 'Rename')

  map_w_buf_opts('n', '<space>l', vim.lsp.buf.code_action, 'Show LSP Actions')

  map_w_buf_opts({ 'n', 'v' }, '<space>=', function()
    vim.lsp.buf.format { async = true }

    vim.cmd 'w'
  end, 'Format Buffer')
end

return M
