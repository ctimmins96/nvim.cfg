-- Bulk Imports
local ls = require("luasnip")
local logger = require('custom.plugins.logger').new('snippets')

-- Local Variables
local ex_op = {
    active = { hl_group = "colorizer_mb_808080" },
    visited = { hl_group = "colorizer_mb_112233" },
    unvisited = { hl_group = "colorizer_mb_ffa500" },
}

-- Configuration
logger:info('Setting config')
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
local d = ls.dynamic_node
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

local function parse_type(type_str)
    if string.sub(type_str, 1, 1) == "&" then
        return "Ref " .. parse_type(string.sub(type_str, 2))
    elseif string.sub(type_str, 1, 1) == "[" and string.sub(type_str, -1, -1) == "]" then
        return parse_type(string.sub(type_str,2, -2)) .. " array"
    else
        return type_str
    end
end

local function parse_var(var_str)
    if string.sub(var_str, 1, 1) == "&" then
        return "Referenced-"..parse_var(string.sub(var_str, 2))
    elseif string.len(var_str) < 4 then
        return var_str
    elseif string.sub(var_str, 1, 4) == "mut " then
        return "Mutable "..string.sub(var_str,5)
    elseif string.sub(var_str, 1, 1) == "'" then
        local s_idx
        _, s_idx = string.find(var_str, " ")
        local lifetime = vim.split(var_str, " ", true)[1]
        local nvar = string.sub(var_str, s_idx + 1)
        return parse_var(nvar) .. " [Lifetime=" .. string.sub(lifetime, 2) .. "]"
    else
        return var_str
    end
end

local function rust_arg_check(arg_str)
    if arg_str == '' then return { "None" }
    elseif string.find(arg_str, ", ") then
        local ret = {}
        for _, val in ipairs(vim.split(arg_str, ", ", true)) do
            table.insert(ret, rust_arg_check(val)[1])
        end
        return ret
    else
        if string.find(arg_str, ": ") then
            local raw_var = vim.split(arg_str, ": ", true)[1]
            local type = vim.split(arg_str, ": ", true)[2]
            local var = parse_var(raw_var)
            local type_str = parse_type(type)
            return { var .. " (" .. type_str .. ")" }
        elseif string.find(arg_str, "self") then
            return { parse_var(arg_str) }
        else
            return { parse_var(arg_str).." (Placeholder)" }
        end
    end
end

local function rust_func(args, _, user_args)
    local params = rust_arg_check(args[1][1])
    local ret = {}
    for _, val in ipairs(params) do
        table.insert(ret, "///     - " .. val .. " -- Info goes here.")
    end
    return ret
end

-- Snippets
-- - Lua
logger:info("Setting Lua snippets")
local lua = {
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
}
ls.add_snippets("lua", lua,
{
    key = "lua",
})

-- - Python
logger:info("Setting Python snippets")
local python = {
s({
            trig="pytemp",
            dscr="Python File Template",
            regTrig=false,
            priority=100,
            snippetType="snippet"
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
            snippetType='snippet'
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
            snippetType='snippet'
        },
        fmt2(
        [[
        ## {}
        def {}({}) -> {}:
            """{}

            Argument(s):
        {}
            Return(s):
                -- ret ({}) --
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
}

ls.add_snippets("python", python,
{
    key = "python",
})

-- - Markdown
logger:info("Setting Markdown snippets.")
local markdown = {
    s({
        trig='link',
        dscr="Markdown Link Snippet",
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t("["),
        i(1, "Text"),
        t("]("),
        i(2,"google.com"),
        t(")")
    })
}

ls.add_snippets("markdown", markdown,
{
    key='markdown'
})

-- - Rust
logger:info("Setting Rust snippets.")
local rust = {
    s({
        trig='fb',
        dscr='Foobar'
    }, {
        t("Foobar")
    }),
    s({
        trig='ftemp',
        dscr='Rust File Template',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, fmt(
    [[
    // <>
    //
    // Author(s):
    //     * Chase Timmins `chase.timmins@gmail.com`

    //-- Imports

    //-- Functions

    //-- Structs / Enums

    //-- Main
    fn main() {
        // Do Stuff<>
    }
    ]], {
        i(1, "File Name"),
        i(0)
    })),
    s({
        trig='func',
        dscr='Rust Function Template',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "/// Function: " }),
        rep(1),
        t({ "", "///", "/// Argument(s):", '' }),
        f(rust_func, {2}, {}),
        t({ "", "///", "/// Return(s):", "///     - ret (" }),
        rep(3),
        t({ ") -- Info goes here.", "fn " }),
        i(1, "sum"),
        t( "(" ),
        i(2, "values: &[i32]"),
        t(") -> "),
        i(3, "i32"),
        t({ " {", "    // Do a thing", "}" })
    }),
    s({
        trig='fnp',
        dscr='Rust Public Function Template',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "/// Function: " }),
        rep(1),
        t({ "", "///", "/// Argument(s):", '' }),
        f(rust_func, {2}, {}),
        t({ "", "///", "/// Return(s):", "///     - ret (" }),
        rep(3),
        t({ ") -- Info goes here.", "pub fn " }),
        i(1, "sum"),
        t( "(" ),
        i(2, "values: &[i32]"),
        t(") -> "),
        i(3, "i32"),
        t({ " {", "    // Do a thing", "}" })
    }),
    s({
        trig='dd',
        dscr='Rust Derive Debug Shortcut',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "#[derive(Debug)]"})
    }),
    s({
        trig='iter',
        dscr='Rust Iterator Template',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({"impl Iterator for "}),
        i(1, "Structure"),
        t({ " {", "    type Item = " }),
        i(2, "i32");
        t({ ";", "", "    fn next(&mut self) -> Option<Self::Item> {",
        "        // Do a thing", "    }", "}" }),
    }),
    s({
        trig='iterl',
        dscr='Rust Iterator Template with Lifetimes',
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({"impl<'a> Iterator for "}),
        i(1, "Structure"),
        t({ "<'a> {", "    type Item = " }),
        i(2, "i32");
        t({ ";", "", "    fn next(&mut self) -> Option<Self::Item> {",
        "        // Do a thing", "    }", "}" }),
    }),
    s({
        trig="ddcp",
        dscr="Rust Derive shortcut",
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "#[derive(Debug,Clone,PartialEq)]"})
    }),
    s({
        trig="test",
        dscr="Rust Test function template",
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "#[test]", "fn " }),
        i(1, "test_something"),
        t({ "() {", "    // Break Stuff", "}" })
    }),
    s({
        trig="mod",
        dscr="Rust Module Template",
        regTrig=false,
        priority=100,
        snippetType='snippet'
    }, {
        t({ "// Module: " }),
        i(1, "MyMod"),
        t({ "", "// ", "// Description:", "//     " }),
        i(2, "Brief Description"),
        t({ "", "// ", "", "//-- Submodules", "", "//-- External Imports", "", "//-- Functions", "",
        "//-- Structs / Implementations / Enums / Traits", "" })
    })
}

ls.add_snippets("rust", rust,
{
    key='rust'
})

-- Snippet Testing Ground (lua)


