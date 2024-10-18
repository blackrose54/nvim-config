local ls = require "luasnip" -- LuaSnip shortcut
local s = ls.snippet -- Define a snippet
local t = ls.text_node -- Define text nodes
local i = ls.insert_node -- Define insert nodes

-- Define your snippet
ls.add_snippets("rust", {
  s("test", {
    t "#[cfg(test)]",
    t { "", "mod tests {", "\tuse super::*;", "" },
    t { "", "\t#[test]", "\tfn " },
    i(1, "test_name"),
    t "() {",
    t { "", "\t\tlet result = " },
    i(2, "function_name"),
    t "(",
    i(3, "args"),
    t ");",
    t { "", "\t\tassert_eq!(result, " },
    i(4, "expected_value"),
    t ");",
    t { "", "\t}", "}" },
  }),
})
