# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

# Starship transient Prompt
precmd_functions=(zvm_init "${(@)precmd_functions:#zvm_init}")
precmd_functions+=(set-long-prompt)
zvm_after_init_commands+=("zle -N zle-line-finish; zle-line-finish() { set-short-prompt }")

set-long-prompt() {
    PROMPT=$(starship prompt)
    RPROMPT=""
}

export COLUMNS=$(($COLUMNS + ($COLUMNS*0.1)))
set-short-prompt() {
    # setting this doesn't seem to actually work
    PROMPT="$(STARSHIP_KEYMAP=${KEYMAP:-viins} starship module character)"
    RPROMPT=$'%{\e[999C%}\e[8D%F{8}%*%f ' # remove if you don't want right prompt
    zle .reset-prompt 2>/dev/null # hide the errors on ctrl+c
}

zle-keymap-select() {
    set-short-prompt
}
zle -N zle-keymap-select

zle-line-finish() { set-short-prompt }
zle -N zle-line-finish

trap 'set-short-prompt; return 130' INT


# Random Color iterm tabs
PRELINE="\r\033[A"

function random {
    echo -e "\033]6;1;bg;red;brightness;$((1 + $RANDOM % 255))\a"$PRELINE
    echo -e "\033]6;1;bg;green;brightness;$((1 + $RANDOM % 255))\a"$PRELINE
    echo -e "\033]6;1;bg;blue;brightness;$((1 + $RANDOM % 255))\a"$PRELINE
}

function color {
    case $1 in
    green)
    echo -e "\033]6;1;bg;red;brightness;80\a"$PRELINE     # Red brightness for green color
    echo -e "\033]6;1;bg;green;brightness;250\a"$PRELINE   # Green brightness (Dracula green: #50fa7b)
    echo -e "\033]6;1;bg;blue;brightness;123\a"$PRELINE    # Blue brightness for green color
    ;;
    red)
    echo -e "\033]6;1;bg;red;brightness;255\a"$PRELINE     # Red brightness (Dracula red: #ff5555)
    echo -e "\033]6;1;bg;green;brightness;85\a"$PRELINE    # Green brightness for red color
    echo -e "\033]6;1;bg;blue;brightness;85\a"$PRELINE     # Blue brightness for red color
    ;;
    orange)
    echo -e "\033]6;1;bg;red;brightness;255\a"$PRELINE     # Red brightness (Dracula orange: #ffb86c)
    echo -e "\033]6;1;bg;green;brightness;184\a"$PRELINE   # Green brightness for orange color
    echo -e "\033]6;1;bg;blue;brightness;108\a"$PRELINE    # Blue brightness for orange color
    ;;
    purple)
    echo -e "\033]6;1;bg;red;brightness;189\a"$PRELINE     # Red brightness (Dracula purple: #bd93f9)
    echo -e "\033]6;1;bg;green;brightness;147\a"$PRELINE   # Green brightness for purple color
    echo -e "\033]6;1;bg;blue;brightness;249\a"$PRELINE    # Blue brightness for purple color
    ;;
    *)
    random
    esac
}
color    #uncomment to enable automatically set random color when tab created

#---plugins---

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# bat better cat
export BAT_THEME=Dracula
alias cat="bat"

# Eza better ls
alias ls="eza --git --header -l --no-quotes -a --git --no-user --time-style relative --hyperlink --icons=always --color=always"

# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Activate syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
