

$env.EDITOR = "micro"
$env.VISUAL = "micro"

# Prompt

use shell.nu dashboard

$env.PROMPT_COMMAND = {|| dashboard create_left_prompt }

# Zoxide

source ~/.zoxide.nu

# Configuration

$env.config.show_banner = false

## ls
$env.config.ls.clickable_links = true

## rm
$env.config.rm.always_trash = true

## table
$env.config.table.mode = 'rounded'
$env.config.table.show_empty = true

## history
$env.config.history.max_size = 1_000_000
$env.config.history.sync_on_enter = true
$env.config.history.file_format = 'sqlite'

## completions
$env.config.completions.case_sensitive = false
$env.config.completions.quick = true
$env.config.completions.partial = true
$env.config.completions.algorithm = 'fuzzy'
### completion externals
$env.config.completions.external.enable = true

## filesize
$env.config.filesize.unit = 'metric'
$env.config.filesize.precision = 2

## footer mode
$env.config.footer_mode = 'auto'

## Custom

source ../commands.nu
source ../completions.nu
source ../library/environments.nu

# Aliases
source ./aliases.nu

# OS specific
let host = sys host
print $host
if $host.name == 'Windows' {
	source ./windows.nu
}
#else if $host.name == 'Void' {
	source ./void.nu
#}

