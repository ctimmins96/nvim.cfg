-- LSP Setup
local lsp = require('lsp-zero').preset({})
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

lsp.preset('recommended')

lsp.ensure_installed(servers)

-- Completion Setup

require('cmp_nvim_lsp').setup()


local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

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
        { name = 'buffer', keyword_length = 5 },
    })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()


-- Buffer Remaps
local nmap = require('zfg.binds').nmap

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    nmap { "gd", function() vim.lsp.buf.definition() end, opts }
    nmap { "K", function() vim.lsp.buf.hover() end, opts }
end)

local conf = require('lspconfig')

for k,s in pairs(servers) do
    _ = k
    conf[s].setup{
        capabilities = capabilities
    }
end

lsp.setup()

