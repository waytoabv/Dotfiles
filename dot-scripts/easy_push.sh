#!/bin/bash

# Define directories and files
DOTFILES_DIR="$HOME/Dotfiles"

# Function to display a loading bar
show_loading() {
    local -r message="$1"
    local -r duration="${2:-5}"

    echo -n "$message"
    for ((i = 0; i < duration; i++)); do
        sleep 1
        echo -n "."
    done
    echo
}

# Navigate to the Dotfiles directory
cd "$DOTFILES_DIR" || { echo "Directory $DOTFILES_DIR does not exist."; exit 1; }

# Add all changes to the staging area
echo "Staging changes..."
git add .

# Prompt for a commit message
read -p "Enter commit message: " COMMIT_MSG

# Display loading message and execute commit
show_loading "Committing changes"

if git commit -m "$COMMIT_MSG"; then
    echo "Commit successful."
else
    echo "Commit failed. Please check the errors above."
    exit 1
fi

# Display loading message and execute push
show_loading "Pushing to remote"

if git push origin main; then
    echo "Push successful."
else
    echo "Push failed. Please check the errors above."
    exit 1
fi

echo "Operation completed successfully."
