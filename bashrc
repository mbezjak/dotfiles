
# Check for an interactive session
[ -z "$PS1" ] && return

PS1='\[\e[1;32m\][\u@\h \[\e[1;34m\]\W\[\e[1;32m\]]\$\[\e[0m\] '
HISTCONTROL=ignoreboth # ignorespace + ignoredups
HISTFILESIZE=1000000   # 1M
HISTSIZE=10000         # 10k
export EDITOR=vim
export VISUAL=vim
if [[ -d ~/bin && ":$PATH:" != *":$HOME/bin:"* ]]; then
  export PATH="$PATH:$HOME/bin"
fi
if [[ -d ~/local/bin && ":$PATH:" != *":$HOME/local/bin:"* ]]; then
  export PATH="$PATH:$HOME/local/bin"
fi

# modified commands
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# ls
alias l='ls -l --human-readable'
alias ll='l --all'
alias lr='l --recursive'
alias lt='ll -t --reverse'
alias lm='ll | less'
eval $(dircolors -b) # colored ls output

# new commands
alias ..='cd ..'
alias ...='cd ../..'
alias du1='du --max-depth=1 --human-readable'
alias hist='history | grep $1'
alias openports='netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep $1'
alias touchall='find -type f -exec touch {} \;'

# command dependent
type -P emacs    &> /dev/null && alias e='emacs'
type -P hg       &> /dev/null && alias hgworkspace='hgforeach hgproject'
type -P ack-grep &> /dev/null && alias ack='ack-grep'
type -P python   &> /dev/null && alias serve='python -m SimpleHTTPServer'
type -P python2  &> /dev/null && alias serve='python2 -m SimpleHTTPServer'
type -P dolphin  &> /dev/null && alias d='dolphin . &> /dev/null'
type -P kwrite   &> /dev/null && alias k='kwrite $1 &> /dev/null'

type -P git &> /dev/null && {
    alias g='git'
    complete -o default -o nospace -F _git g
}

type -P hgtk &> /dev/null && {
  alias hgl='hgtk log'
  alias hgc='hgtk commit'
}

type -P grails &> /dev/null && {
  export GRAILS_OPTS="-XX:MaxPermSize=512m -Xmx1024M -server"
  alias gc='grails clean'
  alias gp='grails package'
  alias gt='grails test-app'
  alias gr='grails run-app'
  alias gr-sql='grails -Dlogsql=true run-app'
  alias gi='grails install-plugin'
  alias gu='grails uninstall-plugin'
}

type -P mvn &> /dev/null && {
  export MAVEN_OPTS="-Xms256m -Xmx512m"
}

type -P pacman &> /dev/null && {
  alias pu='sudo pacman --sync --refresh --sysupgrade'
  alias psp='sudo pacman --sync $1'
  alias pss='pacman --sync --search $1'
  alias psi='pacman --sync --info $1'
  alias pqs='pacman --query --search $1'
  alias pqi='pacman --query --info $1'
  alias pql='pacman --query --list $1'
  alias pqo='pacman --query --owns $1'
}

if [[ -d ~/lib/jsdoc-toolkit ]]; then
  export JSDOC_HOME="$HOME/lib/jsdoc-toolkit"
  alias jsdoc='java -jar "${JSDOC_HOME}/jsrun.jar" "${JSDOC_HOME}/app/run.js" -a -r 10 -t="${JSDOC_HOME}/templates/jsdoc" -d=target/docs/javascript'
fi

# napalm support: https://github.com/mbezjak/napalm
if [[ -d ~/.napalm ]]; then
  for bash_script in ~/.napalm/*.sh
  do
    [[ -x $bash_script ]] && . $bash_script
  done
  unset bash_script
fi

[[ -d ~/workspace ]] && {
  cw() { cd ~/workspace/"$1"; }
  _cw() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(cd ~/workspace && compgen -d "$cur"|sort))
  }
  complete -o nospace -F _cw cw
}

[[ -d ~/workspace/java ]] && {
  cj() { cd ~/workspace/java/"$1"; }
  _cj() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(cd ~/workspace/java && compgen -d "$cur"|sort))
  }
  complete -o nospace -F _cj cj
}

[[ -d ~/workspace/grails ]] && {
  cg() { cd ~/workspace/grails/"$1"; }
  _cg() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(cd ~/workspace/grails && compgen -d "$cur"|sort))
  }
  complete -o nospace -F _cg cg
}

[[ -d ~/workspace/other ]] && {
  co() { cd ~/workspace/other/"$1"; }
  _co() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=($(cd ~/workspace/other && compgen -d "$cur"|sort))
  }
  complete -o nospace -F _co co
}

if [[ -d /usr/share/doc/python/html ]]; then
  export PYTHONDOCS=/usr/share/doc/python/html
elif [[ -d /usr/share/doc/python2/html ]]; then
  export PYTHONDOCS=/usr/share/doc/python2/html
fi
