-- UTILITY FUNCTIONS
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end

    return false
end

-- SHARED FUNCTIONS MODULE
local M = {}

---@diagnostic disable-next-line: unused-local
function M.on_attach(client, bufnr)
    -- For access to Telescope function and further key map assignments
    local telescope_builtin = require 'telescope.builtin'

    local function create_opts(description)
        return {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = description,
        }
    end

    -- LSP Mappings try to mostly be tied to `g` as the leader keybinding
    vim.keymap.set({ 'n', 'v' }, 'K', function()
        vim.lsp.buf.hover()
    end, create_opts 'Show Hover Info')
    vim.keymap.set({ 'n', 'i' }, '<C-S-k>', function()
        vim.lsp.buf.signature_help()
    end, create_opts 'Show Signature Help')

    vim.keymap.set('n', '<leader>=', function()
        vim.lsp.buf.format { async = true }
    end, create_opts 'Format Buffer')

    vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_next()
    end, create_opts 'Go to Next Diagnostic')
    vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_prev()
    end, create_opts 'Go to Previous Diagnostic')

    vim.keymap.set('n', 'gd', function()
        telescope_builtin.lsp_definitions()
    end, create_opts 'Go to Definition')
    vim.keymap.set('n', 'gD', function()
        vim.lsp.buf.declaration()
    end, create_opts 'Go to Declaration')

    vim.keymap.set('n', 'gO', function()
        telescope_builtin.lsp_outgoing_calls()
    end, create_opts 'Go to Outgoing Calls')

    vim.keymap.set('n', 'gi', function()
        telescope_builtin.lsp_implementations()
    end, create_opts 'Go to Implementation')
    vim.keymap.set('n', 'gI', function()
        telescope_builtin.lsp_incoming_calls()
    end, create_opts 'Go to Incoming Calls')

    vim.keymap.set('n', 'gt', function()
        telescope_builtin.lsp_type_definitions()
    end, create_opts 'Go to Type Definition')

    vim.keymap.set('n', '<leader>csd', function()
        telescope_builtin.lsp_document_symbols()
    end, create_opts 'Search Document Symbols')
    vim.keymap.set('n', '<leader>csw', function()
        telescope_builtin.lsp_workspace_symbols()
    end, create_opts 'Search Workspace Symbols')

    vim.keymap.set('n', '<leader>cd', function()
        vim.diagnostic.open_float()
    end, create_opts 'Open Diagnostics Float')
    vim.keymap.set('n', '<leader>cl', function()
        vim.lsp.codelens.run()
    end, create_opts 'Run Code Lens')

    vim.keymap.set('n', '<leader>ca', function()
        vim.lsp.buf.code_action()
    end, create_opts 'Open Code Actions')

    vim.keymap.set('n', '<leader>cr', function()
        telescope_builtin.lsp_references()
    end, create_opts 'Find References')
    vim.keymap.set('n', '<leader>cn', function()
        vim.lsp.buf.rename()
    end, create_opts 'Rename Symbol')

    vim.keymap.set('n', '<leader>cdd', function()
        telescope_builtin.diagnostics { bufnr = 0 }
    end, create_opts 'Show Document Diagnostics')
    vim.keymap.set('n', '<leader>cdw', function()
        telescope_builtin.diagnostics { severity = vim.diagnostic.severity.WARN }
    end, create_opts 'Show Workspace Warnings')
    vim.keymap.set('n', '<leader>cde', function()
        telescope_builtin.diagnostics { severity = vim.diagnostic.severity.ERROR }
    end, create_opts 'Show Workspace Errors')
end

return M
