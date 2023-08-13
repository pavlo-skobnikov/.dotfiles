return {
    'catppuccin/nvim',
    config = function()
        -- Options: latte, frappe, macchiato, mocha
        require('catppuccin').setup { flavour = 'frappe' }

        vim.cmd [[ colorscheme catppuccin ]]
    end,
}
