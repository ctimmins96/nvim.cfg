-- LSP Setup
local lsp = require('lsp-zero').preset({})
local servers = {
    'clangd',
    'hls',
    'ltex',
    'marksman',
    'jedi_language_server',
    'yamlls',
    'bashls',
    'lua_ls'
}
lsp.preset('recommended')
lsp.ensure_installed(servers)

-- Completion Setup
require('cmp_nvim_lsp').setup()

lsp.setup()

