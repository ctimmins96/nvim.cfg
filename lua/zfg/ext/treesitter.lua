require('nvim-treesitter.configs').setup {
    ensure_installed = { 'python', 'haskell', 'rust', 'cpp', 'lua', 'query', 'html', 'javascript', 'vim', 'vimdoc', 'c_sharp' },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
