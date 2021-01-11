# frozen_string_literal: true

require 'pathname'
require 'yaml'

CUR = Pathname(__dir__)
SRC = CUR + 'src'
HOME = Pathname(Dir.home)
CONFIG = HOME + '.config'
TASK = CUR + 'task'

TASK.glob('*.rake') { |f| load f }

task default: %i[config_files dot_files]

desc 'remove all symlink to dotfiles'
task remove: %i[remove_config_files remove_dot_files]
