module npm {
	def "nu-complete npm run scripts" [] {
		open package.json | get scripts | transpose key value | get key
	}

	def "nu-complete npm uninstall package" [] {
	 	let dependencies = (open package.json | get dependencies | transpose package version | get package)
		let devDependencies = (open package.json | get devDependencies | transpose package version | get package)
		return $dependencies | append $devDependencies  	 	 
	}

	export extern "npm run" [
		run?: string@"nu-complete npm run scripts" # run npm scripts
	]

	export extern "npm uninstall" [
		uninstall?: string@"nu-complete npm uninstall package"
	]
}
