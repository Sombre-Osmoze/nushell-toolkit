
export module path_widget {
    export def is_needed [] {
        true # TODO: Support when file/directory has been deleted
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
