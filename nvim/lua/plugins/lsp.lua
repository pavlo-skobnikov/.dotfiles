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
        build = ':MasonUpdate',
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
      -- Debug Adapter Protocol
      {
        -- DAP client
        'mfussenegger/nvim-dap',
        dependencies = {
          {
            -- UI for DAP
            'rcarriga/nvim-dap-ui',
          },
          {
            -- Virtual Text for DAP
            'theHamsta/nvim-dap-virtual-text',
          },
          {
            -- UI picker extension for DAP
            'nvim-telescope/telescope-dap.nvim',
          },
          {
            -- Required for `telescope-dap.nvim`
            'nvim-telescope/telescope.nvim',
          },
          {
            -- Debug Adapter for Python
            'mfussenegger/nvim-dap-python',
          },
        },
        config = function()
          local dap = require 'dap'
          local dapui = require 'dapui'
          local dap_virtual_text = require 'nvim-dap-virtual-text'
          local telescope = require 'telescope'

          -- Kotlin adapter and configuration
          dap.adapters.kotlin = {
            type = 'executable',
            command = 'kotlin-debug-adapter',
            args = { '--interpreter=vscode' },
          }

          dap.configurations.kotlin = {
            {
              type = 'kotlin',
              name = 'launch - kotlin',
              request = 'launch',
              projectRoot = vim.fn.getcwd() .. '/app',
              mainClass = function()
                -- Insert path to main class > "myapp.sample.app.AppKt"
                return vim.fn.input('Path to main class > ', '', 'file')
              end,
            },
          }

          -- Redefine DAP signs
          vim.fn.sign_define(
            'DapBreakpoint',
            { text = '🛑', texthl = '', linehl = '', numhl = '' }
          )
          vim.fn.sign_define(
            'DapBreakpointCondition',
            { text = '🟥', texthl = '', linehl = '', numhl = '' }
          )
          vim.fn.sign_define('DapLogPoint', { text = '📍', texthl = '', linehl = '', numhl = '' })
          vim.fn.sign_define(
            'DapStopped',
            { text = '➡️', texthl = '', linehl = '', numhl = '' }
          )
          vim.fn.sign_define(
            'DapBreakpointRejected',
            { text = '❌', texthl = '', linehl = '', numhl = '' }
          )

          -- Mappings for DAP
          -- dap-ui mappings
          vim.keymap.set('n', '<leader>dd', function()
            require('dapui').toggle()
          end, { desc = 'Toggle DAP UI' })

          -- nvim-dap mappings
          vim.keymap.set('n', '<leader>dac', function()
            require('dap').continue()
          end, { desc = 'Continue' })
          vim.keymap.set('n', '<leader>dan', function()
            require('dap').step_over()
          end, { desc = 'Step Over' })
          vim.keymap.set('n', '<leader>dai', function()
            require('dap').step_into()
          end, { desc = 'Step Into' })
          vim.keymap.set('n', '<leader>dao', function()
            require('dap').step_out()
          end, { desc = 'Step Out' })
          vim.keymap.set('n', '<leader>dbt', function()
            require('dap').toggle_breakpoint()
          end, { desc = 'Toggle Breakpoint' })
          vim.keymap.set('n', '<leader>dbc', function()
            require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
          end, { desc = 'Set Conditional Breakpoint' })
          vim.keymap.set('n', '<leader>dbl', function()
            require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
          end, { desc = 'Set Log Point' })
          vim.keymap.set('n', '<leader>dr', function()
            require('dap').repl.open()
          end, { desc = 'Open REPL' })
          vim.keymap.set('n', '<leader>dR', function()
            require('dap').run_last()
          end, { desc = 'Run Last' })
          vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
            require('dap.ui.widgets').hover()
          end, { desc = 'Hover' })
          vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
            require('dap.ui.widgets').preview()
          end, { desc = 'Preview' })
          vim.keymap.set('n', '<leader>dF', function()
            local widgets = require 'dap.ui.widgets'
            widgets.centered_float(widgets.frames)
          end, { desc = 'Frames' })
          vim.keymap.set('n', '<leader>ds', function()
            local widgets = require 'dap.ui.widgets'
            widgets.centered_float(widgets.scopes)
          end, { desc = 'Scopes' })

          -- telescope-dap mappings
          vim.keymap.set('n', '<leader>dfc', function()
            require('telescope').extensions.dap.commands {}
          end, { desc = 'Find Commands' })
          vim.keymap.set('n', '<leader>dfC', function()
            require('telescope').extensions.dap.configurations {}
          end, { desc = 'Find Configurations' })
          vim.keymap.set('n', '<leader>dfb', function()
            require('telescope').extensions.dap.list_breakpoints {}
          end, { desc = 'Find Breakpoints' })
          vim.keymap.set('n', '<leader>dfv', function()
            require('telescope').extensions.dap.variables {}
          end, { desc = 'Find Variables' })
          vim.keymap.set('n', '<leader>dff', function()
            require('telescope').extensions.dap.frames {}
          end, { desc = 'Find Frames' })

          -- Register DAP listeners for automatic opening/closing of DAP UI
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end

          -- Setup extension plugins for DAP
          dapui.setup()
          dap_virtual_text.setup()
          telescope.load_extension 'dap'
        end,
      },
      -- NVIM JDTLS
      {
        -- Significant improvements to the Eclipse JDTLS
        -- NB: Also includes a debug adapter!
        'mfussenegger/nvim-jdtls',
        build = {
          -- Ensure custom source folder exists
          'mkdir -p ~/.local/source/',
          -- Clean and clone JDTLS debugger extension
          'rm -rf ~/.local/source/vscode-java-decompiler',
          'git clone https://github.com/dgileadi/vscode-java-decompiler ~/.local/source/vscode-java-decompiler',
        },
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
      {
        -- DAP REPL completion
        'rcarriga/cmp-dap',
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
        'jdtls', -- Java
        'groovyls', -- Groovy
        'kotlin_language_server', -- Kotlin
        'gradle_ls', -- Gradle
        'tsserver', -- JavaScript/TypeScript
        'rust_analyzer', -- Rust
        'pylsp', -- Python
        'zls', -- Zig
        'lua_ls', -- Lua
        'bashls', -- Bash
        'marksman', -- Markdown
        'dockerls', -- Dockerfile
        'sqlls', -- SQL
        'yamlls', -- YAML
        'jsonls', -- JSON
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

        vim.keymap.set('n', 'gs', function()
          telescope_builtin.lsp_document_symbols()
        end, create_opts 'Search Document Symbols')
        vim.keymap.set('n', 'gS', function()
          telescope_builtin.lsp_workspace_symbols()
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
          telescope_builtin.lsp_references()
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
          { name = 'buffer', keyword_length = 4 },
        },
      }
    end,
  },
}
