# zsh Options
setopt HIST_IGNORE_ALL_DUPS


# Custom zsh in dot-config/zsh
[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"
[ -f "$HOME/.config/zsh/iterm-tab-colors.zsh" ] && source "$HOME/.config/zsh/iterm-tab-colors.zsh"
[ -f "$HOME/.config/zsh/transient-prompt.zsh" ] && source "$HOME/.config/zsh/transient-prompt.zsh"
