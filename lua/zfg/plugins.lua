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
	use ('nvim-treesitter/nvim-treesitter')
	use ('ThePrimeagen/harpoon')
	use ('ap/vim-css-color')
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-nvim-lsp'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},
			{'L3MON4D3/LuaSnip'},
            {'hrsh7th/cmp-cmdline'},
            {'hrsh7th/nvim-cmp'},
		}
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
    use ('Rigellute/shades-of-purple.vim')
    --config = function()
        --    vim.cmd('colorscheme shades_of_purple')
        --end
    use 'maxmx03/fluoromachine.nvim'
    use {
        'sainnhe/everforest',
        config = function()
            vim.cmd('colorscheme fluoromachine')
        end
    }
    use "steelsojka/pears.nvim"
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
    use "lewis6991/gitsigns.nvim"

    -- Testing Plugins (on my local machine)
    -- use "/mnt/e/lua/fnr.nvim"
end)

