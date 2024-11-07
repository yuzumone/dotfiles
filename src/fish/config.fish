set -gx PATH $HOME/Android/Sdk $PATH
set -gx PATH $HOME/.bin $PATH

## XDG Base Directory
set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_CACHE_HOME $HOME/.cache
set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_STATE_HOME $HOME/.local/state

## nnn
set --export NNN_FIFO /tmp/nnn.fifo
set --export NNN_PLUG 'p:preview-tui'

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

## bind
bind \c] __ghq_repository_search
bind \ec __fzf_z
bind \cv true

## alias
alias e='emacsclient -n'
