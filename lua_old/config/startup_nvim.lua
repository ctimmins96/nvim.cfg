-- Imports
local header = require("startup.headers").hydra_header

-- Functions
local function map_str(title, bind)
    local str_len = 30

    local space_buf = ""
    for _ = 1,(str_len - (string.len(title) + string.len(bind))) do
        space_buf = space_buf.." "
    end

    return "> "..title..space_buf..bind
end

-- Constants


-- Module Setup
local settings = {
    header = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        margin = 5,
        title = "Header",
        content = header,
        highlight = "Statement",
        default_color = "",
        oldfiles_amount = 0,
    },
    body = {
        type = "text",
        oldfiles_directory = false,
        align = "center",
        fold_section = true,
        title = "Commands",
        margin = 5,
        content = map_str("Find Files", "<leader>sf"),
        oldfiles_amount = 0,
    },
    body_2 = {
        type = "oldfiles",
        oldfiles_directory = false,
        align = "center",
        fold_section = true,
        title = "Oldfiles",
        margin = 5,
        content = {},
        highlight = "TSString",
        default_color = "",
        oldfiles_amount = 5,
    },
    footer = {
        type = "text",
        content = require("startup.functions").packer_plugins(),
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "Plugins",
        margin = 5,
        highlight = "TSString",
        oldfiles_amount = 10,
    },
    clock = {
        type = "text",
        content = function()
            local clock = " " .. os.date("%H:%M")
            local date =  "󰃭 " .. os.date("%d-%m-%y")
            return { clock, date }
        end,
        oldfiles_directory = false,
        align = "center",
        fold_section = false,
        title = "",
        margin = 5,
        highlight = "TSString",
        oldfiles_amount = 10,
    },
    options = {
        mapping_keys = false,
    },
    parts = {
        "header",
        "body",
        "body_2",
        "footer",
        "clock",
    },
}


return settings

