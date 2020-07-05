## android
set --export JAVA_HOME /usr/lib/jvm/java-8-openjdk
set --export ANDROID_HOME /opt/android-sdk
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH

## flutter
set -gx PATH /opt/flutter/bin $PATH
set -gx PATH $HOME/.pub-cache/bin $PATH

## rbenv
status --is-interactive; and source (rbenv init -|psub)

## kawasaki theme
set -g theme_display_time yes
set -g theme_display_group no
set -g theme_display_rw no

## wsl
set name (uname -a | grep microsoft)
if test -n $name
  set --export DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
  set --export GDK_SCALE 0.5
  set --export GDK_DPI_SCALE 2
  alias h='history | fzf | perl -pe "chomp if eof" | read -lz result; and commandline -- $result; commandline -f repaint'
  alias g='ghq list --full-path | fzf | read select; cd $select'
end

## ghq
bind \c] __ghq_repository_search
