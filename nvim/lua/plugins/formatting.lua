-- Everything related to source file formatting
return {
    -- For available formatter options see:
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    -- TODO: Change to formatting.nvim
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
        'williamboman/mason.nvim',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local null_ls = require 'null-ls'

        null_ls.setup {
            sources = {
                -- Formatting
                null_ls.builtins.formatting.sql_formatter, -- "sql"
                null_ls.builtins.formatting.jq, -- "json"
                null_ls.builtins.formatting.stylua, -- "lua", "luau"
                null_ls.builtins.formatting.google_java_format, -- "java"
            },
        }
    end,
}
