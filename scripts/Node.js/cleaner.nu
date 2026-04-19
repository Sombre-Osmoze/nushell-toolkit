use std log

def "top level folders" [] {
    mut uniqueFolders: list = []

    let allFolders = (ls ./**/node_modules)

    for $folder in $allFolders {
        if ($uniqueFolders | any { |unique| $folder.name starts-with $unique.name }) == false {
            # $uniqueFolders =
            $uniqueFolders = ($uniqueFolders | append $folder)
        } 
    } 

    log debug $"total folders checked: ($allFolders | length)"
    log debug $"unique folders with node_modules: ($uniqueFolders | length)"

    return $uniqueFolders
}


def "keep only old folders" [folders: list] {
    mut olderFolders: list = []
    for $folder in $folders {
        let parentFolder = ls -d ( $folder.name | path dirname ) | sort-by modified | reverse | get 0
        if ($parentFolder.modified < (date now) - 24hr) {
            $olderFolders = $olderFolders | append $folder
        }
    }

    log debug $"folders not touched for a long time: ($olderFolders | length)"
    
    return $olderFolders
}


def main [
    mode: string = "list" # Choose if the cleaner must only list the file or delete them. (default `list`)
] {
    let folders = keep only old folders (top level folders)

    if ($folders | is-empty) {
        log info "no file to clean."
        exit
    }

    log info $"space to be cleaned: ($folders | get size | math sum)"


    if $mode == "deletion" {
        rm --trash --recursive ...($folders | get name)
    } else {
        $folders | sort-by size | reverse
    }
} 

