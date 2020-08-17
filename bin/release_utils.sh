#!/bin/bash

# Accepts the repository owner/name (wordpress-mobile/gutenberg-mobile) and returns
# the locally matching remote
function get_remote_name() {
    REPO="$1"
    git remote -v | grep "git@github.com:$REPO.git (push)" | grep -oE '^\S*'
}


# Utils adapted from https://github.com/Homebrew/install/blob/master/install.sh
if [[ -t 1 ]]; then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"


shell_join() {
    local arg
    printf "%s" "$1"
    shift
    for arg in "$@"; do
        printf " "
        printf "%s" "${arg// /\ }"
    done
}

ohai() {
  printf "${tty_blue}==> %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$1"
}

abort() {
    printf "\n${tty_red}%s${tty_reset}\n" "$1"
    exit 1
}

execute() {
    if ! "$@"; then
        abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
    fi
}


#####
# Confirm to Proceed Prompt
#####

# Accepts a single argument: a yes/no question (ending with a ? most likely) to ask the user
function confirm_to_proceed() {
    read -p "$1 (y/n) " -n 1
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        abort "Aborting release..."
    fi
}
