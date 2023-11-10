-- Snippet Abbreviations
local ls = require('luasnip')
local t = ls.text_node
local i = ls.insert_node
-- Functions

-- Snippets
return {
    ls.snippet(
        { trig = 'luatmp' },
        {
            t("#!/usr/bin/lua"),
            t("--[["),
            i(1),
        }
    )
}
