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
	use ('nvim-treesitter/playground')
	use ('ThePrimeagen/harpoon')
	use ('vim-airline/vim-airline')
	use ('haystackandroid/vimspectr')
--	config = function()
--		vim.g.vimspectrItalicComment = 'on'
--		vim.cmd('colorscheme vimspectr150-dark')
--	end


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
		}
	}
	use 'mbbill/undotree'
    use 'alacritty/alacritty'
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
end)

