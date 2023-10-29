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

-- Load snippets into completion engine
require'cmp'.setup {
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
        },
    sources = {
        { name = 'luasnip', option = { show_autosnippets = true } },
    },
}


