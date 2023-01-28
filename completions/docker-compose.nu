module docker-compose {
	def "nu-complete docker compose available services" [] {
		open docker-compose.yaml | get services | transpose key value| get key
	}

	def "nu-complete docker compose running services" [] {
		docker compose ps | detect columns | get service
	}

	export extern "docker compose" [
		up?: string@"nu-complete docker compose available services" # Run the code in detach mode
		stop?: string@"nu-complete docker compose running services"
		down?
	]

}

