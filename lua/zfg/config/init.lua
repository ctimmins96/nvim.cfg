require('zfg.config.pear')
require('zfg.config.colors')
require('zfg.config.lsp-zero')
require('zfg.config.tabline')
require('zfg.config.telescope')
require('zfg.config.harpoon')
require('zfg.config.treesitter')
require('zfg.config.undotree')
require('zfg.config.lualine')
require('zfg.config.snip')
require("zfg.config.nvim-tree")

-- Sourcing lsp-zero
-- Imports
local so = require('zfg.binds').so
so("~/.config/nvim/lua/zfg/config/lsp-zero.lua")


