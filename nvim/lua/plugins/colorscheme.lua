-- Colorscheme for a more civilized age
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
