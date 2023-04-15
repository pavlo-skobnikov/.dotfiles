return {
  -- For available formatter options see:
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup {
        automatic_setup = true,

        ensure_installed = {
          'stylua',
          'jq',
          'google_java_format',
          'prettier',
        },
      }
    end,
  },
}
