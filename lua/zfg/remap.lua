-- Require remap
local nmap =  require('zfg.binds').nmap
local imap =  require('zfg.binds').imap
local xmap =  require('zfg.binds').xmap
local ismap = require('zfg.binds').ismap

-- Leader Remap
vim.g.mapleader = " "

-- Normal Mode Remaps
nmap { "<leader>fv", ":Ex<CR>" }
nmap { "<leader>wv", "<C-w>v" }
nmap { "<leader>wh", "<C-w>h" }
nmap { "<leader>wj", "<C-w>j" }
nmap { "<leader>wk", "<C-w>k" }
nmap { "<leader>wl", "<C-w>l" }
nmap { "<leader>we", "<C-w>=" }
nmap { "<leader>wo", "<C-w>o" }

nmap { "<C-S>", ":w<CR>:so<CR>"}

nmap { "<leader>y", "\"+y" }
nmap { "<leader>Y", "\"+Y" }
nmap { "<leader>p", "\"+p" }
nmap { "<leader>P", "\"+P" }

nmap { "J", "mzJ`z" }
nmap { '<C-d>', '<C-d>zz' }
nmap { '<C-u>', '<C-u>zz' }
nmap { "<C-k>", "<cmd>cnext<CR>zz" }
nmap { "<C-j>", "<cmd>cprev<CR>zz" }
nmap { "<leader>k", "<cmd>lnext<CR>zz" }
nmap { "<leader>j", "<cmd>lprev<CR>zz" }
nmap { "<leader>ec", ":e $MYVIMRC<CR>" }
nmap { "<leader>ps", ":PackerSync<CR>" }

-- LSP reload bandaid
nmap { "<leader>lsp", ":so ~/.config/nvim/lua/zfg/config/lsp-zero.lua<CR>" }

-- Interactive Mode Remaps
imap { ";;", "<Esc>" }
imap { '<C-s>', '<Esc>:w<CR>i' }

-- Snippet Remaps
local ls = require('luasnip')

local opt = { silent = true }

imap { "<C-h>", function() ls.expand() end, opt }
ismap { '<C-j>', function() ls.jump(1) end, opt   }
ismap { '<C-k>', function() ls.jump(-1) end, opt  }
ismap { '<C-l>', function()
    if ls.choice_active then
        ls.change_choice(1)
    end
end, opt}

-- Visual Mode Remaps
xmap { "<leader>p", "\"_dP" }
xmap { "J", ":m '>+1<CR>gv=gv" }
xmap { "K", ":m '<-2<CR>gv=gv" }
xmap { "<leader>y", "\"+y" }

-- Netrw Remaps

vim.api.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    desc = 'Better Mappings for Netrw',
    callback = function()
        local bind = function(lhs, rhs)
            nmap { lhs, rhs, {remap = true, buffer = true} }
        end

        bind('fn', '%')
        bind('fr', 'R')
        bind('dn', 'd')
    end
})
