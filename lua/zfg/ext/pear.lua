local rule = require('pears.rule')

require('pears').setup( function(conf)
    conf.pair("'", {
        close = "'",
        should_expand = rule.all_of(
            rule.not_(rule.start_of_context "[a-zA-Z]"),
            rule.not_(rule.start_of_context "\'")
        ),
        filetypes = {"python", "lua"}
    })
    conf.pair('"', {
        close = '"',
        should_expand = rule.all_of(
            rule.not_(rule.start_of_context "[a-zA-Z]"),
            rule.not_(rule.start_of_context '"')
        )
    })
    conf.pair("{", {
        close = "}",
    })
    conf.pair("(", {
        close = ")",
    })
    conf.pair("[", {
        close = "]",
    })
    conf.pair("<", {
        close = ">",
    })
    conf.expand_on_enter(true)
    conf.remove_pair_on_inner_backspace(true)
    conf.remove_pair_on_outer_backspace(false)
end)



