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
    local tb = require 'telescope.builtin'

    vim.keymap.set({ 'n', 'v' }, 'K', vim.lsp.buf.hover, {
        silent = true,
        buffer = bufnr,
        remap = false,
    })
    vim.keymap.set({ 'n', 'i' }, '<C-S-k>', vim.lsp.buf.signature_help, {
        silent = true,
        buffer = bufnr,
        remap = false,
    })

    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'Next [d]iagnostic',
    })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'Previous [d]iagnostic',
    })

    if client.server_capabilities.definitionProvider then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [d]efinition',
        })
    end
    if client.server_capabilities.declarationProvider then
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [d]eclaration',
        })
    end

    if client.server_capabilities.callHierarchyProvider then
        vim.keymap.set('n', 'go', vim.lsp.buf.outgoing_calls, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [o]utgoing calls',
        })
    end

    if client.server_capabilities.implementationProvider then
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [i]mplementation',
        })
    end
    if client.server_capabilities.callHierarchyProvider then
        vim.keymap.set('n', 'gI', vim.lsp.buf.incoming_calls, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [i]ncoming calls',
        })
    end

    if client.server_capabilities.typeDefinitionProvider then
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = 'Go to [t]ype definition',
        })
    end

    if client.server_capabilities.documentSymbolProvider then
        vim.keymap.set('n', '<leader>rsd', tb.lsp_document_symbols, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[d]ocument symbols',
        })
    end
    if client.server_capabilities.workspaceSymbolProvider then
        vim.keymap.set('n', '<leader>rsw', tb.lsp_workspace_symbols, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[w]orkspace symbols',
        })
    end

    vim.keymap.set('n', '<leader>rf', vim.diagnostic.open_float, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'diagnostics [f]loat',
    })
    vim.keymap.set('n', '<leader>rl', vim.lsp.codelens.run, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'code [l]ens',
    })

    if client.server_capabilities.codeActionProvider then
        vim.keymap.set('n', '<leader>ra', vim.lsp.buf.code_action, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[a]ctions',
        })
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set('n', '<leader>rr', vim.lsp.buf.references, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[r]eferences',
        })
    end
    if client.server_capabilities.renameProvider then
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[n]ame',
        })
    end

    vim.keymap.set('n', '<leader>rdd', function()
        tb.diagnostics { bufnr = 0 }
    end, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'search [d]ocument',
    })
    vim.keymap.set('n', '<leader>rdw', function()
        tb.diagnostics { severity = vim.diagnostic.severity.WARN }
    end, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'search workspace [w]arnings',
    })
    vim.keymap.set('n', '<leader>rde', function()
        tb.diagnostics { severity = vim.diagnostic.severity.ERROR }
    end, {
        silent = true,
        buffer = bufnr,
        remap = false,
        desc = 'workspace [e]rrors',
    })

    if client.server_capabilities.documentHighlightProvider then
        vim.keymap.set('n', '<leader>rh', vim.lsp.buf.document_highlight, {
            silent = true,
            buffer = bufnr,
            remap = false,
            desc = '[h]ighlight symbol',
        })
    end
end

return M
