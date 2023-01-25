module npm {
	def "nu-complete npm run scripts" [] {
		open package.json | get scripts | transpose key value | get key
	}

	export extern "npm run" [
		run?: string@"nu-complete npm run scripts" # run npm scripts
	]
}
