function fmemo -d "Find memo file"
  set output (date "+%Y%m%d-%H%M%S")
  set microsoft (uname -a | grep microsoft)
  ag $argv -l ~/memo | fzf --exit-0 | read -l result; pandoc $result --metadata title=tmp--template=theme -o /tmp/$output.html
  if test -n $microsoft
    explorer.exe (wslpath -w /tmp/$output.html)
  else
    open /tmp/$output.html
  end
end
