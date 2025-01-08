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
    'bashls',
    'lua_ls'
}
lsp.preset('recommended')
lsp.ensure_installed(servers)

-- Completion Setup
require('cmp_nvim_lsp').setup()
-- Buffer Remaps
local nmap = require('zfg.binds').nmap

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    nmap { "gd", function() vim.lsp.buf.definition() end, opts }
    nmap { "K", function() vim.lsp.buf.hover() end, opts }
end)


lsp.setup()

