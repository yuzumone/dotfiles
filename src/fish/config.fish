set -gx PATH $HOME/.bin $PATH

## XDG Base Directory
set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_CACHE_HOME $HOME/.cache
set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_STATE_HOME $HOME/.local/state

## dart
set -gx PATH $HOME/.pub-cache/bin $PATH

## rbenv
if command -s rbenv > /dev/null
    status --is-interactive; and source (rbenv init -|psub)
end

## go
set --export GOPATH $XDG_DATA_HOME/go
set -gx PATH $GOPATH/bin $PATH

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

## wsl
set name (uname -a | grep microsoft)
if test -n $name
  set --export BROWSER "/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe /c start"
end
