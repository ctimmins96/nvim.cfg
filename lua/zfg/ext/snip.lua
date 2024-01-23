-- Bulk Imports
local ls = require("luasnip")


-- Local Variables
local ex_op = {
    active = { hl_group = "colorizer_mb_808080" },
    visited = { hl_group = "colorizer_mb_112233" },
    unvisited = { hl_group = "colorizer_mb_ffa500" },
}

-- Configuration
ls.config.set_config({
    keep_roots = true,
    link_roots = true,
    link_children = true,

    -- Enable autotriggered snippets
    enable_autosnippets = true,

    -- Keep that last snippet in buffer
    history = true,

    -- Use <Tab> to trigger visual selection
    store_selection_keys = '<C-Tab>',

    -- Change Updated events for repeated nodes
    update_events = "TextChanged,TextChangedI",

    -- Load External options
    ext_opts = ex_op,

    ext_base_prio = 300,
    ext_prio_increase = 1
})

-- -- -- -- Snippets -- -- -- --
-- Shorthand Snippets
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmta
local fmt2 = require('luasnip.extras.fmt').fmt

-- Functions
local function pyfunc_temp(args, _, old_state)
    local nodes = {
        t("")
    }
    local param_nodes = {}
    -- Check old state and update node accordingly
    if old_state then
        nodes[1] = i(1, old_state.descr:get_text())
    end
    -- Update param_nodes
    param_nodes.descr = nodes[1]
    if string.find(args[1][1], ', ') then
        vim.list_extend(nodes, { t({""})})
    end
    -- Handle Arguments
    local insert = 2
    for indx, arg in ipairs(vim.split(args[1][1], ", ", true)) do
        -- Get argument Metadata
        local arg_type
        local arg_def
        local arg_meta
        if string.find(arg, ':') then
            arg_meta = vim.split(arg, ':', true)[2]
            arg = vim.split(arg, ":", true)[1]

            if string.find(arg_meta, '=') then
                -- Parse for default arguments and argument type
                arg_type = vim.split(arg_meta, '=', true)[1]
                arg_def = vim.split(arg_meta, '=', true)[2]
                -- Trim arg_type if there's an extra space
                if string.sub(arg_type, -1, -1) == ' ' then
                    arg_type = string.sub(arg_type, 1, -2)
                end

                if string.sub(arg_def, 1,1) == ' ' then
                    if string.len(arg_def) == 1 then
                        arg_def = 'None'
                    else
                        arg_def = string.sub(arg_def, 2,-1)
                    end
                end
            else
                arg_type = arg_meta
                arg_def = "N/A"
            end
        else
            arg_type = "Any"
            arg_def = "N/A"
        end

        if arg then
            local inode
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(nodes, {t({"        - " .. arg .. " (" .. arg_type .. ") -- Info goes here. Default: " .. arg_def}), inode, t({'', ''})})
            param_nodes["arg"..arg] = inode

            insert = insert + 1
        end
    end

    local snip = sn(nil, nodes)
    snip.old_state = param_nodes
    return snip
end

-- Snippets
-- - All
ls.add_snippets({
    "all", {
        s({
            trig="ternary",
            dscr="Universal-ish Ternary Operator",
            regTrig=false,
            priority=100,
            snippetType="snippet"
        }, {
            i(1, "cond"),
            t(" ? "),
            i(2, "then"),
            t(" : "),
            i(3, "else")
        })
    }
}, {
    key = "all"
})

-- - Lua
ls.add_snippets(
    "lua", {
        s({
            trig="luatmp",
            dscr="Lua File Template",
            regTrig=false,
            priority=100,
            snippetType="snippet"
        }, fmt(
        [[
        -- <>
        --
        -- Author (s):
        --     * Chase Timmins `chase.timmins@gmail.com`
        --
        -- Import Statements

        -- Function Definitions

        -- Main
        ]], {
            i(1, "RoughDescriptor")
        })
        ), s({
            trig="luamod",
            dscr="Lua Module Template",
            regTrig=false,
            priority=150,
            snippetType="snippet"
        }, fmt(
        [[
        -- <>
        --
        -- Author(s):
        --     * Chase Timmins `chase.timmins@gmail.com`
        -- 
        -- Description:
        --     <>
        -- 
        -- Import Statements

        -- Local Functions

        -- Module
        local R = {}

        -- Create Module here
        <>

        return R
        ]],{
            i(1, "ModuleName"),
            i(2, "RoughDescriptor"),
            i(0)
        }))
}, {
    key = "lua"
})

-- - Python
ls.add_snippets(
    "python", {
        s({
            trig="pytemp",
            dscr="Python File Template",
            regTrig=false,
            priority=100,
            snippetType="autosnippet"
        },
        fmt(
        [[
        """
        <>

        Author(s):
        - Chase Timmins `chase.timmins@gmail.com`

        Description:
        <>
        """
        ### Import Statements
        ## Built-In Libraries

        ## Internal Libraries

        ## External Libraries

        ### Constant Definitions

        ### Function Definitions

        ### Class Definitions

        ### Main

        def main():
        pass

        if __name__ == '__main__':
            main()
        ]],{
            i(1),
            i(2)
        })
        ),
        s({
            trig='clstemp',
            dscr="Python Class Template",
            regTrig=false,
            priority=100,
            snippetType='autosnippet'
        },
        fmt(
        [[
        ## <>
        class <>:
        """<>
        Properties:
        None

        Methods:
        None
        """
        pass
        ]],
        {
            i(1),
            rep(1),
            i(2)
        })
        ),
        s({
            trig='functemp',
            dscr="Python Function Template",
            regTrig=false,
            priority=100,
            snippetType='autosnippet'
        },
        fmt2(
        [[
        ## {}
        def {}({}) -> {}:
        """{}

        Argument(s):
        {}
        Return(s):
        ret ({}) --
        """
        {}pass
        ]],
        {
            i(1, 'funcName'),
            rep(1),
            i(3, 'arg_list:arg_type'),
            i(4, 'None'),
            i(2, 'Description'),
            d(5, pyfunc_temp, {3}),
            rep(4),
            i(0),
        })
    ),
}, {
    key = "python"
})


-- Snippet Testing Ground (lua)


