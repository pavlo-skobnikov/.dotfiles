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
    if client.server_capabilities.hoverProvider then
        vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, create_opts 'Show Hover Info')
    end
    if client.server_capabilities.signatureHelpProvider then
        vim.keymap.set(
            { 'n', 'i' },
            '<C-S-k>',
            vim.lsp.buf.signature_help,
            create_opts 'Show Signature Help'
        )
    end

    vim.keymap.set('n', '<leader>=', function()
        vim.lsp.buf.format { async = true }
    end, create_opts 'Format Buffer')

    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, create_opts 'Go to Next Diagnostic')
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, create_opts 'Go to Prev Diagnostic')

    if client.server_capabilities.definitionProvider then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, create_opts 'Go to Definition')
    end
    if client.server_capabilities.declarationProvider then
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, create_opts 'Go to Declaration')
    end

    if client.server_capabilities.callHierarchyProvider then
        vim.keymap.set('n', 'go', vim.lsp.buf.outgoing_calls, create_opts 'Go to Outgoing Calls')
    end

    if client.server_capabilities.implementationProvider then
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, create_opts 'Go to Implementation')
    end
    if client.server_capabilities.callHierarchyProvider then
        vim.keymap.set('n', 'gI', vim.lsp.buf.incoming_calls, create_opts 'Go to Incoming Calls')
    end

    if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, create_opts 'Go to Type Definition')
    end

    if client.server_capabilities.documentSymbolProvider then
        vim.keymap.set(
            'n',
            '<leader>csd',
            vim.lsp.buf.document_symbol,
            create_opts 'Search Document Symbols'
        )
    end
    if client.server_capabilities.workspaceSymbolProvider then
        vim.keymap.set(
            'n',
            '<leader>csw',
            vim.lsp.buf.workspace_symbol,
            create_opts 'Search Workspace Symbols'
        )
    end

    vim.keymap.set(
        'n',
        '<leader>cf',
        vim.diagnostic.open_float,
        create_opts 'Open Diagnostics Float'
    )
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, create_opts 'Run Code Lens')

    if client.server_capabilities.codeActionProvider then
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, create_opts 'Open Code Actions')
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, create_opts 'Find References')
    end
    if client.server_capabilities.renameProvider then
        vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, create_opts 'Rename Symbol')
    end

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
