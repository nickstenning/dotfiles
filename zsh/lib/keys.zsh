# smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# expand history (!!, !$, !1, etc.) on space
bindkey ' ' magic-space

# jobs
setopt long_list_jobs

# remove rprompt when executing command
setopt transient_rprompt

# directories
setopt auto_pushd
setopt pushd_ignore_dups

# other keybindings
export KEYTIMEOUT=1 # wait only 10ms before leaving insert mode
bindkey -v
bindkey "\e\e[C" forward-word  # alt-rightarrow
bindkey "\e\e[D" backward-word # alt-leftarrow
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

if [[ -e ~/.zkbd/"$TERM-$VENDOR-$OSTYPE" ]]; then
  source ~/.zkbd/"$TERM-$VENDOR-$OSTYPE"
  bindkey "${key[Home]}" beginning-of-line
  bindkey "${key[End]}" end-of-line
  bindkey "${key[Backspace]}" backward-delete-char
  bindkey "${key[Delete]}" delete-char
fi
