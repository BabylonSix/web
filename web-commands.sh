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
	kp 3000 3002 3004 3006 3008 3010 3012 3014 3016 3018 3020 3022 3024 3026 3028 3030 3032 3034 3036 3038 3040 3042 3044 3046 3048 3050 3052 3054 3056 3058 3060 3062 3064 3066 3068 3070 3072 3074 3076 3078 3080 3082 3084 3086 3088 3090 3092 3094 3096 3098 3100
	print '\n${RED}killed all used ports${NC}'
}