hook global WinSetOption filetype=(javascript|ecmascript|vue) %{
  set buffer lintcmd "bash -c './node_modules/eslint/bin/eslint.js --fix --format=$HOME/.config/yarn/global/node_modules/eslint-formatter-kakoune/ $kak_buffile'"
  lint-enable
  lint

  # auto lint on save
  hook buffer BufWritePost .+\.js %{ lint }

  map global normal <a-g> ':mode-grasp main<ret>' -docstring 'grasp s main'
  map global normal <a-G> ':mode-grasp all<ret>' -docstring 'grasp s all'
}

try %{
  add-highlighter shared/ecmascript/code regex \b[A-Z][A-z]+\b 0:type
  add-highlighter shared/ecmascript/code regex \b[A-z]+(?=\()\b 0:function
}

