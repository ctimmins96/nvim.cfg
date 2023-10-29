local ls = require('luasnip')

return {
    ls.snippet(
        { trig = 'hi' },
        { t("Hello,  world!") }
    ),

    ls.snippet(
        { trig = 'foo' },
        { t("Another snippet...") }
    ),
}
