function __tmux_refresh_content --on-event fish_preexec
  if test -n "$TMUX"
    echo "hoge"
    tmux refresh-client -S
  end
end
