use ../library/paths.nu directory



use widgets/git.widget.nu git_widget
use widgets/path.widget.nu path_widget
use widgets/node.widget.nu node_widget


export module dashboard {
    export def create_left_prompt []: nothing -> string {
        # Get the current working directory tree.
        let tree = directory tree $env.PWD
        
        mut widgets = []
        if (git_widget is_needed $tree.path) {
            $widgets = ($widgets | append (git_widget letft_prompt))
        }

        let nodeWidgetParameters = node_widget load $tree.path

        if (nodeWidgetParameters.display) {
            $widgets = ($widgets | append (node_widget letft_prompt))
        }
        if (path_widget is_needed) {
            $widgets = ($widgets | append (path_widget letft_prompt))
        }
        $widgets | str join "\n"
    }
}
