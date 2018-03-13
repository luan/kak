# enable full color override on tmux
%sh{tic ${kak_config}/tmux-256color.terminfo}

def import -allow-override -params 1 %{
    source %sh{echo ${kak_config}/$1.kak}
}

def plug -allow-override -params 1..2 %{
  %sh{
    mkdir -p ${kak_config}/plugins/
    if [[ ! -d ${kak_config}/plugins/$1 ]]; then
      (cd ${kak_config}/plugins; git clone https://github.com/$1 2> /dev/null)
    else
      (cd ${kak_config}/plugins/$1; git pull 2> /dev/null)
    fi
    for file in $(echo ${kak_config}/plugins/$(basename $1)/$2*.kak); do
      echo source "$file"
    done
  }
}

# automatically reload kakrc
import reload-kakrc

plug Delapouite/kakoune-stylus
plug Delapouite/kakoune-ecmascript
plug Delapouite/kakoune-grasp
plug Delapouite/kakoune-palette

plug occivink/kakoune-find
plug occivink/kakoune-auto-percent
plug occivink/kakoune-expand

map global normal <c-w> :expand<ret> \
  -docstring "expand selection"

plug alexherbo2/move-line.kak rc/
plug alexherbo2/auto-pairs.kak rc/

map global normal ( ': move-line-above %val{count}<ret>'
map global normal ) ': move-line-below %val{count}<ret>'

hook global WinCreate .* %{ auto-pairs-enable }
map global user s :auto-pairs-surround<ret> -docstring "pairs: surround"

import filetype/go
import filetype/vue
import filetype/javascript

import clipboard
import splits
import fzf
import buffers

colorscheme ayu

# rg instead of grep/ack/ag
set global grepcmd 'rg --with-filename --column'

# auto reload changes
set global autoreload yes

# show matching pairs
remove-highlighter global/show_matching
add-highlighter global show_matching

# indent using 2 spaces by default
set global tabstop 2
set global indentwidth 2

# <tab> expands to spaces instead
hook global InsertChar \t %{
  exec -draft -itersel h@
}

# show contextual lines,columns when panning around
set global scrolloff 3,5

# commenting
map global normal '#' :comment-line<ret>

# save on enter
map global normal <ret> :w<ret>
# ...except in grep result panes
hook global WinSetOption filetype=grep %{
  unmap global normal <ret> :w<ret>
}

# use <tab> to cycle through complete suggestions
hook global InsertCompletionShow .* %{   map window insert <tab> <c-n>;   map window insert <backtab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <backtab> <c-p> }

# linting
map global user n ':lint-next-error<ret>' \
  -docstring "lint: next error"
map global user N ':lint-previous-error<ret>' \
  -docstring "lint: previous error"

# auto-mkdir parent dirs when saving a file
hook global BufWritePre .* %{ nop %sh{
  dir=$(dirname $kak_buffile)
  [ -d $dir ] || mkdir --parents $dir
}}

# highlight search matches
face search +r

hook global NormalKey [/?*nN]|<a-[/?*nN]> %{ try %{
  add-highlighter global dynregex '%reg{/}' 0:default,+u
}}

hook global NormalKey <esc> %{ try %{
  remove-highlighter global/dynregex_%reg{<slash>}
}}

# launch ide; opens window for tool output (i.e. :grep)
def -allow-override ide %{
  rename-client main
  set global jumpclient main

  new rename-client tools
  set global toolsclient tools

  focus main
}

define-command -allow-override kakrc -docstring "Open kakrc" %{
  edit ~/.config/kak/kakrc
}

