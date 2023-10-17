-- This configuration file contains all the autocommands for NeoVim to run on various events.

vim.api.nvim_create_autocmd('FocusGained', {
    group = vim.api.nvim_create_augroup('CheckFileForExternalChanges', { clear = true }),
    pattern = { '*' },
    callback = function()
        -- Checks if file was changed while outside of NeoVim
        vim.cmd 'checktime'
    end,
    desc = "Update the file's buffer when there are changes to the file on disk",
})

local function get_git_branch()
    local result = vim.fn.system 'git branch --show-current'

    if string.match(result, 'fatal') then
        return 'no git'
    end

    return vim.fn.trim(result)
end

local function set_statusline()
    vim.opt.statusline = '%f  %r%m%=%y  (' .. get_git_branch() .. ')    %l,%c    %P'
end

vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('UpdateCurrentGitBranch', { clear = true }),
    pattern = { '*' },
    callback = function()
        -- Gets the current git branch and sets it to the buffer variable
        vim.cmd [[let b:git_branch = trim(system('git branch --show-current'))]]
        -- Set the statusline only once
        set_statusline()
    end,
    desc = "Update the file's buffer when there are changes to the file on disk",
})
