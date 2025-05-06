use std/log

module gti {
	export def status [] {
		git status --porcelain | lines | parse "{status} {file}"				
	}


    # List all remotes available in the repository
	def "remote list" [] {
		git remote | lines
	}

    # List all references (branches, tags...) available in the repository
	# def "references list" [] {

	# }


    # Create a new branch from the remote default branch
	export def "branch base" [
		branch: string # Name of the new branch
		--base(-b): string  # Base reference (branch, tags...) to start from. Default to remote default branch.
		--remote(-r): string@"remote list" # The remote to use default to the first remote return by `git remote`.
	]: nothing -> nothing {
		# Remote to fetch or otherwise default remote of the rempository

		let $remote_to_fetch = if $remote != null { $remote } else { remote list | first }
		log debug $"using remote ($remote_to_fetch)"

		# Reference to start the branch from
		let reference = if $base != null { $base } else { 'HEAD'}
		log debug $"using base ($reference)"

		git fetch --quiet $remote_to_fetch $reference
		log debug $"fetched ($remote_to_fetch)/($reference)"

		git switch --create $branch --no-track $"($remote_to_fetch)/($reference)"
	}		
}
