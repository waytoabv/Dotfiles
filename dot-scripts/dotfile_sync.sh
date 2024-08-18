#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/Dotfiles"
SCRIPTS_DIR="$HOME/.scripts"

# List of files or folders to sync
FILES=("skhd" "sketchybar" "iterm2" "aerospace" "borders" "btop" "fastfetch" "kitty" "yabai" "zed")

for file in "${FILES[@]}"; do
  if [ -e "$CONFIG_DIR/$file" ]; then
    echo "Syncing $file..."
    cp -r "$CONFIG_DIR/$file" "$DOTFILES_DIR/.config/"
  else
    echo "$file does not exist in $CONFIG_DIR, skipping..."
  fi
done

if [ -d "$SCRIPTS_DIR" ]; then
  echo "Syncing .scripts..."
  cp -r "$SCRIPTS_DIR" "$DOTFILES_DIR/"
else
  echo ".scripts does not exist, skipping..."
fi

echo "Sync completed."
