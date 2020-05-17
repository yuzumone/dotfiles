## android
set --export JAVA_HOME /usr/lib/jvm/java-8-openjdk
set --export ANDROID_HOME /opt/android-sdk
set -gx PATH $ANDROID_HOME/tools $PATH
set -gx PATH $ANDROID_HOME/tools/bin $PATH
set -gx PATH $ANDROID_HOME/platform-tools $PATH
set -gx PATH $ANDROID_HOME/emulator $PATH

## flutter
set -gx PATH /opt/flutter/bin $PATH

## rbenv
status --is-interactive; and source (rbenv init -|psub)

## kawasaki theme
set -g theme_display_time yes
set -g theme_display_group no
set -g theme_display_rw no

## ghq
bind \c] __ghq_repository_search
