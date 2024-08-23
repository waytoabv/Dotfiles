

# Starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"

#---plugins and alias---

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# bat better cat
export BAT_THEME=Dracula
alias cat="bat"

# Eza better ls
alias ls="eza --git --header -l --no-quotes -a --git --no-user --time-style relative --hyperlink --icons=always --color=always"

# Activate Autocomplete
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Activate autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Activate syntax highlighting
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
