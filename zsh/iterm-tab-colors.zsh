# Move cursor to the beginning of the line
PRELINE="\r\033[A"

# Set tab color to a specified color in the Dracula palette
function set_color {
    case $1 in
    green)
        # Dracula green: #50fa7b
        echo -e "\033]6;1;bg;red;brightness;80\a"$PRELINE
        echo -e "\033]6;1;bg;green;brightness;250\a"$PRELINE
        echo -e "\033]6;1;bg;blue;brightness;123\a"$PRELINE
        ;;
    red)
        # Dracula red: #ff5555
        echo -e "\033]6;1;bg;red;brightness;255\a"$PRELINE
        echo -e "\033]6;1;bg;green;brightness;85\a"$PRELINE
        echo -e "\033]6;1;bg;blue;brightness;85\a"$PRELINE
        ;;
    orange)
        # Dracula orange: #ffb86c
        echo -e "\033]6;1;bg;red;brightness;255\a"$PRELINE
        echo -e "\033]6;1;bg;green;brightness;184\a"$PRELINE
        echo -e "\033]6;1;bg;blue;brightness;108\a"$PRELINE
        ;;
    purple)
        # Dracula purple: #bd93f9
        echo -e "\033]6;1;bg;red;brightness;189\a"$PRELINE
        echo -e "\033]6;1;bg;green;brightness;147\a"$PRELINE
        echo -e "\033]6;1;bg;blue;brightness;249\a"$PRELINE
        ;;
    *)
        # Randomly select one of the Dracula colors
        colors=("green" "red" "orange" "purple")
        random_color=${colors[$((RANDOM % ${#colors[@]}))]}
        set_color $random_color
        ;;
    esac
}

# Call the function with your desired color
# Example usage: set_color green
# Uncomment the line below to automatically set a random color on tab creation
set_color $(echo green red orange purple | tr ' ' '\n' | sort -R | head -n 1)
