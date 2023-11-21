local M = {}

function M.onAttach(client, bufnr)
    local tb = require 'telescope.builtin'

    local opts = { silent = true, buffer = bufnr, remap = false }
    local function createOptsWith(values)
        local copy = vim.deepcopy(opts)

        for k, v in pairs(values) do
            copy[k] = v
        end

        return copy
    end

    local function addMappingsForPresentCapabilities(whichKeyMappingTable, capabilitiesAndMappings)
        local mergeTable = {}

        for key, value in pairs(whichKeyMappingTable) do
            mergeTable[key] = value
        end

        for capability, mappings in pairs(capabilitiesAndMappings) do
            if client.server_capabilities[capability] then
                for key, value in pairs(mappings) do
                    mergeTable[key] = value
                end
            end
        end

        return mergeTable
    end

    -- Basic info actions
    RegisterWK({
        K = { vim.lsp.buf.hover, 'Show [k]ind' },
    }, createOptsWith { mode = { 'n', 'v' } })
    RegisterWK({
        ['<C-S-k>'] = { vim.lsp.buf.signature_help, 'Show fn argument [k]inds' },
    }, createOptsWith { mode = { 'n', 'i' } })

    -- Next/previous diagnostic
    RegisterWK({
        [']d'] = { vim.diagnostic.goto_next, 'Next [d]iagnostic' },
        ['[d'] = { vim.diagnostic.goto_prev, 'Previous [d]iagnostic' },
    }, opts)

    -- Go to LSP capability actions
    local function getDiagnosticsFunc(severity)
        return function()
            tb.diagnostics { severity = vim.diagnostic.severity[severity] }
        end
    end

    local goToLspActionMappings = addMappingsForPresentCapabilities({
        name = 'lsp-action',
        s = { getDiagnosticsFunc 'WARN', 'Warning[s]' },
        e = { getDiagnosticsFunc 'ERROR', '[E]rrors' },
    }, {
        ['definitionProvider'] = { f = { vim.lsp.buf.definition, 'De[f]inition' } },
        ['declarationProvider'] = { c = { vim.lsp.buf.declaration, 'De[c]laration' } },
        ['implementationProvider'] = { m = { vim.lsp.buf.implementation, 'I[m]plementation' } },
        ['callHierarchyProvider'] = {
            o = { vim.lsp.buf.outgoing_calls, '[O]utgoing calls' },
            i = { vim.lsp.buf.incoming_calls, '[I]ncoming calls' },
        },
        ['typeDefinitionProvider'] = { t = { vim.lsp.buf.type_definition, '[T]ype definition' } },
        ['documentSymbolProvider'] = { d = { tb.lsp_document_symbols, '[D]ocument symbols' } },
        ['workspaceSymbolProvider'] = { w = { tb.lsp_workspace_symbols, '[W]orkspace symbols' } },
    })

    RegisterWK(goToLspActionMappings, createOptsWith { prefix = 'gl' })

    -- 'Refactor' actions
    local refactorActionMappings = addMappingsForPresentCapabilities({
        name = 'refactor',
        f = { vim.diagnostic.open_float, 'Diagnostics [f]loat' },
        l = { vim.lsp.codelens.run, 'Code [l]ens' },
    }, {
        ['codeActionProvider'] = { a = { vim.lsp.buf.code_action, '[A]ctions' } },
        ['referencesProvider'] = { r = { vim.lsp.buf.references, '[R]eferences' } },
        ['renameProvider'] = { n = { vim.lsp.buf.rename, 'Re[n]ame' } },
        ['documentHighlightProvider'] = {
            h = { vim.lsp.buf.document_highlight, '[H]ighlight symbol' },
        },
    })

    RegisterWK(refactorActionMappings, createOptsWith { prefix = '<LEADER>r' })
end

return M
