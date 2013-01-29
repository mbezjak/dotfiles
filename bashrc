#-*-Shell-Script-*-

# Check for an interactive session
[ -z "$PS1" ] && return

PS1='\[\e[1;32m\][\[\e[1;33m\]\W$(__git_ps1 "\[\e[1;31m\] (%s)")\[\e[1;32m\]]\$\[\e[0m\] '
source /usr/share/git/completion/git-completion.bash
source /usr/share/git/completion/git-prompt.sh
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto
HISTCONTROL=ignoreboth # ignorespace + ignoredups
HISTFILESIZE=1000000   # 1M
HISTSIZE=10000         # 10k
export EDITOR=vim
export VISUAL=vim
alias vi='vim'
[[ -d ~/bin && ":$PATH:" != *":$HOME/bin:"* ]] && {
  export PATH="$PATH:$HOME/bin"
}
[[ -d ~/Dropbox/bin ]] && {
  export PATH="$PATH:$HOME/Dropbox/bin"
}
[[ -d ~/.cabal/bin ]] && {
  export PATH="$PATH:$HOME/.cabal/bin"
}
type -P gem &> /dev/null && {
  export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"
}

[[ -f /usr/etc/profile.d/autojump.bash ]] && source /usr/etc/profile.d/autojump.bash
[[ -f ~/.napalm/profile ]] && source ~/.napalm/profile


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
alias openports='netstat --all --numeric --programs --tcp'
alias pg='ps -Afww | grep'
alias k='kill -9'
alias touchall='find -type f -exec touch {} \;'
alias open='xdg-open'
alias gmailbackup='gmvault sync --db-dir ~/Documents/backup/gmvault-db bezjak.miro@gmail.com'
alias tv='vlc --alsa-audio-device plughw:1,7' # device syntax from ArchLinux ALSA wiki
search() { find -iname "*$1*"; }
backup() { cp --verbose --archive "$1" "$1"-$(date +%Y%m%d-%H%M%S); }
org-notes-backup() {
  cd ~/Dropbox/notes
  git commit --message='Automated backup'
}

# command dependent
type -P emacs    &> /dev/null && alias e='emacs'
type -P ack-grep &> /dev/null && alias ack='ack-grep'
type -P python   &> /dev/null && alias serve='python -m SimpleHTTPServer'
type -P python2  &> /dev/null && alias serve='python2 -m SimpleHTTPServer'
type -P hoogle   &> /dev/null && alias h='hoogle --color --count=30'
type -P dolphin  &> /dev/null && alias d='dolphin . &> /dev/null'

type -P git &> /dev/null && {
    alias g='git'
    alias gs='git s' # damn ghostscript; this typo happened view times to many
    complete -o bashdefault -o default -o nospace -F _git g
}

type -P thg &> /dev/null && {
  alias hgl='thg log'
  alias hgc='thg commit'
  alias hgv='thg shelve'
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
  grailsdir() {
    local version=$(grailsproject grails)
    local project=$(grailsproject directory)
    cd "$HOME/.grails/$version/projects/$project" && pwd
  }
}

type -P mvn &> /dev/null && {
  export MAVEN_OPTS="-Xms256m -Xmx512m"
}

type -P pacman &> /dev/null && {
  alias pu='sudo pacman --sync --refresh --sysupgrade'
  type -P packer &> /dev/null && alias pu='packer -Syu'

  alias paclog='less +G /var/log/pacman.log'
  alias pacfiles="find /etc -name '*\.pac*' 2> /dev/null"
  pacedit() { sudo $EDITOR /etc/$1; }
  pacrm() { sudo rm --interactive /etc/$1.pacnew; }
  type -P meld &> /dev/null && {
    pacmeld() { meld /etc/$1{,.pacnew} 2> /dev/null & }
  }

  pacman-ls-updates() {
    ls --time-style=iso -lrt /var/lib/pacman/local
  }

  alias psp='sudo pacman --sync'
  alias prs='sudo pacman --remove --recursive'
  alias pss='pacman --sync --search'
  alias psi='pacman --sync --info'
  alias pqs='pacman --query --search'
  alias pqi='pacman --query --info --info'
  alias pql='pacman --query --list'
  alias pqo='pacman --query --owns'
  alias pqm='pacman --query --foreign'
  alias pdt='pacman --query --deps --unrequired'
}

cd_alias() {
  local name="$1"
  local dir="$2"

  [[ -d "$dir" ]] && {
    # example:
    # ct() { cd "/tmp"; }
    eval "$name() { cd \"$dir/\$1\"; }"
    # example:
    # _ct() {
    #   local cur="${COMP_WORDS[COMP_CWORD]}"
    #   COMPREPLY=($(cd "/tmp" && compgen -d "$cur"|sort))
    # }
    eval """
_$name() {
  local cur=\"\${COMP_WORDS[COMP_CWORD]}\"
  COMPREPLY=(\$(cd \"$dir\" && compgen -d \"\$cur\"|sort))
}
"""
    complete -o nospace -S '/' -F "_$name" "$name"
  }
}

cd_alias cw "$HOME/workspace"
cd_alias ct /tmp
