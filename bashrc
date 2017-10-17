#-*-Shell-Script-*-

# don't do anything if not running interactively
[[ $- != *i* ]] && return

function __prompt_command {
    # https://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
    local -r iwhite='\[\e[0;97m\]'
    local -r ired='\[\e[0;91m\]'
    local -r red='\[\e[1;31m\]'
    local -r green='\[\e[1;32m\]'
    local -r yellow='\[\e[1;33m\]'
    local -r coloroff='\[\e[0m\]'

    if [[ $__laststatus == 0 ]]; then
        local -r statuscolor="${iwhite}"
    else
        local -r statuscolor="${ired}"
    fi
    local -r cwd='\W'
    local -r gitps1=$(__git_ps1 "$red (%s)")

    PS1="${statuscolor}${__laststatus} ${green}[${yellow}${cwd}${gitps1}${green}]\$${coloroff} "
}
function cd-alias {
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
function source-if {
    local -r file="$1"
    [[ -f "$file" ]] && source "$file"
    return 0
}
function add-to-path {
    local -r dir=$(realpath --strip --canonicalize-missing "$1")
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$PATH:$dir"
    fi
    return 0
}

source-if /usr/share/git/completion/git-completion.bash
source-if /usr/share/git/completion/git-prompt.sh
source-if /etc/profile.d/autojump.bash
source-if ~/.napalm/profile

add-to-path ~/bin
add-to-path ~/Dropbox/bin
add-to-path ~/workspace/dotfiles/bin
add-to-path ~/workspace/poly-devel/bin
add-to-path ~/workspace/devilish/bin
add-to-path ~/.local/bin
add-to-path ~/.cabal/bin
add-to-path ~/.npm-packages/bin
add-to-path ~/lib/visualvm
have gem && add-to-path "$(ruby -rubygems -e 'puts Gem.user_dir')/bin"

cd-alias cw      "$HOME/workspace"
cd-alias ct      /tmp
cd-alias dropdir "$HOME/Dropbox"

export EDITOR='emacs --no-window-system'
export VISUAL='emacs --no-window-system'
HISTCONTROL=ignoreboth # ignorespace + ignoredups
HISTFILESIZE=1000000   # 1M
HISTSIZE=10000         # 10k
# compatibility with existing PROMPT_COMMAND for autojump (man autojump)
PROMPT_COMMAND="__laststatus=\$?; ${PROMPT_COMMAND:+$PROMPT_COMMAND ;} __prompt_command"
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto

# modified commands
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias less='less --ignore-case'
alias vi='vim'

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
alias pg='ps -Afww | grep -i'
alias k='kill -9'
alias touchall='find -type f -exec touch {} \;'
alias gmailbackup='gmvault sync --db-dir ~/Documents/backup/gmvault-db bezjak.miro@gmail.com'
function openports { ss --tcp --processes "$@" | sed '1d' | column -t; }
function t {
    local -r ext=$1
    tree --prune -P '*.'$ext
}
function backup { cp --verbose --archive "$1" "$1"-$(date +%Y%m%d-%H%M%S); }
function org-notes-backup {
    cd ~/Dropbox/notes
    git commit --message='Automated backup'
}
function dropconfl { cd ~/Dropbox && find -iname '*conflict*'; }
function fcat {
    local -r search="$1"
    local -r result=$(files "$search" | head -n 1)
    if [[ -n "$result" ]]; then
        echo "cat $result"
        cat "$result"
    else
        echo "No file matching: $search"
    fi

    return 0
}


# http://www.nurkiewicz.com/2012/09/accessing-clipboard-in-linux-terminal.html
alias ctrlc='xclip -selection c'
alias ctrlv='xclip -selection c -o'

# command dependent
have dolphin && alias d='dolphin . &> /dev/null &'

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
    export GRAILS_OPTS="-XX:MaxPermSize=1G -Xmx2G -server"

    alias grails=run-grails
    alias gc='grails clean'
    alias gp='grails package'
    alias gpn='grails package --non-interactive'
    alias gt='grails test-app'
    function gr {
        local opts=
        while [[ -n "$1" ]]; do
            if [[ "$1" == sql ]]; then
                opts="$opts -Dlogsql=true"
            elif [[ "$1" == siesta ]]; then
                opts="$opts -Dgrails.env=siesta_test"
            elif [[ "$1" =~ ^port=.+$ ]]; then
                opts="$opts -Dserver.port=${1#port=}"
            else
                opts="$opts $1"
            fi
            shift
        done

        if [[ -n "$opts" ]]; then
            echo "Using opts =$opts"
        fi

        run-grails $opts run-app
    }
}

have gradle && {
    alias gradle=run-gradle
}

have sbt && {
    export SBT_OPTS="-Xmx4g -XX:MaxPermSize=1g"
}

have boot && [[ $(java-major-version) = 7 ]] && {
    # suggested: https://github.com/boot-clj/boot/wiki/JVM-Options
    export BOOT_JVM_OPTIONS='-XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled'
}

have go && {
    export GOPATH=~/lib/gocode
    add-to-path $GOPATH/bin
}

have systemctl && {
    alias s='sudo systemctl'
    alias sg='systemctl -a list-units'
    alias sj='sudo journalctl'
}

have pacman && {
    alias pu='sudo pacman --sync --refresh --sysupgrade && sudo aura --aursync --delmakedeps --diff --sysupgrade'

    alias paclog='less +G /var/log/pacman.log'
    alias pacfiles="find /etc -name '*\.pac*' 2> /dev/null"
    function pacedit { sudo $EDITOR /etc/$1; }
    function pacrm { sudo rm --interactive /etc/$1.pacnew; }
    function pacmeld { meld /etc/$1{,.pacnew} 2> /dev/null & }

    function pacman-ls-updates {
        ls --time-style=iso -lrt /var/lib/pacman/local
    }

    alias psp='sudo pacman --sync'
    alias prs='sudo pacman --remove --recursive'
    alias pss='pacman --sync --search'
    alias psi='pacman --sync --info --info'
    alias pqs='pacman --query --search'
    alias pqi='pacman --query --info --info'
    alias pas='aura --aursync --search'
    alias pai='aura --aursync --info'
    alias pab='aura --aursync --pkgbuild'
    alias pql='pacman --query --list'
    alias pqo='pacman --query --owns'
    alias pqm='pacman --query --foreign'
    alias pdt='pacman --query --deps --unrequired'
    alias pfl='pacman --files --list'
    alias pfo='pacman --files --owns'
    alias pfs='pacman --files --search'

    function pqb { pacman --query --list "$1" | grep --color=never /usr/bin; }
    function pqf {
        pacman --query --list "$1"       | \
            grep -v /usr/share/man/      | \
            grep -v /usr/share/locale/   | \
            grep -v /usr/share/licenses/ | \
            grep -v /usr/include/
    }
}


# randomized learning
# http://lifehacker.com/how-can-i-quickly-learn-terminal-commands-1494082178
whatis $(ls /usr/bin | shuf -n 1)
