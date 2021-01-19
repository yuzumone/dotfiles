# frozen_string_literal: true

desc 'rsync dotfiles'
task :rsync, %i[hostname] do |_, args|
  hostname = args[:hostname]
  system "rsync -avz --delete ~/dotfiles/ ktogawa@#{hostname}:~/dotfiles"
end
