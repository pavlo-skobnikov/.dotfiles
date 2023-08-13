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

vim.keymap.set('n', '<leader>H', function()
    local word = vim.fn.expand '<cword>'

    vim.fn.matchadd('Search', word)
end, { desc = 'Highlight Word', silent = true, noremap = true })

-- Remove all highlights on <ESC>
vim.keymap.set('n', '<ESC>', function()
    vim.cmd ':noh'
    vim.cmd ':call clearmatches()'
    vim.lsp.buf.clear_references()
end, { silent = true, noremap = true })
