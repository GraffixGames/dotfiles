function fish_prompt --description 'Write out the prompt'
    set -l color_user
    set -l color_cwd
    set -l suffix
    set -l prompt_base_pwd (basename $PWD)

    switch "$USER"
        case root toor
            set color_user $fish_color_user
            
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end

            set suffix '#'
        case '*'
            if [ $USER = $prompt_base_pwd ]
                set prompt_base_pwd '~'
            end
            set color_user $fish_color_user
            set color_cwd $fish_color_cwd
            set suffix '$'
    end


    # User
    echo -n -s [ (set_color $color_user) "$USER" (set_color normal)

    # Host
    echo -n -s @ (prompt_hostname) ' '

    # PWD
    echo -n -s (set_color $color_cwd) $prompt_base_pwd (set_color normal)

    # Git
    __terlar_git_prompt

    echo -n -s "]$suffix "
end
