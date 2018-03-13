hook global WinSetOption filetype=go %{
  # autocomplete by default
  go-enable-autocomplete

  # auto-lint by building
  lint-enable
  set window lintcmd "bash -c '$HOME/.config/kak/bin/go-lint'"
  hook buffer BufWritePost .+\.go %{ lint }

  # auto-format on save
  hook buffer BufWritePre .+\.go %{ go-format -use-goimports }

  # indent using tabs
  set global indentwidth 0

  # goto-definition
  map global goto d '<esc>:go-jump<ret>' \
    -docstring "jump to definition"
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

remove-highlighter shared/go

add-highlighter shared/ regions -default code go \
    back_string '`' '`' '' \
    double_string '"' (?<!\\)(\\\\)*" '' \
    single_string "'" (?<!\\)(\\\\)*' '' \
    comment /\* \*/ '' \
    comment '//' $ ''

add-highlighter shared/go/back_string fill string
add-highlighter shared/go/double_string fill string
add-highlighter shared/go/single_string fill string
add-highlighter shared/go/comment fill comment

add-highlighter shared/go/code regex \b[A-z]+(?=:)\b 0:attribute
add-highlighter shared/go/code regex \.\K\b[A-z]+\b 0:attribute
add-highlighter shared/go/code regex \b[A-z]+(?=\{)\b 0:type
add-highlighter shared/go/code regex \b[A-z]+(?=\()\b 0:function
add-highlighter shared/go/code regex :=|\+|-|=|/|\||&|\*|!|<- 0:operator
add-highlighter shared/go/code regex \;|\.|, 0:builtin

add-highlighter shared/go/code regex %{-?([0-9]*\.(?!0[xX]))?\b([0-9]+|0[xX][0-9a-fA-F]+)\.?([eE][+-]?[0-9]+)?i?\b} 0:value

%sh{
    # Grammar
    keywords="break|default|func|interface|select|case|defer|go|map|struct"
    keywords="${keywords}|chan|else|goto|package|switch|const|fallthrough|if|range|type"
    keywords="${keywords}|continue|for|import|return|var"
    types="bool|byte|chan|complex128|complex64|error|float32|float64|int|int16|int32"
    types="${types}|int64|int8|interface|intptr|map|rune|string|struct|uint|uint16|uint32|uint64|uint8"
    values="false|true|nil|iota"
    functions="append|cap|close|complex|copy|delete|imag|len|make|new|panic|print|println|real|recover"

    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=go %{
        set-option window static_words '${keywords}:${attributes}:${types}:${values}:${functions}'
    }" | tr '|' ':'

    # Highlight keywords
    printf %s "
        add-highlighter shared/go/code regex \b(${keywords})\b 0:keyword
        add-highlighter shared/go/code regex \b(${attributes})\b 0:attribute
        add-highlighter shared/go/code regex \b(${types})\b 0:type
        add-highlighter shared/go/code regex \b(${values})\b 0:value
        add-highlighter shared/go/code regex \b(${functions})\b 0:builtin
    "
}

