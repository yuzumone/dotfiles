## android
set --export JAVA_HOME /usr/lib/jvm/java-8-openjdk
set --export ANDROID_HOME /opt/android-sdk
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH

## dart
set -x PATH $HOME/.pub-cache/bin $PATH

## rbenv
status --is-interactive; and source (rbenv init -|psub)

## kawasaki theme
set -g theme_display_time yes
set -g theme_display_group no
set -g theme_display_rw no
set -g theme_display_virtualenv no
set -g theme_display_time_format +%H:%M
set -g __fish_prompt_hostname (hostname)

## ghq
bind \c] __ghq_repository_search

## alias
alias e='emacsclient -n'
alias pubupgrade="pub global list | grep -v Git | awk '{print $1}' | xargs -n1 pub global activate"
