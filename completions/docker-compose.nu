module docker-compose {
	def "nu-complete docker compose available services" [] {
		open (ls docker-compose*).0.name | get services | transpose key value| get key
	}

	def "nu-complete docker compose running services" [] {
		docker compose ps | detect columns | get service
	}

	export extern "docker compose up" [
		service?: string@"nu-complete docker compose available services" 
		--detach(-d)  # Run the code in detach mode
	]

	export extern "docker compose stop" [
		service?: string@"nu-complete docker compose running services" 
	]

}

