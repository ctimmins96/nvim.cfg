-- LSP Setup
local lsp = require('lsp-zero').preset({})
local servers = {
    'clangd',
    'hls',
    'ltex',
    'marksman',
    'jedi_language_server',
    'yamlls',
    'ts_ls',
    'lua_ls'
}
lsp.preset('recommended')
lsp.ensure_installed(servers)

-- Completion Setup
require('cmp_nvim_lsp').setup()

lsp.setup()

