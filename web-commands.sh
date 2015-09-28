
function op() {
if [[ -d node_modules ]] then # If node_modules folder is present

	# Open current directory in sublime
	ot .

	function sublime() {
	# Move Sublime Text to right side of screen
	osascript \
	-e	'tell application "Sublime Text" to activate' \
	-e	'delay 0.5 -- give application time to open' \
	-e	'tell application "System Events" to tell application process "Sublime Text"' \
	-e		'try' \
	-e			'get properties of window 1' \
	-e			'set size of window 1 to {960, 1200}' \
	-e			'set position of window 1 to {960, 1}' \
	-e		'end try' \
	-e	'end tell' \
	}
	sublime & # immediately invoke sublime() as background process

	function chrome() {
	# Move Google Chrome to right side of screen
	osascript \
	-e	'tell application "Google Chrome" to activate' \
	-e	'delay 0.6 -- give application time to open' \
	-e	'tell application "System Events" to tell application process "Google Chrome"' \
	-e		'try' \
	-e			'get properties of window 1' \
	-e			'set size of window 1 to {960, 1200}' \
	-e			'set position of window 1 to {1, 1}' \
	-e		'end try' \
	-e	'end tell' \
	}
	chrome & # immediately invoke chrome() as background process

 	# Start gulp process
	gulp

else # If node_modules folder is NOT present
	echo "error: this is not a web project! \nrun pi command if you want to create a new web project. \nexisting projects have a node_modules folder."
fi
}



# Check Can I Use site
alias ciu='caniuse'



# Gulp
alias gp='gulp'
alias gpd='gulp pd' # production deploy
alias pd='gulp pd'



# CodeKit
alias ck='open -a CodeKit'



# Browser Sync
alias bs='browser-sync'



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
	if [[ $# > 0 ]]; then

		# for each port in the arguments
		( # prevent global variables by running everything in a sub-shell
			# for Port# entered passed by the user,
			# add the following to pkPorts -i TCP:Port#
			for pkPort in $@
				do
					lsof -i TCP:$pkPort | grep LISTEN | awk '{print $2}' | xargs kill -9
				done
		)
	fi
}