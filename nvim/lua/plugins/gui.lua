-- Description: Configuration for the NeoVim editor GUI (if you can call it that)
return {
  {
    -- Colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- latte, frappe, macchiato, mocha
      }

      vim.cmd [[ colorscheme catppuccin ]]
    end,
  },
  {
    -- Status Line
    'nvim-lualine/lualine.nvim',
    config = function()
      local lualine = require 'lualine'

      lualine.setup {
        options = {
          theme = 'dracula',
        },

        inactive_sections = {
          -- Show inactive windows' number for easy switching
          lualine_a = {
            {
              function()
                return vim.api.nvim_win_get_number(0)
              end,
            },
          },
        },
      }
    end,
  },
  {
    -- File Explorer
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- Not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      -- Remove legacy key bindings
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

      -- Special symbols for diagnostics
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

      -- Key bindings
      vim.keymap.set('n', '<leader>e', ':Neotree<CR>', { noremap = true, desc = 'Open Explorer' })
      vim.keymap.set(
        'n',
        '<leader>E',
        ':NeoTreeReveal<CR>',
        { noremap = true, desc = 'Open Current File in Explorer' }
      )
      vim.keymap.set(
        'n',
        '<leader>tt',
        ':NeoTreeShowToggle<CR>',
        { noremap = true, desc = 'Toggle File Explorer' }
      )

      -- Enable NeoTree
      require('neo-tree').setup {
        default_component_configs = {
          git_status = {
            symbols = {
              -- Custom git status type symbols
              untracked = '?', -- Had to change this from "" to "?" because it was causing issues
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
        },
      }
    end,
  },
  {
    -- Indentation guidelines
    'lukas-reineke/indent-blankline.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      vim.opt.list = true

      require('indent_blankline').setup {
        show_end_of_line = true,
      }

      vim.g.filetype_exclude = {
        'help',
        'terminal',
        'lazy',
        'alpha',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
        'mason',
        '',
      }

      vim.g.buftype_exclude = { 'terminal', 'nofile' }
    end,
  },
}
