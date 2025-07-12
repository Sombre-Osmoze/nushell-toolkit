use ../library/paths.nu directory



module path_widget {
    export def is_needed [] {
        true
    }

    export def letft_prompt []: nothing -> string {
        mut home = ""
        try {
            if $nu.os-info.name == "windows" {
                $home = $env.USERPROFILE
            } else {
                $home = $env.HOME
            }
        }

		let text = if ($env.PWD == $home) {
			"~"
		} else {
			$env.PWD | path basename
		}

        let path_segment = if (is-admin) {
            $"(ansi yellow_bold)($text)"
        } else {
            $"(ansi red_bold)($text)"
        }
        $path_segment
    }
}

use widgets/git.widget.nu git_widget
use path_widget


export module dashboard {
    export def create_left_prompt []: nothing -> string {
        # Get the current working directory tree.
        let tree = directory tree $env.PWD
        
        mut widgets = []
        if (git_widget is_needed $tree.path) {
            $widgets = ($widgets | append (git_widget letft_prompt))
        }
        if (path_widget is_needed) {
            $widgets = ($widgets | append (path_widget letft_prompt))
        }
        $widgets | str join "\n"
    }
}
