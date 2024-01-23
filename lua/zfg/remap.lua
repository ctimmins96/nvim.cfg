-- Require remap
local nmap =  require('zfg.binds').nmap
local imap =  require('zfg.binds').imap
local xmap =  require('zfg.binds').xmap

-- Leader Remap
vim.g.mapleader = " "

-- Normal Mode Remaps
nmap { "<leader>fv", ":Ex<CR>", "Remap-Netrw_File_View" }
nmap { "<leader>wv", "<C-w>v", "Window-" }
nmap { "<leader>wh", "<C-w>h", "Window-Move_Left" }
nmap { "<leader>wj", "<C-w>j", "Window-Move_Down" }
nmap { "<leader>wk", "<C-w>k", "Window-Move_Up" }
nmap { "<leader>wl", "<C-w>l", "Window-Move_Left" }
nmap { "<leader>we", "<C-w>=" }
nmap { "<leader>wo", "<C-w>o" }

nmap { "<C-S>", ":w<CR>:so<CR>", "Remap-Quick_Save_and_Source" }

nmap { "<leader>y", "\"+y", "Remap-Sys_Clip_Yank" }
nmap { "<leader>Y", "\"+Y", "Remap-Sys_Clip_Yank" }
nmap { "<leader>p", "\"+p", "Remap-Sys_Clip_Paste" }
nmap { "<leader>P", "\"+P", "Remap-Sys_Clip_Paste" }

nmap { "J", "mzJ`z", "Remap-Append_Line_Below" }
nmap { '<C-d>', '<C-d>zz', "Remap-Half_Page_Down" }
nmap { '<C-u>', '<C-u>zz', "Remap-Half_Page_Up" }
nmap { "<C-k>", "<cmd>cnext<CR>zz" }
nmap { "<C-j>", "<cmd>cprev<CR>zz" }
nmap { "<leader>k", "<cmd>lnext<CR>zz" }
nmap { "<leader>j", "<cmd>lprev<CR>zz" }
nmap { "<leader>ec", ":e $MYVIMRC<CR>", "Remap-Edit_vimrc" }
nmap { "<leader>ps", ":PackerSync<CR>", "Remap-Packer_Sync" }

-- Interactive Mode Remaps
imap { ";;", "<Esc>", "Remap-Normal_Mode" }
imap { '<C-s>', '<Esc>:w<CR>i', 'Remap-Quick_Save' }

-- Visual Mode Remaps
xmap { "<leader>p", "\"_dP" }
xmap { "J", ":m '>+1<CR>gv=gv" }
xmap { "K", ":m '<-2<CR>gv=gv" }
xmap { "<leader>y", "\"+y" }

-- Netrw Remaps
local ap = require("zfg.binds").a
ap.nvim_create_autocmd('filetype', {
    pattern = 'netrw',
    desc = 'Better Mappings for Netrw',
    callback = function()
        local bind = function(lhs, rhs, desc)
            nmap { lhs, rhs, {remap = true, buffer = true, desc = "Netrw_Remap-"..desc} }
        end

        bind('fn', '%', "New_File")
        bind('fr', 'R', "Remove_File")
        bind('dn', 'd', "New_Directory")
    end
})

-- Testing Area
local f = require("zfg.binds").func
nmap { "<leader>rs", function() f.setreg("/", "<leader>") end }
nmap { "<leader>rg", function() print(f.getreg("/")) end }

