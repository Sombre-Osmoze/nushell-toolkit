module gti {
	export def status [] {
		git status --porcelain | lines | parse "{status} {file}"				
	}		
}
