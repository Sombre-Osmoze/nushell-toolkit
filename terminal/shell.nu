use ../library/paths.nu directory

module git_widget {
    export def is_needed [tree: list<path>]: nothing -> bool {
        let gitFolders = $tree | each { |dir| 
            let git_dir = ($dir | path join '.git')
            if ($git_dir | path exists) { $dir }
        } | compact
        $gitFolders | is-not-empty
    }

    export def letft_prompt []: nothing -> string {
        let reference_name = git rev-parse --abbrev-ref HEAD
        $" ($reference_name)"
    }
}
use git_widget



export module dashboard {
    export def create_left_prompt []: nothing -> string {
        # Get the current working directory tree.
        let tree = directory tree $env.PWD

        mut widgets = []

        if (git_widget is_needed $tree.path) {
            $widgets = ($widgets | append (git_widget letft_prompt))
        }


        mut home = ""
        try {
            if $nu.os-info.name == "windows" {
                $home = $env.USERPROFILE
            } else {
                $home = $env.HOME
            }
        }

        let dir = ([
            ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
            ($env.PWD | str substring ($home | str length)..)
        ] | str join)

        let path_segment = if (is-admin) {
            $"(ansi red_bold)($dir)"
        } else {
            $"(ansi red_bold)(basename $env.PWD)"
        }
        $widgets = ($widgets | append $path_segment)


        $widgets | str join "\n"
    }

}