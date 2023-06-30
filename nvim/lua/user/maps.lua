-- Shorten key mapping function name
local map = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

-- Modes -> for reference
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Remove highlights on <ESC>
map('n', '<ESC>', ':noh<CR>', { silent = true, noremap = true })

-- Open Chrome for selected link
local function get_visual_selection()
  -- Yank current visual selection into the 'v' register
  -- NOTE: that this makes no effort to preserve this register
  vim.cmd 'noau normal! "vy"'

  return vim.fn.getreg 'v'
end

map('v', '<leader>o', function()
  local selection = get_visual_selection()

  local command = "!open '/Applications/Google Chrome.app' '" .. selection .. "'"

  vim.cmd(command)
end, { silent = true, noremap = false, description = 'Open Selected Link' })
