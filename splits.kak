try %{
  # nicer window splitting
  def split -params 0..1 -file-completion %{ %sh{
    args=""
    if [ $# = "1" ]; then
      args=" edit $@"
    fi

    if [ -n "$TMUX" ]; then
      echo tmux-new-vertical$args
    else
      echo iterm-new-horizontal$args
    fi
  }}

  def vsplit -params 0..1 -file-completion %{ %sh{
    args=""
    if [ $# = "1" ]; then
      args=" edit $@"
    fi

    if [ -n "$TMUX" ]; then
      echo tmux-new-horizontal$args
    else
      echo iterm-new-vertical$args
    fi
  }}

  alias global sp split
  alias global vs vsplit
}
