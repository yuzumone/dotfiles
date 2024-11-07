function __fzf_z -d 'Find and Jump to a recent directory.'
  set -l query (commandline)

  if test -n $query
    set flags --query "$query"
  end

  z -l | awk '{ print $2 }' | fzf | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end
