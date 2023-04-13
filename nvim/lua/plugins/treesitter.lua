-- Description: Treesitter (parsing code as ASTs) configuration
return {
  {
    -- Treesitter plugin itself
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        ensure_installed = {
          -- Required for Treesitter to function parsers
          'c',
          'lua',
          'vim',
          'help',
          -- Additional parsers
          'org',   -- for "nvim-orgmode/orgmode
          'query', -- for "nvim-treesitter/playground"
          'http',
          'comment',
          'markdown',
          'json',
          'dockerfile',
          'yaml',
          'terraform',
          'hcl',
          -- Git parsers
          'diff',
          'gitattributes',
          'gitcommit',
          'gitignore',
          -- Language parsers
          'sql',
          'java',
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          use_languagetree = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = { 'org' },
        },

        indent = {
          enable = true,
        },
      }
    end,
  },
  {
    -- Treesitter playground -> awesome for debugging queries
    'nvim-treesitter/playground',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
      }
    end,
  },
}
