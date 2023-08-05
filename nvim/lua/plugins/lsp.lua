return {
    {
        'williamboman/mason-lspconfig.nvim', -- Bridges mason.nvim with the lspconfig plugin
        dependencies = {
            {
                -- Package manager for Neovim
                'williamboman/mason.nvim',
                build = ':MasonUpdate',
            },
            'neovim/nvim-lspconfig', -- Configs for the Nvim LSP client (:help lsp)
            'mfussenegger/nvim-jdtls', -- Significant improvements to the Eclipse JDTLS
            {
                -- Scala MetaLS
                'scalameta/nvim-metals',
                dependencies = {
                    'nvim-lua/plenary.nvim',
                },
            },
            'nvim-telescope/telescope.nvim', -- Used to enhance LSP functionality
            'hrsh7th/cmp-nvim-lsp', -- Used to extend capabilities
        },
        config = function()
            require('mason').setup()

            local mason_lspconfig = require 'mason-lspconfig'

            mason_lspconfig.setup {
                ensure_installed = {
                    'clangd', -- C
                    'lua_ls', -- Lua
                    'pylsp', -- Python
                    'gopls', -- Go
                    'jdtls', -- Java
                    'clojure_lsp', -- Clojure
                    'tsserver', -- TypeScript
                    'bashls', -- Bash
                    'marksman', -- Markdown
                    'dockerls', -- Dockerfile
                    'sqlls', -- SQL
                    'yamlls', -- YAML
                    'jsonls', -- JSON
                },
            }

            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local on_attach = require('user.util').on_attach

            local lspconfig = require 'lspconfig'

            local servers_to_not_auto_setup = {
                'jdtls',
            }

            mason_lspconfig.setup_handlers {
                -- Default setup for non-specified language servers
                function(server_name)
                    if table.contains(servers_to_not_auto_setup, server_name) then
                        return
                    end

                    lspconfig[server_name].setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                    }
                end,
                ['lua_ls'] = function()
                    lspconfig.lua_ls.setup {
                        on_attach = on_attach,
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' },
                                },
                            },
                        },
                    }
                end,
            }
        end,
    },
    {
        'github/copilot.vim', -- AI-powered code completion
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            vim.cmd [[
            imap <silent><script><expr> <C-S-y> copilot#Accept("\<CR>")
            let g:copilot_no_tab_map = v:true
          ]]

            vim.keymap.set('i', '<C-M-y>', function()
                ---@diagnostic disable-next-line: unused-local
                local suggestion = vim.fn['copilot#Accept'] ''

                local bar = vim.fn['copilot#TextQueuedForInsertion']()
                return vim.fn.split(bar, [[[ .]\zs]])[1]
            end, { expr = true, remap = false })

            -- Bring up the suggestions panel
            vim.keymap.set('n', '<C-;>', ':Copilot panel<CR>', { noremap = true, silent = true })
        end,
    },
}
