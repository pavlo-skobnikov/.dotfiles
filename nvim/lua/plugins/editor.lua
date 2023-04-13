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
    'tpope/vim-unimpaired',
    dependencies = {
      'tpope/vim-repeat',
    },
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
              ['ad'] = { query = '@block.outer', desc = 'around block definition' },
              ['ii'] = { query = '@call.inner', desc = 'inside invocation' },
              ['aS'] = { query = '@call.outer', desc = 'around statement' },
              ['iC'] = { query = '@class.inner', desc = 'inside class' },
              ['aC'] = { query = '@class.outer', desc = 'around class' },
              ['a/'] = { query = '@comment.outer', desc = 'around comment' },
              ['ic'] = { query = '@conditional.inner', desc = 'inside conditional' },
              ['ac'] = { query = '@conditional.outer', desc = 'around conditional' },
              ['if'] = { query = '@function.inner', desc = 'inside function' },
              ['af'] = { query = '@function.outer', desc = 'around function' },
              ['il'] = { query = '@loop.inner', desc = 'inside loop' },
              ['al'] = { query = '@loop.outer', desc = 'around loop' },
              ['ia'] = { query = '@parameter.inner', desc = 'inside argument' },
              ['aa'] = { query = '@parameter.outer', desc = 'around argument' },
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
              [']f'] = { query = '@function.outer', desc = 'Next function start' },
              [']C'] = { query = '@class.outer', desc = 'Next class' },
              [']c'] = { query = '@conditional.outer', desc = 'Next conditional' },
              [']D'] = { query = '@block.outer', desc = 'Next block definition' },
              [']i'] = { query = '@call.inner', desc = 'Next invocation' },
              [']S'] = { query = '@call.outer', desc = 'Next statement' },
              [']a'] = { query = '@parameter.inner', desc = 'Next argument' },
              [']/'] = { query = '@comment.outer', desc = 'Next comment' },
            },
            goto_previous_start = {
              ['[f'] = { query = '@function.outer', desc = 'Previous function start' },
              ['[C'] = { query = '@class.outer', desc = 'Previous class start' },
              ['[c'] = { query = '@conditional.outer', desc = 'Previous conditional' },
              ['[D'] = { query = '@block.outer', desc = 'Previous block definition' },
              ['[i'] = { query = '@call.inner', desc = 'Previous invocation' },
              ['[S'] = { query = '@call.outer', desc = 'Previous statement' },
              ['[a'] = { query = '@parameter.inner', desc = 'Previous argument' },
              ['[/'] = { query = '@comment.outer', desc = 'Next comment' },
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
          extended_mode = true,  -- Also highlight non-bracket delimiters like html tags,
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
        vim.keymap.set({ 'n' }, "<leader>/" .. i, function()
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
      vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
    end,
  }
}
