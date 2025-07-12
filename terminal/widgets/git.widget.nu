

export module git_widget {
    export def is_needed [tree: list<path>]: nothing -> bool {
        let gitFolders = $tree | each { |dir| 
            let git_dir = ($dir | path join '.git')
            if ($git_dir | path exists) { $dir }
        } | compact
        $gitFolders | is-not-empty
    }

    export def letft_prompt []: nothing -> string {
        let reference_name = git branch --show-current
        $" ($reference_name)"
    }
}