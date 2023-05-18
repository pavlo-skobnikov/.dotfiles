-- Everything related to Language Server Protocol
return {
  {
    -- Plugin that minimizes boilerplate to setup LSP with completions
    -- in NeoVim
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP SUPPORT
      {
        -- Configs for the Nvim LSP client (:help lsp)
        -- Required for `lsp-zero`
        'neovim/nvim-lspconfig',
      },
      {
        -- Package manager for Neovim
        'williamboman/mason.nvim',
        build = 'MasonUpdate',
      },
      {
        -- Bridges mason.nvim with the lspconfig plugin
        'williamboman/mason-lspconfig.nvim',
      },

      -- AUTOCOMPLETION SUPPORT
      {
        -- Autocompletion plugin
        -- Required for `lsp-zero`
        'hrsh7th/nvim-cmp',
      },
      {
        -- Snippet engine for NeoVim
        -- Required for `lsp-zero`
        'L3MON4D3/LuaSnip',
      },
      {
        -- VSCode-style completion options kinds
        'onsails/lspkind-nvim',
      },
      {
        -- AI-powered code completion
        'github/copilot.vim',
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
      -- AUTOCOMPLETION SOURCES
      {
        -- LSP source for nvim-cmp
        -- Required for `lsp-zero`
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
        -- Adds a `luasnip` completion source for `cmp`
        'saadparwaiz1/cmp_luasnip',
        dependencies = {
          {
            -- A bunch of snippets to use
            'rafamadriz/friendly-snippets',
          },
        },
      },
      -- MISCELLANEOUS
      {
        -- Ensure Telescope is present
        -- Used to enhance LSP functionality
        'nvim-telescope/telescope.nvim',
      },
    },
    config = function()
      -- LSP CONFIGURATION
      -- Get the lsp-zero plugin
      local lsp = require 'lsp-zero'

      -- Accept all the default settings
      lsp.preset 'recommended'

      -- Add some additional language servers
      lsp.ensure_installed {
        'jdtls',         -- Java
        'groovyls',      -- Groovy
        'gradle_ls',     -- Gradle
        'tsserver',      -- JavaScript/TypeScript
        'rust_analyzer', -- Rust
        'lua_ls',        -- Lua
        'bashls',        -- Bash
        'marksman',      -- Markdown
        'dockerls',      -- Dockerfile
        'sqlls',         -- SQL
        'yamlls',        -- YAML
        'jsonls',        -- JSON
      }

      -- JDTLS will be set up via the nvim-jdtls plugin
      lsp.skip_server_setup { 'jdtls' }

      -- Fix Undefined global 'vim'
      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      })

      lsp.set_preferences {
        suggest_lsp_servers = false,
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I',
        },
      }

      ---@diagnostic disable-next-line: unused-local
      lsp.on_attach(function(client, bufnr)
        -- For access to Telescope function and further key map assignments
        local telescope_builtin = require 'telescope.builtin'

        local function create_opts(description)
          return { buffer = bufnr, remap = false, desc = description }
        end

        -- LSP Mappings try to mostly be tied to `g` as the leader keybinding
        vim.keymap.set('n', 'K', function()
          vim.lsp.buf.hover()
        end, create_opts 'Show Hover Info')
        vim.keymap.set('i', '<C-S-k>', function()
          vim.lsp.buf.signature_help()
        end, create_opts 'Show Signature Help')

        vim.keymap.set('n', '<leader>=', function()
          vim.lsp.buf.format { async = true }

          vim.cmd 'w'
        end, create_opts 'Format Buffer')

        vim.keymap.set('n', '[d', function()
          vim.diagnostic.goto_next()
        end, create_opts 'Go to Next Diagnostic')
        vim.keymap.set('n', ']d', function()
          vim.diagnostic.goto_prev()
        end, create_opts 'Go to Previous Diagnostic')

        vim.keymap.set('n', 'gd', function()
          vim.lsp.buf.definition()
        end, create_opts 'Go to Definition')
        vim.keymap.set('n', 'gD', function()
          vim.lsp.buf.declaration()
        end, create_opts 'Go to Declaration')

        vim.keymap.set('n', 'gO', function()
          vim.lsp.buf.outgoing_calls()
        end, create_opts 'Go to Outgoing Calls')

        vim.keymap.set('n', 'gi', function()
          vim.lsp.buf.implementation()
        end, create_opts 'Go to Implementation')
        vim.keymap.set('n', 'gI', function()
          vim.lsp.buf.incoming_calls()
        end, create_opts 'Go to Incoming Calls')

        vim.keymap.set('n', 'gt', function()
          vim.lsp.buf.type_definition()
        end, create_opts 'Go to Type Definition')

        vim.keymap.set('n', 'gs', function()
          vim.lsp.buf.document_symbol()
        end, create_opts 'Search Document Symbols')
        vim.keymap.set('n', 'gS', function()
          vim.lsp.buf.workspace_symbol()
        end, create_opts 'Search Workspace Symbols')

        vim.keymap.set('n', 'gl', function()
          vim.diagnostic.open_float()
        end, create_opts 'Open Diagnostics Float')
        vim.keymap.set('n', 'gL', function()
          vim.lsp.codelens.run()
        end, create_opts 'Run Code Lens')

        vim.keymap.set('n', 'ga', function()
          vim.lsp.buf.code_action()
        end, create_opts 'Open Code Actions')

        vim.keymap.set('n', 'gr', function()
          vim.lsp.buf.references()
        end, create_opts 'Find References')
        vim.keymap.set('n', 'gR', function()
          vim.lsp.buf.rename()
        end, create_opts 'Rename Symbol')

        vim.keymap.set('n', 'gQ', function()
          telescope_builtin.diagnostics { bufnr = 0 }
        end, create_opts 'Show Document Diagnostics')
        vim.keymap.set('n', 'gW', function()
          telescope_builtin.diagnostics { severity = vim.diagnostic.severity.WARN }
        end, create_opts 'Show Workspace Warnings')
        vim.keymap.set('n', 'gE', function()
          telescope_builtin.diagnostics { severity = vim.diagnostic.severity.ERROR }
        end, create_opts 'Show Workspace Errors')
      end)

      -- Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()

      -- COMPLETION CONFIGURATION
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      -- Lazy loading is required for the snippet engine to correctly
      -- detect the `luasnip` sources
      require('luasnip/loaders/from_vscode').lazy_load()

      cmp.setup {
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
      }
    end,
  },
}
