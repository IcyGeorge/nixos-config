typeset -g KITTY_CURRENT_CMD=""

preexec() {
    local cmd=${${(z)1}[1]}

    if [[ "$cmd" != "zsh" ]]; then
        KITTY_CURRENT_CMD="$cmd"
        echo -ne "\033]0;${cmd}@$(basename "$PWD")\007"
    fi
}

precmd() {
    KITTY_CURRENT_CMD=""
    echo -ne "\033]0;$(basename "$PWD")\007"
}
