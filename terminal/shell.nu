use ../library/paths.nu directory

module git_widget {
    export def letft_prompt []: nothing -> string {
        let reference_name = git rev-parse --abbrev-ref HEAD
        $" ($reference_name)"
    }
}



export module dashboard {
    export def create_left_prompt [] {
        # Get the current working directory tree.
        let tree = directory tree $env.PWD

        let left_widgets = [
            (git_widget letft_prompt)
        ]

        $left_widgets
        


        # mut home = ""
        # try {
        #     if $nu.os-info.name == "windows" {
        #         $home = $env.USERPROFILE
        #     } else {
        #         $home = $env.HOME
        #     }
        # }

        # let dir = ([
        #     ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        #     ($env.PWD | str substring ($home | str length)..)
        # ] | str join)

        # let path_segment = if (is-admin) {
        #     $"(ansi red_bold)($dir)"
        # } else {
        #     $"(ansi red_bold)(basename $env.PWD)"
        # }

        # $path_segment        
    }

}