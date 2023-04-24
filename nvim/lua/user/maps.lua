local function options(description)
  if description == nil then
    return { silent = true, noremap = false }
  else
    return { silent = true, noremap = false, desc = description }
  end
end

-- Shorten key mapping function name
local map = vim.keymap.set

--Remap space as leader key
-- map("", "<Space>", "<Nop>", options())
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes -> for reference
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal
-- Executing `x` on texts throws it into the void register
map('n', 'x', '"_x', options())
map('n', 'x', '"_x', options())

-- Remove highlights on <ESC>
map('n', '<ESC>', ':noh<CR>', options())

-- Better window navigation
map('n', '<C-h>', '<C-w>h', options())
map('n', '<C-j>', '<C-w>j', options())
map('n', '<C-k>', '<C-w>k', options())
map('n', '<C-l>', '<C-w>l', options())

-- Resize with arrows
vim.cmd [[ nnoremap <A-=> :res -2<CR> ]]
vim.cmd [[ nnoremap <A--> :res +2<CR> ]]
vim.cmd [[ nnoremap <A-.> :vertical res -2<CR> ]]
vim.cmd [[ nnoremap <A-,> :vertical res +2<CR> ]]

-- Easy window navigation
for i = 1, 9 do
  local left_hand_side = '<leader>' .. i
  local right_hand_side = i .. '<C-w>w'

  map('n', left_hand_side, right_hand_side, options('Move to window ' .. i))
end

-- netrw access
map('n', '<leader>E', ':Lexplore %:p:h<CR>', options())
map('n', '<leader>e', ':Lexplore <CR>', options())
map('n', 'gT', ':Rexplore <CR>', options())
