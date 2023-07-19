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
}
