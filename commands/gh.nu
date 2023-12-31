# gh.nu

use std log

def CloneOrganizationRepositories [organization: string, limit: int = 100] {
	# Fetching repositories
	let repositories = (gh repo list -L $limit --json name,url $organization | from json)
	log info $"Cloning ($repositories | length) repositories in: (pwd)"
	# Cloning
	$repositories | par-each { |repo|
		gh repo clone $repo.url -- --quiet
	    { name: $repo.name, result: "✔️" }
	}
}
