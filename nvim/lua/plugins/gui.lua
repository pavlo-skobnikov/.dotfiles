-- Description: Configuration for the NeoVim editor GUI (if you can call it that)
return {
  {
    -- Colorscheme
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup {
        flavour = 'frappe', -- Options: latte, frappe, macchiato, mocha
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
          lualine_b = { 'filename' },
          lualine_c = {},
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
