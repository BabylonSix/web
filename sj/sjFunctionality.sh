function sjo() {
# open simple javascript project 

# import sj commands
sjFunctionality

if [[ -a .sj ]]; then  	# If hidden .sj identifier file is present
	subl .               	# open directory in text editor
	sjMoveRight          	# move project right
	sjrun

else
	# Print Error
	# print -P prints to prompt with color
	print '\n${RED}ERROR:${NC}'
	print '\n  You tried opening a simple javascript project.'
	print '\n  This is not a simple javascipt project!'
	print '\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} command to create a new project.'
	print '\n  Existing projects have a hidden .sj identifier file.'
fi
}



function sjFunctionality() {
# Wrapper function for all simple javascript funcitonality

function sjMoveRight() {
# move project rightz

osascript <<EOF
tell application "Sublime Text"
	activate
	delay .2 -- give application time to open
end tell

tell application "System Events" to tell application process "Sublime Text"
	try
		get properties of window 1
		set size of window 1 to {640, 945}
		set position of window 1 to {1920, 0}
	end try
end tell

tell application "Google Chrome"
	activate
	delay .2 -- give application time to open
end tell

tell application "System Events" to tell application process "Google Chrome"
	try
		get properties of window 1
		set size of window 1 to {640, 472}
		set position of window 1 to {1920, 969}
	end try
end tell
EOF
}


function open_devtools() {
osascript <<EOF
delay 1
tell application "System Events" to tell application process "Google Chrome"
	try
		keystroke "j" using {option down, command down}
		delay .38
		keystroke "r" using {command down}
	end try
end tell

tell application "Sublime Text"
	activate
end tell
EOF
}



function sjrun() {

(jade -w --pretty *.jade) | (open_devtools) | (browser-sync start --server --files="*.jade,js/*.js")
}

}
