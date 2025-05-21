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

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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

                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayhint) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })
        end
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
            require'cmp'.setup {
                snippet = {
                    expand = function(args)
                        require'luasnip'.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'luasnip' },
                },
            }
        end
    }

    use 'BurntSushi/ripgrep'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons'}
    }

    use 'christoomey/vim-tmux-navigator'
    use 'maxmx03/fluoromachine.nvim'
    use {
        'sainnhe/everforest',
        config = function()
            vim.cmd('colorscheme fluoromachine')
        end
    }
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
        config = function()
            --require("startup").setup(require"config.startup_nvim")
            require("startup").setup({theme="evil"})
        end,
    }
    use "nvim-tree/nvim-tree.lua"

    -- Testing Plugins (on my local machine)
    -- use "/mnt/e/lua/fnr.nvim"
end)

