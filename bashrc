
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

# napalm support: https://github.com/mbezjak/napalm
if [[ -d ~/.napalm ]]; then
  for bash_script in ~/.napalm/*.sh
  do
    [[ -x $bash_script ]] && . $bash_script
  done
  unset bash_script
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
alias hist='history | grep'
alias openports='netstat --all --numeric --programs --inet'
alias pg='ps -Af | grep'
alias touchall='find -type f -exec touch {} \;'
backup() { cp --verbose --recursive -p "$1" "$1"-$(date +%Y%m%d-%H%M%S); }

# command dependent
type -P emacs    &> /dev/null && alias e='emacs'
type -P hg       &> /dev/null && alias hgworkspace='hgforeach hgproject'
type -P ack-grep &> /dev/null && alias ack='ack-grep'
type -P python   &> /dev/null && alias serve='python -m SimpleHTTPServer'
type -P python2  &> /dev/null && alias serve='python2 -m SimpleHTTPServer'
type -P dolphin  &> /dev/null && alias d='dolphin . &> /dev/null'
type -P kwrite   &> /dev/null && alias k='kwrite &> /dev/null'

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
  grailswhere() { grailsforeach grailshasplugin "$1" | column --table; }
}

type -P mvn &> /dev/null && {
  export MAVEN_OPTS="-Xms256m -Xmx512m"
}

type -P pacman &> /dev/null && {
  alias pu='sudo pacman --sync --refresh --sysupgrade'
  alias psp='sudo pacman --sync'
  alias pss='pacman --sync --search'
  alias psi='pacman --sync --info'
  alias pqs='pacman --query --search'
  alias pqi='pacman --query --info'
  alias pql='pacman --query --list'
  alias pqo='pacman --query --owns'
}

if [[ -d ~/lib/jsdoc-toolkit ]]; then
  export JSDOC_HOME="$HOME/lib/jsdoc-toolkit"
  alias jsdoc='java -jar "${JSDOC_HOME}/jsrun.jar" "${JSDOC_HOME}/app/run.js" -a -r 10 -t="${JSDOC_HOME}/templates/jsdoc" -d=target/docs/javascript'
fi

cd_alias() {
  local name="$1"
  local dir="$2"

  [[ -d "$dir" ]] && {
    # example:
    # ct() { cd "/tmp"; }
    eval "$name() { cd \"$dir\"; }"
    # example:
    # _ct() {
    #   local cur="${COMP_WORDS[COMP_CWORD]}"
    #   COMPREPLY=($(cd ~/workspace && compgen -d "$cur"|sort))
    # }
    eval """
_$name() {
  local cur=\"\${COMP_WORDS[COMP_CWORD]}\"
  COMPREPLY=(\$(cd \"$dir\" && compgen -d \"\$cur\"|sort))
}
"""
    complete -o nospace -S '/' -F _"$name" "$name"
  }
}

cd_alias cw "$HOME/workspace"
cd_alias cj "$HOME/workspace/java"
cd_alias cg "$HOME/workspace/grails"
cd_alias co "$HOME/workspace/other"
cd_alias ct /tmp

if [[ -d /usr/share/doc/python/html ]]; then
  export PYTHONDOCS=/usr/share/doc/python/html
elif [[ -d /usr/share/doc/python2/html ]]; then
  export PYTHONDOCS=/usr/share/doc/python2/html
fi
