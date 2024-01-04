#!/bin/bash

# Computer Specific Operations
if [ "$HOSTNAME" = "nuew" ]; then
    dfsub=prog
elif [ "$HOSTNAME" = "lyra" ]; then
    source ~/.local/share/cargo/env
elif [ "$HOSTNAME" = "thoth.cs.pitt.edu" ]; then
    dfsub=private
    source /opt/set_specific_profile.sh
fi

# VT Escape Sequences
FONT0="\e(" FONT1="\e)"
RESET="\e[0m" BRIGHT="\e[1m" DIM="\e[2m" UNDERSCORE="\e[4m" \
    BLINK="\e[5m" REVERSE="\e[7m" HIDDEN="\e[8m"
BLACK="\e[30m" RED="\e[31m" GREEN="\e[32m" YELLOW="\e[33m" \
    BLUE="\e[34m" MAGENTA="\e[35m" CYAN="\e[36m" WHITE="\e[37m"
BLACKBG="\e[40m" REDBG="\e[41m" GREENBG="\e[42m" YELLOWBG="\e[43m" \
    BLUEBG="\e[44m" MAGENTABG="\e[45m" CYANBG="\e[46m" WHITEBG="\e[47m"

# Shell Options
shopt -s autocd cdspell extglob globstar histappend no_empty_cmd_completion
set -o vi

# Environment
function ps1_maybe_ev {
    local ev=$?; [ $ev != 0 ] && echo -e " $ev"
}

export EDITOR=nvim PAGER='less -RM' SHELL=bash
export HISTSIZE=10000 HISTCONTROL=ignoredups
export PATH="$HOME/.local/bin:$PATH"
export MANPATH="$HOME/.local/share/man:$MANPATH"
export LD_LIBRARY_PATH="$HOME/.local/lib"
export PS1="\w"'$(ps1_maybe_ev)\$ ' PS2="> " PS3="% " PS4="+ "

export GPG_TTY=$(tty)
export LESSHISTFILE=-

# Aliases
alias RM='rm -rf'
alias cargo-fmt='rustup run nightly cargo fmt'
alias dig=drill
alias ip='ip -c'
alias less="$PAGER"
alias ls='ls -h --color=auto --group-directories-first'
alias lualatex='lualatex --shell-escape'
alias nc=ncat
alias open=xdg-open
alias pacsizes="pacman -Qi | awk '{ if (\$1 == \"Installed\") { print(\$4 \\
    substr(\$5, 0, 1)) } else if (\$1 == \"Name\") { printf(\"%-30s \", \$3) } 
    }' | sort -rhk2"
alias phase='curl -s http://wttr.in/Moon?m'
alias please='sudo -- "${SHELL:-bash}" -c "$(fc -ln -1)"'
alias rc="git --git-dir=$HOME/$dfsub/rc/ --work-tree=$HOME"
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
alias timestamp='date +%s%3N'
alias traceroute=tracepath
alias vim=nvim
alias weather='curl -s http://wttr.in/Pittsburgh?m'

# Functions
function define { # Get the definition of a word from Wiktionary
    curl -s "https://en.wiktionary.org/wiki/$1?action=raw" | \
        sed -f "$HOME/prog/wikifmt.sed"
}
function genpass { # Generate a random password
    local l=$1 c=$2
    [ "$l" == "" ] && l=24
    [ "$c" == "" ] && c="[:alnum:]"

    printf "%s\n" $(tr -dc $c < /dev/urandom | head -c $l)
}
function gendiceware { # Generate a diceware-style password
    local l=$1
    [ "$l" == "" ] && l=6

    sed "/'/d" /usr/share/dict/words | \
        shuf -rn ${l} --random-source=/dev/urandom | \
        tr [:upper:] [:lower:] | \
        sed -z 's/\n//g'
    echo
}
function savedvd { # Save an ISO of the inserted DVD to disk
    dd if=/dev/sr0 of=${1} bs=2048 count=$(isosize -d 2048 /dev/sr0) status=progress
}

# GCC Options
gcc_options='\
  --param=ssp-buffer-size=4 \
  -D_FORTIFY_SOURCE=2 \
  -Wl,--sort-common,--as-needed,-z,relro \
  -flto \
  -fstack-protector-strong \
  -march=native \
  -pipe \
'
gcc_release_options="$gcc_options -DNDEBUG -Ofast -Wl,-O1"
gcc_development_options="$gcc_options \
  -Og \
  -Wall \
  -Wcast-align \
  -Wcast-qual \
  -Wconversion \
  -Wdate-time \
  -Wdisabled-optimization \
  -Wduplicated-cond \
  -Wextra \
  -Wfloat-equal \
  -Wformat=2 \
  -Winline \
  -Wlogical-op \
  -Wmaybe-uninitialized \
  -Wmissing-declarations \
  -Wmissing-format-attribute \
  -Wmissing-include-dirs \
  -Wnormalized \
  -Wpacked \
  -Wpadded \
  -Wpedantic \
  -Wredundant-decls \
  -Wshadow \
  -Wstack-protector \
  -Wstrict-overflow=5 \
  -Wsuggest-attribute=const \
  -Wsuggest-attribute=format \
  -Wsuggest-attribute=noreturn \
  -Wsuggest-attribute=pure \
  -Wsuggest-final-methods \
  -Wsuggest-final-types \
  -Wswitch-default \
  -Wswitch-enum \
  -Wtrampolines \
  -Wundef \
  -Wuninitialized \
  -Wunsafe-loop-optimizations \
  -Wunused-parameter \
  -Wwrite-strings \
  -fdiagnostics-color=auto \
  -ggdb3 \
"
gcc_c_development_options="$gcc_development_options \
  -Wbad-function-cast \
  -Wmissing-prototypes \
  -Wnested-externs \
  -Wold-style-definition \
  -Wstrict-prototypes \
  -Wunsuffixed-float-constants \
"
gcc_cpp_development_options="$gcc_development_options \
  -Wsuggest-override \
  -Wuseless-cast \
  -Wzero-as-null-pointer-constant \
"
alias gcc="gcc -std=gnu11 $gcc_c_development_options"
alias gccrel="gcc -std=gnu11 $gcc_release_options"
alias g++="g++ -std=gnu++14 $gcc_cpp_development_options"
alias g++rel="g++ -std=gnu++14 $gcc_release_options"

# Programmable Completions
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

unset dfsub
