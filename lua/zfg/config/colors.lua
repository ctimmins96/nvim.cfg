-- Imports
local cmd = require('zfg.binds').vcmd

function ColorMe(color)
	-- Vimspectr
--    color = color or 'vimspectr180-dark'
--	vim.g.vimspectrItalicComment = 'on'
--	vim.cmd('colorscheme vimspectr150-dark')
    -- Main
--    vim.g.fluoromachine_airline = 1
--    vim.g.airline_theme = 'fluoromachine'
    if color == "fluoromachine" then
        local fm = require("fluoromachine")

        fm.setup{
            glow = true,
            theme = 'fluoromachine', -- themes: fluoromachine, delta, retrowave
        }
    end
    cmd('colorscheme '..color)

    local clr = vim.g.colors_name

    if (clr == "fluoromachine") then
        cmd("hi Search guifg=#282a36 guibg=#8ba7a7")
    end
	-- Custom Colors
    -- - Shades of Purple
    --vim.cmd('hi LineNr guifg=#37dd21 guibg=#28284e')
    --vim.api.nvim_set_hl(0, 'Comment', { italic=true })
    --vim.cmd('hi Comment guifg=#b362ff guibg=NONE')
end

-- Setup Colorizer
require('colorizer').setup()
ColorMe("fluoromachine")


