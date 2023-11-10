-- Imports
local cmp = require("cmp")

-- Setup
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mappings = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
    })
})

local caps = require("cmp_nvim_lsp").default_capabilities()
local servers = {
    'clangd',
    'hls',
    'ltex',
    'marksman',
    'jedi_language_server',
    'yamlls',
    'tsserver',
    'bashls',
    'lua_ls'
}

local conf = require('lspconfig')
for k,s in pairs(servers) do
    _ = k
    conf[s].setup{
        capabilities = caps
    }
end

