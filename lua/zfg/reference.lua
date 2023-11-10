--- Imports
local api = require("zfg.binds").a

--- Main

-- Get the keybinds and open a buffer to store them in.
local kmap = {
    normal = api.nvim_get_keymap("n"),
    insert = api.nvim_get_keymap("i"),
    visual = api.nvim_get_keymap("v"),
}

local pairs = { normal = {}, insert = {}, visual = {}}

-- Iterate on Normal-mode mappings

for _, kmp in ipairs(kmap.normal) do
    -- Test
end


P(kmap)

