# kube.nu

module kube {
	
	export-env {
		# retrieve all files in the current directory including "kubecconfig"
		let files = (ls | get name | where { |it| $it | str contains "kubeconfig" })
		if ($files | length) == 1 {
			print $"setup KUBECONFIG with ($files.0)"
			$env.KUBECONFIG = (realpath $files.0)	
		} else {
			echo "mutliple files found, which one do you want?"
		}
	}

	export def pods [] {
		kubectl get pods | detect columns
	}

	export def deploy [] {
		kubectl get deployment | detect columns
	}

	export def ingress [] {
		kubectl get ingress | detect columns
	}

	export def secrets [] {
		kubectl get secrets | detect columns
	}
}
