map global user y '<a-|>which xsel >/dev/null 2>&1 && xsel -i -b || pbcopy<ret>; :echo "copied selection to clipboard"<ret>' \
  -docstring "clipboard: copy"

map global user P '!which xsel >/dev/null 2>&1 && xsel -o -b || pbpaste<ret>' \
  -docstring "clipboard: paste before"

map global user p '<a-!>which xsel >/dev/null 2>&1 && xsel -o -b || pbpaste<ret>' \
  -docstring "clipboard: paste after"
