-- Imports
require('zfg.binds')

local prnt = require('zfg.binds').msg

-- Source Files
local plugins = {
    'pear',
    'harpoon',
    'lsp-zero',
    'treesitter',
    'undotree',
    'colors',
    'lualine',
    'snip',
    'tabline',
    'telescope',
    'tmux'
}

for i,plug in pairs(plugins) do
    _ = i
    if not pcall(require, 'zfg.config.'..plug) then
        prnt('Failed to load '..plug)
    else
        prnt("Loaded \"zfg.config."..plug.."\"")
    end
end

