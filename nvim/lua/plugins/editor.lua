-- Description: Plugins for blazingly fast code/text editing
return {
  {
    -- Cool surround actions for `cs`, `cS`, and `ds` mappings
    'tpope/vim-surround',
    dependencies = {
      'tpope/vim-repeat',
    },
  },
  {
    -- Useful paired mappings
    'Tummetott/unimpaired.nvim',
    config = function()
      require('unimpaired').setup {
        default_keymaps = true,
        keymaps = {
          previous = {
            mapping = '[a',
            description = 'arglist - Jump to Prev',
            dot_repeat = true,
          },
          next = {
            mapping = ']a',
            description = 'arglist - Jump to Next',
            dot_repeat = true,
          },
          first = {
            mapping = '[A',
            description = 'arglist - Jump to First',
            dot_repeat = false,
          },
          last = {
            mapping = ']A',
            description = 'arglist - Jump to Last',
            dot_repeat = false,
          },
          bprevious = false,
          bnext = false,
          bfirst = false,
          blast = false,
          lprevious = {
            mapping = '[l',
            description = 'loclist - Jump to Prev',
            dot_repeat = true,
          },
          lnext = {
            mapping = ']l',
            description = 'loclist - Jump to Next',
            dot_repeat = true,
          },
          lfirst = {
            mapping = '[L',
            description = 'loclist - Jump to First',
            dot_repeat = false,
          },
          llast = {
            mapping = ']L',
            description = 'loclist - Jump to Last',
            dot_repeat = false,
          },
          lpfile = false,
          lnfile = false,
          cprevious = {
            mapping = '[q',
            description = 'qflist - Jump to Prev',
            dot_repeat = true,
          },
          cnext = {
            mapping = ']q',
            description = 'qflist - Jump to Next',
            dot_repeat = true,
          },
          cfirst = {
            mapping = '[Q',
            description = 'qflist - Jump to First',
            dot_repeat = false,
          },
          clast = {
            mapping = ']Q',
            description = 'qflist - Jump to Last',
            dot_repeat = false,
          },
          cpfile = false,
          cnfile = false,
          tprevious = {
            mapping = '[t',
            description = 'Jump to Prev Matching Tag',
            dot_repeat = true,
          },
          tnext = {
            mapping = ']t',
            description = 'Jump to Next Matching Tag',
            dot_repeat = true,
          },
          tfirst = {
            mapping = '[T',
            description = 'Jump to First Matching Tag',
            dot_repeat = false,
          },
          tlast = {
            mapping = ']T',
            description = 'Jump to Last Matching Tag',
            dot_repeat = false,
          },
          ptprevious = {
            mapping = '[<C-t>',
            description = ':tprevious in the Preview Window',
            dot_repeat = true,
          },
          ptnext = {
            mapping = ']<C-t>',
            description = ':tnext in the Preview Window',
            dot_repeat = true,
          },
          previous_file = false,
          next_file = false,
          blank_above = {
            mapping = '[<Space>',
            description = 'Add Blank Line(s) Above',
            dot_repeat = true,
          },
          blank_below = {
            mapping = ']<Space>',
            description = 'Add Blank Line(s) Below',
            dot_repeat = true,
          },
          exchange_above = {
            mapping = '[e',
            description = 'Exchange Line(s) with Above',
            dot_repeat = true,
          },
          exchange_below = {
            mapping = ']e',
            description = 'Exchange Line(s) with Below',
            dot_repeat = true,
          },
          exchange_section_above = {
            mapping = '[e',
            description = 'Move Section Up',
            dot_repeat = true,
          },
          exchange_section_below = {
            mapping = ']e',
            description = 'Move Section Down',
            dot_repeat = true,
          },
          enable_cursorline = false,
          disable_cursorline = false,
          toggle_cursorline = {
            mapping = '<leader>TC',
            description = 'Toggle cursorline',
            dot_repeat = true,
          },
          enable_diff = false,
          disable_diff = false,
          toggle_diff = {
            mapping = '<leader>TD',
            description = 'Toggle diffthis',
            dot_repeat = true,
          },
          enable_hlsearch = false,
          disable_hlsearch = false,
          toggle_hlsearch = {
            mapping = '<leader>Th',
            description = 'Toggle hlsearch',
            dot_repeat = true,
          },
          enable_ignorecase = false,
          disable_ignorecase = false,
          toggle_ignorecase = {
            mapping = '<leader>Ti',
            description = 'Toggle ignorecase',
            dot_repeat = true,
          },
          enable_list = false,
          disable_list = false,
          toggle_list = {
            mapping = '<leader>Tl',
            description = 'Toggle listchars',
            dot_repeat = true,
          },
          enable_number = false,
          disable_number = false,
          toggle_number = {
            mapping = '<leader>Tn',
            description = 'Toggle Line Numbers',
            dot_repeat = true,
          },
          enable_relativenumber = false,
          disable_relativenumber = false,
          toggle_relativenumber = {
            mapping = '<leader>Tr',
            description = 'Toggle Relative Numbers',
            dot_repeat = true,
          },
          enable_spell = false,
          disable_spell = false,
          toggle_spell = {
            mapping = '<leader>Ts',
            description = 'Toggle Spell Check',
            dot_repeat = true,
          },
          enable_background = false,
          disable_background = false,
          toggle_background = false,
          enable_colorcolumn = false,
          disable_colorcolumn = false,
          toggle_colorcolumn = {
            mapping = '<leader>TU',
            description = 'Toggle colorcolumn',
            dot_repeat = true,
          },
          enable_cursorcolumn = false,
          disable_cursorcolumn = false,
          toggle_cursorcolumn = {
            mapping = '<leader>Tu',
            description = 'Toggle cursorcolumn',
            dot_repeat = true,
          },
          enable_virtualedit = false,
          disable_virtualedit = false,
          toggle_virtualedit = {
            mapping = '<leader>Tv',
            description = 'Toggle virtualedit',
            dot_repeat = true,
          },
          enable_wrap = false,
          disable_wrap = false,
          toggle_wrap = {
            mapping = '<leader>Tw',
            description = 'Toggle Line Wrapping',
            dot_repeat = true,
          },
          enable_cursorcross = false,
          disable_cursorcross = false,
          toggle_cursorcross = {
            mapping = '<leader>Tx',
            description = 'Toggle cursorcross',
            dot_repeat = true,
          },
        },
      }
    end,
  },
  {
    -- Add color boxes on various color codes in code (hex, rgb, etc.)
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()

      vim.keymap.set('n', '<leader>Tc', ':ColorizerToggle<CR>', { desc = 'Toggle Colorizer' })
    end,
  },
  {
    -- A powerful character autopair plugin
    'windwp/nvim-autopairs',
    config = true,
  },
  {
    -- Comment shenanigans
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    -- Movements, selections, and swapping with Treesitter objects
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            -- Enable textobj selection
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            -- Capture groups defined in textobjects.scm are available for bindings
            keymaps = {
              ['ad'] = { query = '@block.outer', desc = 'Around Block Definition' },
              ['ii'] = { query = '@call.inner', desc = 'Inside Invocation' },
              ['aS'] = { query = '@call.outer', desc = 'Around Statement' },
              ['iC'] = { query = '@class.inner', desc = 'Inside Class' },
              ['aC'] = { query = '@class.outer', desc = 'Around Class' },
              ['a/'] = { query = '@comment.outer', desc = 'Around Comment' },
              ['ic'] = { query = '@conditional.inner', desc = 'Inside Conditional' },
              ['ac'] = { query = '@conditional.outer', desc = 'Around Conditional' },
              ['if'] = { query = '@function.inner', desc = 'Inside Function' },
              ['af'] = { query = '@function.outer', desc = 'Around Function' },
              ['il'] = { query = '@loop.inner', desc = 'Inside Loop' },
              ['al'] = { query = '@loop.outer', desc = 'Around Loop' },
              ['ia'] = { query = '@parameter.inner', desc = 'Inside Argument' },
              ['aa'] = { query = '@parameter.outer', desc = 'Around Argument' },
            },
          },
          swap = {
            -- Enable textobj swap
            enable = true,
            -- Capture groups defined in textobjects.scm are available for bindings
            swap_next = {
              [']s'] = { query = '@swappable', desc = 'Swap with Next' },
            },
            swap_previous = {
              ['[s'] = { query = '@swappable', desc = 'Swap with Prev' },
            },
          },
          move = {
            -- Enable textobj move
            enable = true,
            -- Whether to set jumps in the jumplist
            set_jumps = true,
            goto_next_start = {
              [']f'] = { query = '@function.outer', desc = 'Next Function Start' },
              [']C'] = { query = '@class.outer', desc = 'Next Class' },
              [']c'] = { query = '@conditional.outer', desc = 'Next Conditional' },
              [']D'] = { query = '@block.outer', desc = 'Next Block Definition' },
              [']i'] = { query = '@call.inner', desc = 'Next Invocation' },
              [']S'] = { query = '@call.outer', desc = 'Next Statement' },
              [']a'] = { query = '@parameter.inner', desc = 'Next Argument' },
              [']/'] = { query = '@comment.outer', desc = 'Next Comment' },
            },
            goto_previous_start = {
              ['[f'] = { query = '@function.outer', desc = 'Prev Function Start' },
              ['[C'] = { query = '@class.outer', desc = 'Prev Class Start' },
              ['[c'] = { query = '@conditional.outer', desc = 'Prev Conditional' },
              ['[D'] = { query = '@block.outer', desc = 'Prev Block Definition' },
              ['[i'] = { query = '@call.inner', desc = 'Prev Invocation' },
              ['[S'] = { query = '@call.outer', desc = 'Prev Statement' },
              ['[a'] = { query = '@parameter.inner', desc = 'Prev Argument' },
              ['[/'] = { query = '@comment.outer', desc = 'Prev Comment' },
            },
          },
        },
      }

      local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

      -- Repeat movement with ; and , vim way -> goes to the direction you were moving
      vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
      vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

      -- Make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
      vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
      vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
      vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end,
  },
  {
    -- Colorize brackets according to their depth
    'mrjones2014/nvim-ts-rainbow',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags,
          -- boolean or table: lang -> boolean
          max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
        },
      }
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    config = function()
      local spectre = require 'spectre'

      vim.keymap.set({ 'n' }, '<leader>rp', function()
        spectre.open()
      end, { silent = true, desc = 'Search and Replace in Project' })
      vim.keymap.set({ 'n' }, '<leader>rf', function()
        spectre.open_file_search()
      end, { silent = true, desc = 'Search and Replace in File' })

      vim.keymap.set({ 'n' }, '<leader>rw', function()
        spectre.open_visual { select_word = true }
      end, { silent = true, desc = 'Search Word and Replace' })
      vim.keymap.set({ 'v' }, '<leader>rs', function()
        spectre.open_visual()
      end, { silent = true, desc = 'Search Selection and Replace' })

      require('spectre').setup()
    end,
  },
  {
    'ThePrimeagen/harpoon',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('telescope').load_extension 'harpoon'

      local mark = require 'harpoon.mark'
      local ui = require 'harpoon.ui'
      local term = require 'harpoon.term'
      local cmd_ui = require 'harpoon.cmd-ui'

      vim.keymap.set({ 'n' }, '<leader>a', mark.add_file, { silent = true, desc = 'Add to Marks' })
      vim.keymap.set(
        { 'n' },
        '<leader>b',
        ui.toggle_quick_menu,
        { silent = true, desc = 'View Buffer Marks' }
      )

      for i = 1, 9, 1 do
        vim.keymap.set({ 'n' }, '<leader>m' .. i, function()
          ui.nav_file(i)
        end, { silent = true, desc = 'Go to Buffer Mark ' .. i })
      end

      vim.keymap.set({ 'n' }, ']h', ui.nav_next, { silent = true, desc = 'Next Harpoon Mark' })
      vim.keymap.set({ 'n' }, '[h', ui.nav_prev, { silent = true, desc = 'Prev Harpoon Mark' })

      for i = 1, 9, 1 do
        vim.keymap.set({ 'n' }, '<leader>/' .. i, function()
          term.gotoTerminal(i)
        end, { silent = true, desc = 'Go to Terminal ' .. i })
      end

      vim.keymap.set(
        { 'n' },
        '<leader>c',
        cmd_ui.toggle_quick_menu,
        { silent = true, desc = 'View Commands Menu' }
      )
      vim.keymap.set({ 'n' }, '<leader>!', function()
        local terminal_id = vim.fn.input 'Terminal ID > '
        local command = vim.fn.input 'Shell Command > '

        term.sendCommand(terminal_id, command)
      end, { silent = true, desc = 'Send Shell Command to Given Terminal' })
    end,
  },
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
}
