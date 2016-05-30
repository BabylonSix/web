# Run simple HTTP server
function server() {
	local ports="${1:-8000}"
	open "http://localhost:${port}/"
	python SimpleHTTPServer "$port"
}



# kill ports
function kp() {
	# if number of entered arguments is 0
	if [[ $# -eq 0 ]]; then
		echo 'Error: No parameters entered'
	fi

	# if number of entered arguments is > 0
	if [[ $# -gt 0 ]]; then

		# for each port in the arguments
		( # prevent global variables by running everything in a sub-shell
			# for Port# entered passed by the user,
			# add the following to pkPorts -i TCP:Port#
			for pkPort in "$@"
				do
					lsof -i TCP:$pkPort | grep LISTEN | awk '{print $2}' | xargs kill -9
				done
		)
	fi
}
