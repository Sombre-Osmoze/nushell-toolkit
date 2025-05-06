module docker-compose {
	def "nu-complete docker compose available services" [] {
		open (ls docker-compose*).0.name | get services | transpose key value| get key
	}

	def "nu-complete docker compose running services" [] {
		docker compose ps | detect columns | get service
	}

	def "nu-complete docker compose commands" [] {
		["down", "up", "stop"]
	}

	def "nu-complete docker compose profiles" [] {
		open (ls docker-compose*).0.name | get services | transpose name values | get values.profiles | flatten | uniq
	}

	export extern "docker compose" [
		--profile(-p): string@"nu-complete docker compose profiles" 
		command: string@"nu-complete docker compose profiles"
	]

	export extern "docker compose up" [
		...service: string@"nu-complete docker compose available services"
		--detach(-d)  # Run the code in detach mode
		--wait(-w) # Wait for health checks
	]

	export extern "docker compose stop" [
		...service: string@"nu-complete docker compose running services"
	]

	export extern "docker compose down" [
		...service: string@"nu-complete docker compose available services"
		--volumes(-v)  # Remove volumes
	]

}

