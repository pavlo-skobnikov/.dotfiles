return {
    {
        'williamboman/mason-lspconfig.nvim', -- Bridges mason.nvim with the lspconfig plugin
        dependencies = {
            {
                'williamboman/mason.nvim', -- Package manager for Neovim
                build = ':MasonUpdate',
            },
            'neovim/nvim-lspconfig', -- Configs for the Nvim LSP client (:help lsp)
            'mfussenegger/nvim-jdtls', -- Significant improvements to the Eclipse JDTLS
            {
                'scalameta/nvim-metals', -- Scala MetaLS
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
                    'zls', -- Zig
                    'rust_analyzer', -- Rust
                    'lua_ls', -- Lua
                    'pylsp', -- Python
                    'gopls', -- Go
                    'jdtls', -- Java
                    'kotlin_language_server', -- Kotlin
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
                -- Scala doesn't need to be ignored
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
                                    globals = {
                                        'vim',
                                        'hs',
                                    },
                                },
                            },
                        },
                    }
                end,
            }
        end,
    },
    {
        'hrsh7th/nvim-cmp', -- Autocompletion plugin
        dependencies = {
            -- SNIPPET ENGINE
            'L3MON4D3/LuaSnip', -- Snippet engine for NeoVim
            -- SOURCES
            'saadparwaiz1/cmp_luasnip', -- Adds a `luasnip` completion source for `cmp`
            'rafamadriz/friendly-snippets', -- A bunch of snippets to use
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'hrsh7th/cmp-buffer', -- Current buffer completions
            'hrsh7th/cmp-path', -- Directory/file path completions
            'hrsh7th/cmp-cmdline', -- Command-line completion
            'rcarriga/cmp-dap', -- DAP REPL completion
            'petertriho/cmp-git', -- Git completion
            'PaterJason/cmp-conjure', -- Conjure completion
            -- MISCELLANEOUS
            'onsails/lspkind-nvim', -- VSCode-style completion options kinds
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'

            -- Lazy loading is required for the snippet engine to correctly
            -- detect the `luasnip` sources
            require('luasnip/loaders/from_vscode').lazy_load()

            cmp.setup {
                -- For cmp-dap
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
                        or require('cmp_dap').is_dap_buffer()
                end,
                -- Enable snippets
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                formatting = {
                    -- Enable icons to appear with completion options
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            buffer = '[buf]',
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[api]',
                            path = '[path]',
                            luasnip = '[snip]',
                        },
                    },
                },
                -- Setting sources priority for appearing in completion prompts
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip', keyword_length = 2 },
                    { name = 'buffer', keyword_length = 4 },
                    { name = 'conjure' },
                },
                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-y>'] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { 'i', 'c' }
                    ),
                    ['<M-y>'] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false,
                        },
                        { 'i', 'c' }
                    ),

                    ['<C-Space>'] = cmp.mapping {
                        i = cmp.mapping.complete(),
                        c = function()
                            if cmp.visible() then
                                if not cmp.confirm { select = true } then
                                    return
                                end
                            else
                                cmp.complete()
                            end
                        end,
                    },

                    ['<Tab>'] = cmp.config.disable,
                },
            }

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })

            cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
                sources = {
                    { name = 'dap' },
                },
            })

            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'git' },
                }, {
                    { name = 'buffer' },
                }),
            })
        end,
    },
    {
        'github/copilot.vim', -- AI-powered code completion
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
