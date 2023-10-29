-- Imports
local nmap = require("zfg.binds").nmap
local cmd = require("zfg.binds").cmd

-- Shortcuts

nmap { '<leader>m', function() cmd(":MarkdownPreviewToggle") end }


