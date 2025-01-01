# Set PATH, MANPATH, etc., for Homebrew
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -q MANPATH; or set MANPATH ''
set -gx MANPATH /opt/homebrew/share/man $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
set -gx PATH /Users/lukas/Library/Python/3.12/bin $PATH

# custom aliases
source ~/.config/fish/aliases.fish

# Default Editor
set -x EDITOR nano
set -x LESSHISTFILE /dev/null

# zoxide with alias cd
zoxide init --cmd cd fish | source

# starship
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
starship init fish | source
enable_transience
