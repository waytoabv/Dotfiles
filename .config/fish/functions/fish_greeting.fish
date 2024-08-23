function fish_greeting
    set random_number (awk 'BEGIN {srand(); print int(rand() * 100)}')

    # 1/100 chance
    if test "$random_number" -eq 0
        pokemon-colorscripts -r -s --no-title
        echo "No way, it's shiny!"
    else
        pokemon-colorscripts -r --no-title
    end
end
