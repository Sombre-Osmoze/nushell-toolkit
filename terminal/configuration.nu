

$env.EDITOR = "notepad"
$env.VISUAL = "notepad"

# Prompt

use shell.nu dashboard

$env.PROMPT_COMMAND = {|| dashboard create_left_prompt }

# Zoxide

source ~/.zoxide.nu

# Configuration

$env.config.show_banner = false


## Custom
source ../commands.nu
source ../completions.nu

# Aliases
source ./aliases.nu

# OS specific
if (sys host | get name) =~ 'Windows' {
	source ./windows.nu
}

