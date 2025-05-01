export module directory {

    # List a directoy tree paths. 
    export def tree [
        of?: path # The directory to list. Default to the current working directory.
    ]: nothing -> table<name: string, path: path> {
        let directory = if $of != null { $of } else { $env.PWD }
        let parent_names = ($directory | path split)
        
        # Compute each tree node directory full path
        $parent_names | enumerate | reverse | each { |it|  
            {
                name: $it.item, 
                path: ($parent_names | first ($it.index + 1) | path join)
            }
        }
    }
}