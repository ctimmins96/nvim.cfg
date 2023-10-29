-- Snippet Abbreviations
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
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
return {
    s(
        {
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
        ]],
        {
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
}


