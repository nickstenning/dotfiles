aws () {
  if [ -z "$1" ]; then
    echo "Usage: aws <name>"
  else
    eval `gpg -d "${HOME}/.aws.${1}.gpg"`
  fi
}

alias ggpg="gpg -u digital.cabinet-office.gov.uk"

ggpgedit() {
  local FILENAME="$1"
  shift
  gpgedit "$FILENAME" -u digital.cabinet-office.gov.uk "$@"
}
compdef gpgedit=gpg
compdef ggpgedit=gpg

histgrep() {
  history 1 | grep "$@"
}

histstat() {
  history 1 | awk '{ print $2 }' | histogram
}

ks () {
  eval $(keychain -q --eval --inherit any-once --ignore-missing --timeout 1440 ${=KEYCHAIN_DEFAULT_KEYS})
}

mess () {
  set +e
  DIR=~/mess/$(date +%Y/%V)
  [ -d "$DIR" ] || {
    mkdir -p "$DIR"
    ln -sfn "$DIR" ~/mess/current
    echo "Created ${DIR}."
  }
  cd ~/mess/current
}

pathadd () {
  path=("$1" $path)
}

pathrm () {
  path[$path[(i)$1]]=()
}

# Powerful mv workalike.
autoload -U zmv
alias zmv="noglob zmv"
alias ccp="zmv -WC"
alias lln="zmv -WL"
alias mmv="zmv -W"

# ALIASES
# =======

if which gdate >/dev/null; then alias date="gdate"; fi
if which gdu >/dev/null; then alias du="gdu"; fi
if which gseq >/dev/null; then alias seq="gseq"; fi

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

alias aka-curl='curl -H "Pragma: akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no"'
alias aka-dcurl="aka-curl -s -D- -o/dev/null"
alias be="bundle exec"
alias bi="bundle install --path=.gems"
alias d="dirs -v"
alias dcurl="curl -s -D- -o/dev/null"
alias ducks="du -ks -- * | sort -nr | cut -f2 | tr '\n' '\0' | du -shc --files0-from=-"
alias e="$EDITOR"
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gap="git add -p"
alias gau="git add -u"
alias gb="git branch"
alias gc="git commit -v"
alias gca="git commit --amend -v"
alias gd="git diff --color-words"
alias gdc="git diff --color-words --cached"
alias gds="git diff --color-words --stat"
alias gf="git fetch"
alias gg="git grep -En"
alias gl="git log --decorate --abbrev-commit"
alias gp="git pull"
alias gpr="git pull --rebase"
alias gs="git status -sb"
alias grep="grep --colour"
alias h="head -n $(( +LINES ? LINES - 4 : 20 ))"
alias ipy="python =ipython --no-banner"
alias notrail="sed -Ee 's/[ 	]+$//'  -i ''"
alias psg="ps auxwww | head -n 1; ps auxwww | grep -Ei"
alias reload="exec $SHELL"
alias rm="rm -i"
alias s3cmd='s3cmd -c ~/.s3cfg-ns'
alias s3gds="unalias s3cmd && alias s3cmd='s3cmd -c ~/.s3cfg-gds'"
alias s3ns="unalias s3cmd && alias s3cmd='s3cmd -c ~/.s3cfg-ns'"
alias s3okf="unalias s3cmd && alias s3cmd='s3cmd -c ~/.s3cfg-okf'"
alias sudo="command sudo " # this trailing space checks next word for aliases
alias t="tail -n $(( +LINES ? LINES - 4 : 20 ))"
alias webserver="python -m SimpleHTTPServer 8000"

GDS_SSH_OPTS="-F ~/.ssh/gds_config"
alias gscp="scp $GDS_SSH_OPTS"
alias gsftp="sftp $GDS_SSH_OPTS"
alias gssh="ssh $GDS_SSH_OPTS"

OK_SSH_OPTS="-F ~/.ssh/okf_config -l okfn"
alias okscp="scp $OK_SSH_OPTS"
alias oksftp="sftp $OK_SSH_OPTS"
alias okssh="ssh $OK_SSH_OPTS"

alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..
alias -g ......=../../../../..
