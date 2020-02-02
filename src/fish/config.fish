## rbenv init setting
status --is-interactive; and source (rbenv init -|psub)

## wsl
set -x DISPLAY localhost:0.0

## flutter
set -x ANDROID_HOME /opt/android-sdk
set PATH /opt/flutter/bin $PATH

# ghq
bind \c] __ghq_repository_search
