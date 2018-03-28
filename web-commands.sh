# Run simple HTTP server
server() {
	local ports="${1:-8000}"
	open "http://localhost:${port}/"
	python SimpleHTTPServer "$port"
}



# kill ports
kp() {
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
			# silence output of errors
			for pkPort in "$@"
				do
					lsof -i TCP:$pkPort | grep LISTEN | awk '{print $2}' | xargs kill -9 > /dev/null 2>&1
				done
		)
	fi
}

kpa() {
	kp 3000 3002 3004 3006 3008 3010 3012 3014 3016 3018 3020
	print '\n${RED}killed ports 3000-3020${NC}'
}