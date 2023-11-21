return {
    {
        'tpope/vim-sexp-mappings-for-regular-people', -- S-expression editing remapped
        dependencies = {
            'tpope/vim-surround', -- Cool surround actions for `cs`, `cS`, and `ds` mappings
            'tpope/vim-repeat', -- Repeat plugin maps
            'guns/vim-sexp', -- The Vim philosophy of precision editing for S-expressions
        },
        config = function()
            -- Extend `vim-sexp` to more filetypes
            vim.g.sexp_filetypes = 'clojure,scheme,lisp,timl,fennel,janet'
        end,
    },
    { 'windwp/nvim-autopairs', config = true }, -- Auto-create pair characters when typing
    { 'numToStr/Comment.nvim', config = true }, -- Selection- && motion-based commenting
    {
        'mbbill/undotree', -- A detailed undo history for files
        dependencies = 'folke/which-key.nvim',
        config = function()
            RegisterWK({
                u = { ':UndotreeToggle<CR>', 'Toggle [U]ndotree' },
            }, { prefix = '<LEADER>' })
        end,
    },
    {
        'Tummetott/unimpaired.nvim', -- Useful && comfy mappings for basic Vim commands
        config = function()
            local function mkOpts(mapping, desc)
                return {
                    mapping = mapping,
                    description = desc,
                    dot_repeat = true,
                }
            end

            require('unimpaired').setup {
                keymaps = {
                    previous = false,
                    next = false,
                    first = false,
                    last = false,
                    bprevious = mkOpts('[b', '[b]uffer'),
                    bnext = mkOpts(']b', '[b]uffer'),
                    bfirst = mkOpts('[B', 'First [b]uffer'),
                    blast = mkOpts(']B', 'Last [b]uffer'),
                    lprevious = mkOpts('[l', '[l]oclist'),
                    lnext = mkOpts(']l', '[l]oclist'),
                    lfirst = mkOpts('[L', 'First [l]oclist'),
                    llast = mkOpts(']L', 'Last [l]oclist'),
                    lpfile = mkOpts('[<C-l>', '[l]oclist file'),
                    lnfile = mkOpts(']<C-l>', '[l]oclist file'),
                    cprevious = mkOpts('[q', '[q]flist'),
                    cnext = mkOpts(']q', '[q]flist'),
                    cfirst = mkOpts('[Q', 'First [q]flist'),
                    clast = mkOpts(']Q', 'Last [q]flist'),
                    cpfile = mkOpts('[<C-q>', '[q]flist file'),
                    cnfile = mkOpts(']<C-q>', '[q]flist file'),
                    tprevious = mkOpts('[t', 'Matching [t]ag'),
                    tnext = mkOpts(']t', 'Matching [t]ag'),
                    tfirst = mkOpts('[T', 'First matching [t]ag'),
                    tlast = mkOpts(']T', 'Last matching [t]ag'),
                    ptprevious = mkOpts('[<C-t>', ':[t]previous in preview'),
                    ptnext = mkOpts(']<C-t>', ':[t]next in preview'),
                    previous_file = mkOpts('[<C-f>', 'Directory [f]ile'),
                    next_file = mkOpts(']<C-f>', 'Directory [f]ile'),
                    blank_above = mkOpts('[<space>', 'Add blank line(s) above'),
                    blank_below = mkOpts(']<space>', 'Add blank line(s) below'),
                    exchange_above = mkOpts('[e', '[E]xchange above line(s)'),
                    exchange_below = mkOpts(']e', '[E]xchange below line(s)'),
                    exchange_section_above = mkOpts('[E', 'Move s[E]ction up'),
                    exchange_section_below = mkOpts(']E', 'Move s[E]ction down'),
                    enable_cursorline = false,
                    disable_cursorline = false,
                    toggle_cursorline = mkOpts('<leader>tC', '[c]ursorline'),
                    enable_diff = false,
                    disable_diff = false,
                    toggle_diff = mkOpts('<leader>tD', '[d]iffthis'),
                    enable_hlsearch = false,
                    disable_hlsearch = false,
                    toggle_hlsearch = mkOpts('<leader>th', '[h]lsearch'),
                    enable_ignorecase = false,
                    disable_ignorecase = false,
                    toggle_ignorecase = mkOpts('<leader>ti', '[i]gnorecase'),
                    enable_list = false,
                    disable_list = false,
                    toggle_list = mkOpts('<leader>tl', '[l]istchars'),
                    enable_number = false,
                    disable_number = false,
                    toggle_number = mkOpts('<leader>tn', 'Line [n]umbers'),
                    enable_relativenumber = false,
                    disable_relativenumber = false,
                    toggle_relativenumber = mkOpts('<leader>tr', '[R]elative numbers'),
                    enable_spell = false,
                    disable_spell = false,
                    toggle_spell = mkOpts('<leader>ts', '[S]pell check'),
                    enable_background = false,
                    disable_background = false,
                    toggle_background = false,
                    enable_colorcolumn = false,
                    disable_colorcolumn = false,
                    toggle_colorcolumn = mkOpts('<leader>tU', 'colorcol[u]mn'),
                    enable_cursorcolumn = false,
                    disable_cursorcolumn = false,
                    toggle_cursorcolumn = mkOpts('<leader>tu', 'c[u]rsorcolumn'),
                    enable_virtualedit = false,
                    disable_virtualedit = false,
                    toggle_virtualedit = mkOpts('<leader>tv', '[v]irtualedit'),
                    enable_wrap = false,
                    disable_wrap = false,
                    toggle_wrap = mkOpts('<leader>tw', 'Line [w]rapping'),
                    enable_cursorcross = false,
                    disable_cursorcross = false,
                    toggle_cursorcross = mkOpts('<leader>tx', 'cursorcross ([x])'),
                },
            }

            RegisterWK {
                ['<LEADER>t'] = { name = 'toggle' },
            }
        end,
    },
    {
        'stevearc/oil.nvim', -- Vim buffer-like editing for the file system
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('oil').setup {
                view_options = {
                    show_hidden = true,
                },
            }

            RegisterWK {
                ['-'] = { '<CMD>Oil<CR>', 'Open parent directory' },
            }
        end,
    },
    {
        'christoomey/vim-tmux-navigator', -- Seamlessly navigate Vim and Tmux splits
        config = function()
            vim.cmd [[
                    let g:tmux_navigator_no_mappings = 1
                    let g:tmux_navigator_save_on_switch = 2

                ]]

            RegisterWK({
                ['<C-h>'] = { ':<C-U>TmuxNavigateLeft<cr>', 'Move a split left' },
                ['<C-j>'] = { ':<C-U>TmuxNavigateDown<cr>', 'Move a split down' },
                ['<C-k>'] = { ':<C-U>TmuxNavigateUp<cr>', 'Move a split up' },
                ['<C-l>'] = { ':<C-U>TmuxNavigateRight<cr>', 'Move a split right' },
                ['<C-\\>'] = { ':<C-U>TmuxNavigatePrevious<cr>', 'Move to the previous split' },
            }, { mode = { 'n', 'x', 'o' } })
        end,
    },
    {
        'catppuccin/nvim', -- Colorscheme, duh
        config = function()
            require('catppuccin').setup { flavour = 'frappe' }

            vim.cmd [[ colorscheme catppuccin ]]
        end,
    },
    { 'folke/which-key.nvim' }, -- _The_ shortcut popup menu plugin
}
