def -allow-override fzf -params 2 %{ %sh{
  if [ -z "$TMUX" ]; then
    echo echo only works inside tmux
  else
    FILE=$($2 | fzf-tmux -d 15)
    if [ -n "$FILE" ]; then
      printf 'eval -client %%{%s} edit %%{%s}\n' "${kak_client}" "${FILE}" | kak -p "${kak_session}"
    fi
  fi
} }

def -allow-override -docstring 'invoke fzf to select a buffer' \
fzf-buffer %{ %sh{
  if [ -z "$TMUX" ]; then
    echo echo only works inside tmux
  else
    BUFFER=$(printf %s\\n "${kak_buflist}" | tr : '\n' | fzf-tmux -d 15)
    if [ -n "$BUFFER" ]; then
      echo "eval -client '$kak_client' 'buffer ${BUFFER}'" | kak -p ${kak_session}
    fi
  fi
} }

def -allow-override fzf-file -params 0..1 %{
    fzf "edit $1" "rg --files --hidden --follow --glob !.git/* . %arg{1}"
}

def -allow-override fzf-git -params 0..1 %{
    fzf "edit $1" "git ls-tree --name-only -r HEAD %arg{1}"
}

def -allow-override fzf-tag -params 0..1 %{
    fzf "tag $1" "readtags -l | cut -f1 | sort -u"
}

def -allow-override fzf-cd -params 0..1 %{
    fzf "cd $1" "find %arg{1} -type d -path *.git -prune -o -type d -print"
}

map global user f ':fzf-file<ret>' \
  -docstring "fzf: open file"

map global user b ':fzf-buffer<ret>' \
  -docstring "fzf: open buffer"

