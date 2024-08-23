# Alias
# abbr --add original custom
abbr --add cat bat
abbr --add cd z
abbr --add c clear
abbr --add rm trash

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
starship init fish | source
enable_transience

# zoxide
zoxide init fish | source
