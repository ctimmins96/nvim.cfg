-- Imports
local nmap = require("zfg.binds").nmap
local fn = require("zfg.binds").func

nmap { '<leader>u', fn.UndotreeToggle, "Undotree-Toggle" }
