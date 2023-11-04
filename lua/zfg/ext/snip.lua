-- Import Snippets
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/"})

-- Configuration
require("luasnip").config.set_config({
    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Keep that last snippet in buffer
    history = true,

    -- Use <Tab> to trigger visual selection
    store_selection_keys = '<C-Tab>',

    -- Change Updated events for repeated nodes
    update_events = "TextChanged,TextChangedI",
})



