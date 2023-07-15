-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Modes -> for reference
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Remove highlights on <ESC>
vim.keymap.set('n', '<ESC>', ':noh<CR>', { silent = true, noremap = true })
