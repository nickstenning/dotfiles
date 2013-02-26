unsetopt menu_complete   # do not autoselect the first completion entry
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS="*?_-.[]~&;$%^+"

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${LS_COLORS}

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# use /etc/hosts and ssh_config for hostname completion
typeset -U autohosts
autohosts=("$autohosts[@]" $(egrep -h '^Host' ~/.ssh/*config | grep -v '*' | awk '{$1=""}1'))
autohosts=("$autohosts[@]" $(egrep '^[^#].+' /etc/hosts | grep -v 'adobe' | awk '{$1=""}1'))
autohosts=("$autohosts[@]" $(grep -v '^#' ~/.ssh/known_hosts | cut -d' ' -f1 | sed -E 's/([^,]+),.+/\1/' | grep '^[a-zA-Z]'))

zstyle ':completion:*:hosts' hosts $autohosts

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache on

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

compdef pkill=killall
compdef hub=git
