

# Prompt

use shell.nu dashboard

$env.PROMPT_COMMAND = {|| dashboard create_left_prompt }

# Zoxide

source ~/.zoxide.nu

# Configuration

$env.config.show_banner = false