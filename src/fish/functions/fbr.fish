function fbr -d "checkout git branch"
  set branches (git branch -vv)
  set branch (echo $branches | fzf +m)
  git checkout (echo $branch | awk '{print $1}' | sed "s/.* //")
end
