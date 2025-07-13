
# export module environments {
    export def get-env [file: path = ".env"] {
        open $file | lines | where { |line| ($line | str starts-with "#") == false and ($line | is-not-empty) } | parse "{key}={value}" | transpose --as-record -r
    }
# }
