-- Imports
local opt = require("zfg.binds").opt
local glb = require("zfg.binds").g

opt.guicursor = { "a:block" }

opt.nu = true
opt.rnu = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.cursorline = true

opt.wrap = false

opt.showtabline = 2
opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true
opt.termguicolors = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50
opt.colorcolumn = "100"

glb.mapleader = " "

