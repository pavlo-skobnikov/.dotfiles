return {
    {
        'nvim-treesitter/nvim-treesitter', -- Treesitter plugin itself
        build = ':TSUpdate',
        event = 'BufEnter',
        config = function()
            local configs = require 'nvim-treesitter.configs'

            configs.setup {
                ensure_installed = {
                    -- Required for Treesitter to function parsers
                    'c',
                    'lua',
                    'vim',
                    -- Additional parsers
                    'org', -- for "nvim-orgmode/orgmode
                    'query', -- for "nvim-treesitter/playground"
                    'http',
                    'comment',
                    'markdown',
                    'json',
                    'dockerfile',
                    'yaml',
                    'terraform',
                    'hcl',
                    -- Git parsers
                    'diff',
                    'gitattributes',
                    'gitcommit',
                    'gitignore',
                    -- Language parsers
                    'sql',
                    'java',
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,
                    use_languagetree = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = { 'org' },
                },

                indent = {
                    enable = false,
                },

                incremental_selection = {
                    enable = true,
                },
            }
        end,
    },
    {
        'nvim-treesitter/playground', -- Treesitter playground -> awesome for debugging queries
        dependencies = 'nvim-treesitter/nvim-treesitter',
        cmd = 'TSPlaygroundToggle',
        config = function()
            require('nvim-treesitter.configs').setup()
        end,
    },
}
