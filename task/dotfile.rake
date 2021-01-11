# frozen_string_literal: true

DOT_FILES = YAML.load_file(CUR + 'dot_file.yml')

DOT_FILES.each do |filename|
  desc "Generate ~/.#{filename}"
  file HOME + ".#{filename}" do
    symlink SRC + filename, HOME + ".#{filename}"
  end
end

task dot_files: DOT_FILES.map { |f| HOME./(".#{f}").to_s }

desc 'add dotfile'
task :dot, %i[name] do |_, args|
  name = args[:name]
  abort 'file exists.' if DOT_FILES.include?(name)
  src = HOME + ".#{name}"
  dst = SRC + name
  mv src, dst
  symlink dst, src
  system "git add #{SRC}/#{name}"
  File.open(CUR + 'dot_files.yml', 'w') do |w|
    w << YAML.dump([*DOT_FILES, name].sort)
  end
  system 'git add dot_file.yml'
  system "git commit -m '[#{name}] added'"
end

task :remove_dot_files do
  DOT_FILES.map { |f| HOME + ".#{f}" }.select(&:symlink?).each(&method(:rm))
end
