#-*-Shell-Script-*-

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function __prompt_command {
    local -r laststatus=$?

    # https://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
    local -r iwhite='\[\e[0;97m\]'
    local -r ired='\[\e[0;91m\]'
    local -r red='\[\e[1;31m\]'
    local -r green='\[\e[1;32m\]'
    local -r yellow='\[\e[1;33m\]'
    local -r coloroff='\[\e[0m\]'

    if [[ $laststatus == 0 ]]; then
        local -r statuscolor="${iwhite}"
    else
        local -r statuscolor="${ired}"
    fi
    local -r cwd='\W'
    local -r gitps1=$(__git_ps1 "$red (%s)")

    PS1="${statuscolor}${laststatus} ${green}[${yellow}${cwd}${gitps1}${green}]\$${coloroff} "
}
export PROMPT_COMMAND=__prompt_command

function source-if {
    local -r file="$1"
    [[ -f "$file" ]] && source "$file"
    return 0
}
source-if /usr/share/git/completion/git-completion.bash
source-if /usr/share/git/completion/git-prompt.sh
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

source-if /etc/profile.d/autojump.bash
source-if ~/.napalm/profile

function add-to-path {
    local -r dir=$(realpath --strip --canonicalize-missing "$1")
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$PATH:$dir"
    fi
    return 0
}
add-to-path ~/bin
add-to-path ~/Dropbox/bin
add-to-path ~/workspace/dotfiles/bin
add-to-path ~/workspace/poly-devel/bin
add-to-path ~/workspace/devilish/bin
add-to-path ~/.cabal/bin
add-to-path ~/.cask/bin
add-to-path ~/lib/visualvm
have gem && add-to-path "$(ruby -rubygems -e 'puts Gem.user_dir')/bin"


# modified commands
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias less='less --ignore-case'

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
alias 7mms='xdg-open ~/Documents/health/7mms.png &'
alias gmailbackup='gmvault sync --db-dir ~/Documents/backup/gmvault-db bezjak.miro@gmail.com'
t() {
    local -r ext=$1
    tree --prune -P '*.'$ext
}
backup() { cp --verbose --archive "$1" "$1"-$(date +%Y%m%d-%H%M%S); }
org-notes-backup() {
    cd ~/Dropbox/notes
    git commit --message='Automated backup'
}

# command dependent
have emacs    && alias e='emacs'
have ack-grep && alias ack='ack-grep'
have hoogle   && alias h='hoogle --color --count=30'
have dolphin  && alias d='dolphin . &> /dev/null'

[[ -z "$JAVA_HOME" && -d /usr/lib/jvm/default ]] && {
    export JAVA_HOME=/usr/lib/jvm/default
}

have git && {
    alias g='git'
    alias gs='git s' # damn ghostscript; this typo happened few times too many
    complete -o bashdefault -o default -o nospace -F _git g
}

have thg && {
    alias hgl='thg log'
    alias hgc='thg commit'
    alias hgv='thg shelve'
}

have grails && {
    export GRAILS_OPTS="-XX:MaxPermSize=512m -Xmx1024M -server"

    alias grails=run-grails
    alias gc='grails clean'
    alias gp='grails package'
    alias gpn='grails package --non-interactive'
    alias gt='grails test-app'
    alias gr='grails run-app'
    alias gr-sql='grails -Dlogsql=true run-app'
}

have gradle && {
    alias gradle=run-gradle
}

have mvn && {
    export MAVEN_OPTS="-Xms256m -Xmx512m"
}

have go && {
    export GOPATH=~/lib/gocode
    add-to-path $GOPATH/bin
}

have systemctl && {
    alias s='sudo systemctl'
    alias sj='sudo journalctl'
}

have pacman && {
    alias pu='sudo pacman --sync --refresh --sysupgrade'
    have packer && alias pu='packer -Syu'

    alias paclog='less +G /var/log/pacman.log'
    alias pacfiles="find /etc -name '*\.pac*' 2> /dev/null"
    pacedit() { sudo $EDITOR /etc/$1; }
    pacrm() { sudo rm --interactive /etc/$1.pacnew; }
    have meld && {
        pacmeld() { meld /etc/$1{,.pacnew} 2> /dev/null & }
    }

    pacman-ls-updates() {
        ls --time-style=iso -lrt /var/lib/pacman/local
    }
    pacman-installed() {
        sort <(pacman -Qe | awk '{print $1}') <(pacman -Q -g base -g base-devel | awk '{print $2}') | uniq -u
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

    function pqb { pacman --query --list "$1" | grep --color=never /usr/bin; }
    function pqf {
        pacman --query --list "$1"       | \
            grep -v /usr/share/man/      | \
            grep -v /usr/share/locale/   | \
            grep -v /usr/share/licenses/ | \
            grep -v /usr/include/
    }
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


# randomized learning
# http://lifehacker.com/how-can-i-quickly-learn-terminal-commands-1494082178
whatis $(ls /usr/bin | shuf -n 1)
