

export module node_widget {

    export def load [tree: list<path>]: nothing -> bool {
        let nodeFolders = $tree | each { |dir| 
            let git_dir = ($dir | path join 'package.json')
            if ($git_dir | path exists) { $dir }
        } | compact
        
        let hasNodeFolders = $nodeFolders | is-not-empty

        {
            display: $hasNodeFolders
            context: if ($hasNodeFolders) {
                { directory: $nodeFolders | get 0 }
            } else { null }
        }
    }


    def "package name" []: nothing -> string {
        
        # open package.json | get name
        "TBD"
    } 

    export def letft_prompt [context: <directory: path>]: nothing -> string {
        $"project: (package name)"
    }

}