# abbreviations
# abbr --add custom original
abbr --add cat bat
abbr --add c clear
abbr --add rm trash
abbr --add mkdir 'mkdir -p -v'
abbr --add .. prevd
abbr --add update 'topgrade'
abbr --add gitl _fzf_search_git_log
abbr --add gits _fzf_search_git_status

# alias functions

# ls -> eza
function ls --wraps='eza --git --header -l --no-quotes -a --git --no-user --time-style relative --hyperlink --icons=always --color=always' --description 'alias ls=eza ...'
    eza --git --header -l --no-quotes -a --git --no-user --time-style relative --hyperlink --icons=always --color=always $argv
end

# fastfetch clear
function fastfetch --description 'clear the terminal and run fastfetch'
    clear
    command fastfetch $argv
end

# ssh pi and clear
function pi --description 'ssh pi and clear'
    clear
    command ssh pi $argv
end