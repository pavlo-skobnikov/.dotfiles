-- Completions for NeoVim
return {
    {
        -- Autocompletion plugin
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- SNIPPET ENGINE
            {
                -- Snippet engine for NeoVim
                'L3MON4D3/LuaSnip',
            },
            -- SOURCES
            {
                -- Adds a `luasnip` completion source for `cmp`
                'saadparwaiz1/cmp_luasnip',
                dependencies = {
                    {
                        -- A bunch of snippets to use
                        'rafamadriz/friendly-snippets',
                    },
                },
            },
            {
                -- LSP source for nvim-cmp
                'hrsh7th/cmp-nvim-lsp',
            },
            {
                -- Current buffer completions
                'hrsh7th/cmp-buffer',
            },
            {
                -- Directory/file path completions
                'hrsh7th/cmp-path',
            },
            {
                -- DAP REPL completion
                'rcarriga/cmp-dap',
            },
            -- MISCELLANEOUS
            {
                -- VSCode-style completion options kinds
                'onsails/lspkind-nvim',
            },
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'

            -- Lazy loading is required for the snippet engine to correctly
            -- detect the `luasnip` sources
            require('luasnip/loaders/from_vscode').lazy_load()

            cmp.setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
                sources = {
                    { name = 'dap' },
                },
            })

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
                    { name = 'buffer',  keyword_length = 4 },
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

                    -- Testing
                    ['<C-q>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                },
            }
        end,
    },
}
