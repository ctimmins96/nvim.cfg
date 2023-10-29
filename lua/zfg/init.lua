require("zfg.remap")
require("zfg.plugins")
require("zfg.options")
require("zfg.auto")
require("zfg.binds")
require("zfg.config")
require("zfg.globals")
local old = [[
-- Above import is not working. Doing this instead
-- Imports
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

local imports = "Loaded:"

for i,plug in pairs(plugins) do
    _ = i
    if not pcall(require, 'zfg.config.'..plug) then
        print('Failed to load '..plug)
    else
        imports = imports.." "..plug
    end
end

print(imports)
]]



