cdr () {
  cd "$(git rev-parse --show-toplevel)"
}

ducks () {
  if ! which gsort >/dev/null; then
    echo "no gsort... install coreutils first" >&2
    return 1
  fi
  dir=${1:-"."}
  du -cksh "$dir"/* | gsort -h
}

histgrep() {
  history 1 | grep "$@"
}

cur () {
  set +e
  DIR=~/archive/$(date +%Y/%m)
  if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
    ln -sfn "$DIR" ~/archive/current
  fi
  echo "${DIR}"
  cd ~/archive/current
}

mess () {
  set +e
  DIR=~/mess/$(date +%Y/%V)
  if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
    ln -sfn "$DIR" ~/mess/current
  fi
  echo "${DIR}"
  cd ~/mess/current
}

# Powerful mv workalike.
autoload -U zmv
alias zmv="noglob zmv"
alias ccp="zmv -WC"
alias lln="zmv -WL"
alias mmv="zmv -W"

# ALIASES
# =======

if which gdate >/dev/null; then alias date=gdate; fi
if which gdu >/dev/null; then alias du=gdu; fi
if which gseq >/dev/null; then alias seq=gseq; fi
if which gsort >/dev/null; then alias sort=gsort; fi

if (ls --version 2>&1 | grep -q "coreutils"); then
  lsopts="-FBv --color=auto -I'*.pyc' --group-directories-first"
else
  # Darwin colour ls
  lsopts="-FG"
fi

alias ls="ls ${lsopts}"
alias l="ls"
alias s="ls"
alias sl="ls"
alias ll="ls -l"
alias llh="ll -h"
alias la="ls -A"
alias lal="la -l"
alias lalh="lal -h"

alias d="dirs -v"
alias dc="dc -f ~/.dcinit -f -"
alias dcurl="curl -s -D- -o/dev/null"
alias e="$EDITOR"
alias fig="docker compose"
alias grep="grep --colour"
alias h="head -n $(( +LINES ? LINES - 4 : 20 ))"
alias ipy="python3 -m ipython --no-banner 2>/dev/null || ipython --no-banner"
alias notrail="sed -Ee 's/[ 	]+$//'  -i ''"
alias psg="ps auxwww | head -n 1; ps auxwww | grep -Ei"
alias reload="exec $SHELL"
alias rm="rm -i"
alias sudo="command sudo " # this trailing space checks next word for aliases
alias t="tail -n $(( +LINES ? LINES - 4 : 20 ))"

alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
