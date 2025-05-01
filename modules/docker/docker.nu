use std log
module docker {
    



    def "nu-complete docker stop container" [context: string] {
        let runningContainers = (docker ps | from ssv)
        log info $context
        $runningContainers | get "CONTAINER ID"
    }
    export extern "docker stop" [
        ...stop: string@"nu-complete docker stop container"
    ]
}