# Alias
# abbr --add original custom
abbr --add cat bat
abbr --add cd z
abbr --add c clear
abbr --add rm trash
abbr --add .. prevd
abbr --add gitl _fzf_search_git_log
abbr --add gits _fzf_search_git_status

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
starship init fish | source
enable_transience

# zoxide
zoxide init fish | source
