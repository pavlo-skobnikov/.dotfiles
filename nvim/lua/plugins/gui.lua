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
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local actions = require 'telescope.actions'
      require('telescope').setup {
        extensions = {
          file_browser = {
            mappings = {
              ['i'] = {
                ['<Tab>'] = function(prompt_bufnr)
                  actions.toggle_selection(prompt_bufnr)
                  actions.move_selection_previous(prompt_bufnr)
                end,
                ['<S-Tab>'] = function(prompt_bufnr)
                  actions.toggle_selection(prompt_bufnr)
                  actions.move_selection_next(prompt_bufnr)
                end,
              },
              ['n'] = {
                ['<Tab>'] = function(prompt_bufnr)
                  actions.toggle_selection(prompt_bufnr)
                  actions.move_selection_previous(prompt_bufnr)
                end,
                ['<S-Tab>'] = function(prompt_bufnr)
                  actions.toggle_selection(prompt_bufnr)
                  actions.move_selection_next(prompt_bufnr)
                end,
              },
            },
          },
        },
      }

      vim.api.nvim_set_keymap('n', '<leader>e', ':Telescope file_browser<CR>', {
        noremap = true,
        desc = 'Open explorer',
      })

      vim.api.nvim_set_keymap(
        'n',
        '<leader>E',
        ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
        {
          noremap = true,
          desc = 'Open explorer with current buffer path',
        }
      )
      require('telescope').load_extension 'file_browser'
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
