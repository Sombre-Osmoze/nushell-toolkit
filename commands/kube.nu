# kube.nu

module kube {
	
	export-env {
		# retrieve all files in the current directory including "kubecconfig"
		let files = (ls | get name | where { |it| $it | str contains "kubeconfig" })
		if ($files | length) == 1 {
			print $"setup KUBECONFIG with ($files.0)"
			let-env KUBECONFIG = (realpath $files.0)	
		} else {
			echo "mutliple files found, which one do you want?"
		}
	}
}
