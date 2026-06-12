function set_kitty_tab_title() {
    export KITTY_TAB_TITLE="$(basename "$PWD")"
    echo -ne "\033]0; $(basename "$PWD") \007"
}
precmd_functions+=(set_kitty_tab_title)
