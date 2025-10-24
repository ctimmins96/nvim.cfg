-- Plugins
--

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' },
                    { 'BurntSushi/ripgrep' } }
	}
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
    }
	use 'ThePrimeagen/harpoon'
	use 'ap/vim-css-color'
    use {
        'neovim/nvim-lspconfig',
        requires =
        {
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        },
        config = function()
            local builtin = require 'telescope.builtin'
            local nmap = require 'zfg.binds'.nmap

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('zfg-lsp-attach', {clear = true}),
                callback = function(event)
                    -- Helper Functions
                    local map = function(keys, func, desc)
                        nmap { keys, func, { buffer = event.buf, desc = "LSP: " .. desc }}
                    end

                    -- Maps
                    map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
                    map("gr", builtin.lsp_references, "[G]oto [R]eferences")
                    map("gI", builtin.lsp_implementations, "[G]oto [I]mplementations")
                    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                    --@param client vim.lsp.Client
                    --@param method vim.lsp.protocol.Method
                    --@param bufnr? integer
                    --@return boolean
                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has 'nvim-0.11' == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_augroup = vim.api.nvim_create_augroup('zfg-lsp-highlight', {clear = false})
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('zfg-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds {group = 'zfg-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayhint) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local servers = {
                clangd = {},
                rust_analyzer = {},
                csharp_ls = {},
                jedi_language_server = {},
                marksman = {},
                lua_ls = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        }
                    }
                },
            }

            local ensure_installed = vim.tbl_keys {servers or { }}
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }
            require('mason-lspconfig').setup {
                ensure_installed = {},       -- Autopopulated by the line above
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        vim.lsp.config[server_name].setup(server)
                    end,
                },
            }
        end,
    }
	use 'mbbill/undotree'
    use ({
        'L3MON4D3/LuaSnip',
        tag = 'v2.*',
        run = 'make install_jsregexp'
    })
    use {
        'hrsh7th/nvim-cmp',
        config = function ()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation =  cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.abort(),
                    ['<C-Tab>'] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end
    }

    use 'BurntSushi/ripgrep'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons'}
    }

    use 'christoomey/vim-tmux-navigator'
    use 'maxmx03/fluoromachine.nvim'
    use 'sainnhe/everforest'
    use "crispgm/nvim-tabline"
    use "norcalli/nvim-colorizer.lua"
    use "tpope/vim-fugitive"
    use ({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use {
        "startup-nvim/startup.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    }
    use "nvim-tree/nvim-tree.lua"

    use {
        'Saghen/blink.cmp',
        event = 'VimEnter',
        dependencies = {
            -- LuaSnip / Snippet engine
            'L3MON4D3/LuaSnip',
            opts = {},
        },
        opts = {
            keymap = {
                preset = 'default'
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
            },
        },
    }

    -- Testing Plugins (on my local machine)
    -- use "/mnt/e/lua/fnr.nvim"
end)


