# kube.nu

module kube {
	
	export-env {
		# retrieve all files in the current directory including "kubecconfig"
		let files = (ls | get name | where { |it| $it | str contains "kubeconfig" })
		if ($files | length) == 1 {
			print $"setup KUBECONFIG with ($files.0)"
			$env.KUBECONFIG = ($files.0 | path basename)	
		} else if ($files | lenght) > 1 { 
			print "no file found"
			exit
		} else {
			echo "mutliple files found, which one do you want?"
		}
	}

	export def pods [] {
		kubectl get pods | from ssv
	}

	export def deploy [] {
		kubectl get deployment | from ssv
	}

	export def ingress [] {
		kubectl get ingress | from ssv
	}

	export def secrets [] {
		kubectl get secrets | from ssv
	}
}
