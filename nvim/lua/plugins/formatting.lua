return {
  -- For available formatter options see:
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          -- Diagnostic
          null_ls.builtins.diagnostics.pylint.with {
            -- Disable displaying diagnostics visually
            diagnostic_config = { underline = false, virtual_text = false, signs = false },
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          },                                              -- "python"
          null_ls.builtins.diagnostics.markdownlint,      -- "markdown"
          -- Formatting
          null_ls.builtins.formatting.sql_formatter,      -- "sql"
          null_ls.builtins.formatting.jq,                 -- "json"
          null_ls.builtins.formatting.stylua,             -- "lua", "luau"
          null_ls.builtins.formatting.google_java_format, -- "java"
          null_ls.builtins.formatting.zigfmt,             -- "zig"
          null_ls.builtins.formatting.black,              -- "python"
          null_ls.builtins.formatting.prettier,           -- "javascript", "javascriptreact",
          -- "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json",
          -- "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars"

          -- Diagnostic + Formatting
          null_ls.builtins.diagnostics.ktlint, -- "kotlin"
        },
      }
    end,
  },
}
