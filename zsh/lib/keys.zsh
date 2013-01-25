# more useful M-h command
unalias run-help
autoload run-help

# M-b M-f -> bash
autoload -U select-word-style
select-word-style bash

# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# file rename magic
autoload -U copy-prev-shell-word
bindkey "\em" copy-prev-shell-word

# execute from history
bindkey -M menuselect '^o' accept-and-infer-next-history

# do history expansion on space
bindkey ' ' magic-space

# jobs
setopt long_list_jobs

# remove rprompt when executing command
setopt transient_rprompt

# directories
setopt auto_pushd
setopt pushd_ignore_dups

# other keybindings
bindkey -e
bindkey "^r" history-incremental-search-backward
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "\e\e[C" forward-word  # alt-rightarrow
bindkey "\e\e[D" backward-word # alt-leftarrow

if [[ -e ~/.zkbd/"$TERM-$VENDOR-$OSTYPE" ]]; then
  source ~/.zkbd/"$TERM-$VENDOR-$OSTYPE"

  bindkey "${key[Up]}" up-line-or-search
  bindkey "${key[Down]}" down-line-or-search

  bindkey "${key[Home]}" beginning-of-line
  bindkey "${key[End]}" end-of-line

  bindkey "${key[Backspace]}" backward-delete-char
  bindkey "${key[Delete]}" delete-char
fi
