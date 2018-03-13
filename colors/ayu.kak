# ayu theme

%sh{
    bg="rgb:212733"

    comment="rgb:5C6773"
    markup="rgb:F07178"
    constant="rgb:D4BFFF"
    operator="rgb:80D4FF"
    tag="rgb:5CCFE6"
    regexp="rgb:95E6CB"
    string="rgb:BBE67E"
    function="rgb:FFD57F"
    special="rgb:FFC44C"
    keyword="rgb:FFAE57"

    error="rgb:FF3333"
    accent="rgb:FFCC66"
    panel="rgb:272D38"
    guide="rgb:3D4751"
    line="rgb:242B38"
    selection="rgb:646F7C"
    fg="rgb:D9D7CE"
    fg_idle="rgb:607080"

    echo "
        # Code highlighting
        face value     ${constant}
        face type      ${tag}+b
        face variable  ${fg}
        face module    ${tag}
        face function  ${function}
        face string    ${string}
        face keyword   ${keyword}
        face operator  ${operator}
        face attribute ${keyword}
        face comment   ${comment}
        face meta      ${comment}
        face builtin   ${function}+b

        # Markdown highlighting
        face title     ${function}+b
        face header    ${tag}
        face bold      ${fg}+b
        face italic    ${fg}+i
        face mono      ${fg}
        face block     default
        face link      default
        face bullet    default
        face list      default

        face Default            ${fg},${bg}
        face PrimarySelection   ${fg},${selection}
        face SecondarySelection ${bg},${selection}
        face PrimaryCursor      ${bg},${fg}
        face SecondaryCursor    ${bg},${fg}
        face PrimaryCursorEol   ${bg},${fg}
        face SecondaryCursorEol ${bg},${fg}
        face LineNumbers        ${guide},${bg}
        face LineNumberCursor   ${line},${accent}
        face MenuForeground     ${panel},${fg}
        face MenuBackground     default,${panel}
        face MenuInfo           ${bg}
        face Information        ${bg},${fg}
        face Error              default,${error}
        face StatusLine         ${fg},${panel}
        face StatusLineMode     ${accent}+b
        face StatusLineInfo     ${tag}
        face StatusLineValue    ${error}
        face StatusCursor       ${bg},${fg}
        face Prompt             ${accent}
        face MatchingChar       default+u
        face BufferPadding      ${panel},${bg}
        face Whitespace         ${panel}
    "
}
