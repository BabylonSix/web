
function op() {

# Is project a node project?
if [[ -d node_modules ]]; then # If node_modules folder is present

echo start node project
# Open current directory in atom
ot .

function atom() {
# Move atom Text to right side of screen
osascript <<EOF
tell application "Atom"
	activate
	delay 0.5 -- give application time to open
end tell
tell application "System Events" to tell application process "Atom"
	try
		get properties of window 1
		set size of window 1 to {960, 1200}
		set position of window 1 to {960, 1}
	end try
end tell
EOF
}
atom & # immediately invoke atom() as background process

function chrome() {
# Move Google Chrome to right side of screen
osascript <<EOF
tell application "Google Chrome"
	activate
	delay 0.6 -- give application time to open
end tell
tell application "System Events" to tell application process "Google Chrome"
	try
		get properties of window 1
		set size of window 1 to {960, 1200}
		set position of window 1 to {1, 1}
	end try
end tell
EOF
}
chrome & # immediately invoke chrome() as background process

# Start gulp process
gulp


# is project a middleman project?
elif [[ -a GemFile ]]; then # If GemFile is present

	# Start middleman server
	(bundle exec middleman server) &

	echo start ruby project
	# Open current directory in atom
	ot .

function atom() {
# Move atom Text to right side of screen
osascript <<EOF
tell application "Atom"
	activate
	delay 0.5 -- give application time to open
end tell
tell application "System Events" to tell application process "Atom"
	try
		get properties of window 1
		set size of window 1 to {960, 1200}
		set position of window 1 to {960, 1}
	end try
end tell
EOF
}
atom & # immediately invoke atom() as background process

function chrome() {
# Move Google Chrome to right side of screen
osascript <<EOF
tell application "Google Chrome"
	delay 10 -- give application time to open
	activate
	set theURL to "http://localhost:4567"
	open location theURL
end tell
tell application "System Events" to tell application process "Google Chrome"
	try
		get properties of window 1
		set size of window 1 to {960, 1200}
		set position of window 1 to {1, 1}
	end try
end tell
EOF
}
chrome & # immediately invoke chrome() as background process


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
