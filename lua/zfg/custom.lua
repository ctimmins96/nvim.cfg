-- Beginning the journey to creating a window-based find and replace
local popup = require("plenary.popup")

-- General Process:
--  Create
--  Create Window

local custom = {}

function custom.fnr_init(opt)
    -- Create Buffer
    --  Register OnLeave Autocommands to teardown properly
    --  Next (What I've been looking for): vim.api.nvim_buf_attach()
    --  
    -- Create Window
    -- load

    local f = nil
end

return custom
