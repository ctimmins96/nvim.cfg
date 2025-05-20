require('nvim-treesitter.configs').setup {
    ensure_installed = { 'python', 'haskell', 'rust', 'cpp', 'csharp', 'lua', 'query', 'html', 'javascript', 'vim', 'vimdoc' },

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}
