# frozen_string_literal: true

PACKAGE = CUR + 'package'

namespace :install do
  PACKAGE.glob('*.yml') do |f|
    name = f.basename('.yml')
    desc "install package in #{name}"
    task name, %i[package] do |_, args|
      spec = YAML.load_file(f)
      cmd = spec['install'].split(/\s+/)
      packages = args[:package].split(/\s+/)
      if system(*cmd.flat_map { |c| c == '%s' ? packages : c })
        spec['package'] = [*spec['package'], *packages].sort.uniq
        f.open('w') do |w|
          w << YAML.dump(spec)
        end
        system 'git', 'add', f.to_s
        system 'git', 'commit', '-m', "[#{name}] add #{packages.join(', ')}"
        warn 'install succeed.'
      else
        warn 'install failed.'
      end
    end
  end
end

namespace :sync do
  PACKAGE.glob('*.yml') do |f|
    name = f.basename('.yml')
    desc "sync package use #{name}"
    task name do
      spec = YAML.load_file(f)
      if spec['init']
        spec['init'].each{|x| system(x)}
      end
      cmd = spec['install'].split(/\s+/)
      if system(*cmd.flat_map { |c| c == '%s' ? spec['package'] : c })
        warn 'sync succeed.'
      else
        warn 'sync failed.'
      end
    end
  end
end
