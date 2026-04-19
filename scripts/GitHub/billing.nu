use std log

def "parse report" [file: path] {
    open $file
    | group-by username
    | items { |user, rows|
        {
            username: $user,
            gross:    ($rows | get gross_amount   | each { into float } | math sum | math round --precision 2),
            discount: ($rows | get discount_amount | each { into float } | math sum | math round --precision 2),
            net:      ($rows | get net_amount      | each { into float } | math sum | math round --precision 2),
            by_sku: (
                $rows
                | group-by sku
                | items { |sku, r| {
                    sku:      $sku,
                    quantity: ($r | get quantity   | each { into float } | math sum | math round --precision 2),
                    net:      ($r | get net_amount | each { into float } | math sum | math round --precision 2),
                }}
                | sort-by net --reverse
            )
        }
    }
    | sort-by net --reverse
}

# Analyse a GitHub billing usage CSV report
#
# Modes:
#   summary  — flat table: one row per user              (default)
#   detail   — per-user SKU breakdown
#   user     — SKU breakdown for a single user (requires --username)
#   json     — full data as JSON array
def main [
    file: path                  # Path to the usageReport CSV file
    --mode: string = "summary"  # Output mode: summary | detail | user | json
    --username: string = ""     # Filter to a specific user (used with --mode user)
] {
    let data = parse report $file

    match $mode {
        "summary" => {
            $data | select username gross discount net
        }
        "detail" => {
            $data | each { |row|
                $row.by_sku | insert username $row.username
            }
            | flatten
            | select username sku quantity net
        }
        "user" => {
            if ($username | is-empty) {
                log error "--username is required for mode 'user'"
                exit 1
            }
            let matched = ($data | where username == $username)
            if ($matched | is-empty) {
                log error $"User '($username)' not found in report"
                exit 1
            }
            $matched | first | get by_sku | select sku quantity net
        }
        "json" => {
            $data | to json
        }
        _ => {
            log error $"Unknown mode '($mode)'. Choose: summary | detail | user | json"
            exit 1
        }
    }
}
