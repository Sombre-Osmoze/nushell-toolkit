use std/log

module github-billing {

    def "parse report" [file: path] {
        open $file
        | group-by username
        | items { |user, rows|
            {
                username: $user,
                gross:    ($rows | get gross_amount    | each { into float } | math sum | math round --precision 2),
                discount: ($rows | get discount_amount | each { into float } | math sum | math round --precision 2),
                net:      ($rows | get net_amount      | each { into float } | math sum | math round --precision 2),
                by_sku: (
                    $rows
                    | group-by sku
                    | items { |sku, r| {
                        sku:      $sku,
                        quantity: ($r | get quantity    | each { into float } | math sum | math round --precision 2),
                        net:      ($r | get net_amount  | each { into float } | math sum | math round --precision 2),
                    }}
                    | sort-by net --reverse
                )
            }
        }
        | sort-by net --reverse
    }

    # Flat table: one row per user with gross, discount and net totals
    export def "github-billing summary" [
        file: path  # Path to the usageReport CSV file
    ] {
        parse report $file | select username gross discount net
    }

    # Flat table of every user + SKU combination with quantity and net cost
    export def "github-billing detail" [
        file: path  # Path to the usageReport CSV file
    ] {
        parse report $file
        | each { |row|
            $row.by_sku | insert username $row.username
        }
        | flatten
        | select username sku quantity net
    }

    # SKU breakdown for a single user
    export def "github-billing user" [
        file: path      # Path to the usageReport CSV file
        username: string # GitHub username to inspect
    ] {
        let matched = (parse report $file | where username == $username)
        if ($matched | is-empty) {
            log error $"User '($username)' not found in report"
            return null
        }
        $matched | first | get by_sku | select sku quantity net
    }
}

use github-billing *
