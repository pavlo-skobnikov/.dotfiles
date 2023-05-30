return {
  {
    -- An interactive environment for evaluating code within a running program
    'Olical/conjure',
    dependencies = {
      {
        -- Run commands in background
        'tpope/vim-dispatch',
      },
      {
        -- Jack in to Boot, Clj & Leiningen from Vim
        'clojure-vim/vim-jack-in',
      },
    },
  },
}
