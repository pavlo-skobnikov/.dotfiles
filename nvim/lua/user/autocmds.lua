-- Description: This file contains all the autocommands for NeoVim to run on various events.

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = vim.api.nvim_create_augroup('RemoveTrailingWhiteSpaces', { clear = true }),
  pattern = { '*' },
  callback = function()
    if (not vim.bo.readonly
          and vim.fn.expand '%' ~= ''
          and vim.bo.buftype == '') then
      vim.cmd [[%s/\s\+$//e]]
    end
  end,
  desc = 'Remove trailing white spaces on saving for writable buffers',
})

vim.api.nvim_create_autocmd('FocusGained', {
  group = vim.api.nvim_create_augroup('CheckFileForExternalChanges', { clear = true }),
  pattern = { '*' },
  callback = function()
    -- Checks if file was changed while outside of NeoVim
    vim.cmd 'checktime'
  end,
  desc = "Update the file's buffer when there are changes to the file on disk",
})
