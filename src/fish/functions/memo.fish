function memo -d "clip web memo"
  set title (curl -s $argv | grep -o '<title>.*</title>' | sed 's#<title>\(.*\)</title>#\1#' | sed 's/ //g')
  echo $title
  pandoc $argv -f html -o ~/memo/$title.md
end
