-- Description: Everything related to Language Server Protocol
return {
  { -- LSP extension for NeoVim-specific Lua development
    'folke/neodev.nvim',
  },
  {
    -- Improvements for the Eclipse JDT Language Server
    'mfussenegger/nvim-jdtls',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },
  { -- Easily manage external editor tooling such as LSP servers,
    -- DAP servers, linters, and formatters through a single interface
    'williamboman/mason.nvim',
  },
  { -- Bridges mason.nvim with the lspconfig plugin
    -- -> making it easier to use both plugins together
    'williamboman/mason-lspconfig.nvim',
  },
  {
    -- Native LSP configuration for NeoVim
    'neovim/nvim-lspconfig',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('mason').setup()
      -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
      require('mason-lspconfig').setup {
        ensure_installed = {
          -- Dockerfile
          'dockerls',
          -- Bash
          'bashls',
          -- Markdown
          'marksman',
          -- YAML
          'yamlls',
          -- JSON
          'jsonls',
          -- Lua
          'lua_ls',
          -- Java
          'jdtls',
          -- Groovy
          -- 'groovyls',
          -- Gradle
          'gradle_ls',
          -- HTML
          'html',
          -- CSS
          'cssls',
          -- JavaScript/TypeScript
          'tsserver',
          'quick_lint_js',
          -- Rust
          'rust_analyzer',
        },

        automatic_installation = false,
      }

      local lsp_maps = require 'shared.lsp_maps'

      lsp_maps.on_startup()

      local lsp_config = require 'lspconfig'

      local on_attach = function(client, bufnr)
        lsp_maps.on_attach(client, bufnr)
      end

      lsp_config.dockerls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.bashls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.marksman.setup { on_attach = lsp_maps.on_attach }
      lsp_config.yamlls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.jsonls.setup { on_attach = lsp_maps.on_attach }

      lsp_config.lua_ls.setup {
        on_attach = on_attach,

        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim',
              },
            },
          },
        },
      }

      lsp_config.groovyls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.gradle_ls.setup { on_attach = lsp_maps.on_attach }

      lsp_config.html.setup { on_attach = lsp_maps.on_attach }
      lsp_config.cssls.setup { on_attach = lsp_maps.on_attach }
      lsp_config.tsserver.setup { on_attach = lsp_maps.on_attach }
      lsp_config.quick_lint_js.setup { on_attach = lsp_maps.on_attach }

      lsp_config.rust_analyzer.setup {
        on_attach = lsp_maps.on_attach,
        filetypes = { 'rust', 'rs' },
        root_dir = lsp_config.util.root_pattern('Cargo.toml', 'rust-project.json', '.git'),
        settings = {
          ['rust-analyzer'] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      }
    end,
  },
  { -- Debug Adapter Protocol client implementation
    'mfussenegger/nvim-dap',
  },
  {
    -- A UI for nvim-dap
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
  },
}
