function sj() {

if [[ -z $1 ]]; then # check if argument is empty
	print -P '\n${RED}ERROR:${NC}'
	print -P '\nProject Name Missing' # if argument is empty
else
# if argument is not empty => create the project

PROJECT=$1

# Create Project Folder & jump it
md ./$PROJECT

# Generate simple project
d js

# Populate project
f index.jade
f ./js/library.js
f ./js/$PROJECT.js

# create hidden, 'sj' project identifier file
f .sj

# starter content
sjContent.index
sjContent.library


# Open in text editor > start jade watcher > start browser sync
ot .


# Move Project to the Left of the Screen
sjr


# subshell#1 watch jade + subshell#2 browser-sync server
sjrun

fi # close if statement
}


function sjContent.index() {
# Populate index.jade with starter content
cat <<EOF >> index.jade
body
	script(src='js/library.js')
	script(src="js/$PROJECT.js")
EOF
}


function sjContent.library() {
# Populate library.js with starter content
cat <<EOF >> ./js/library.js
function log(...x) {
	console.log(...x)
}

function table(...x) {
	console.table(...x)
}

function dir(...x) {
	console.dir(...x)
}

function w(...x) {
	document.writeln(...x)
}
EOF
}



function sjl() {
# move project left
function move_atom_left() {
osascript <<EOF
tell application "Atom"
	activate
	delay 1 -- give application time to open
end tell
tell application "System Events" to tell application process "Atom"
	try
		get properties of window 1
		set size of window 1 to {640, 945}
		set position of window 1 to {0, 0}
	end try
end tell
EOF
}; move_atom_left & # immediately invoke function


function move_chrome_left() {
osascript <<EOF
tell application "Google Chrome"
	activate
	delay 1 -- give application time to open
end tell
tell application "System Events" to tell application process "Google Chrome"
	try
		get properties of window 1
		set size of window 1 to {640, 472}
		set position of window 1 to {0, 969}
	end try
end tell
EOF
}; move_chrome_left & # immediately invoke function
}



function sjr() {
# move project right
function move_atom_right() {
osascript <<EOF
tell application "Atom"
	activate
	delay 1 -- give application time to open
end tell
tell application "System Events" to tell application process "Atom"
	try
		get properties of window 1
		set size of window 1 to {640, 945}
		set position of window 1 to {1920, 0}
	end try
end tell
EOF
}; move_atom_right & # immediately invoke function


function move_chrome_right() {
osascript <<EOF
tell application "Google Chrome"
	activate
	delay 1 -- give application time to open
end tell
tell application "System Events" to tell application process "Google Chrome"
	try
		get properties of window 1
		set size of window 1 to {640, 472}
		set position of window 1 to {1920, 969}
	end try
end tell
EOF
}; move_chrome_right & # immediately invoke function

}



function sjrun() {
# subshell#1 start jade watch with pretty output. subshell#2 browser sync server
(jade -w --pretty *.jade)|(browser-sync start --server --files="*.jade,js/*.js")

}


function osj() {
# open simple javascript project 

if [[ -a .sj ]]; then # If hidden .sj identifier file is present
	ot .                # open directory in text editor
	sjr                 # move project right
	sjrun               # start project

else
	# Print Error
	# print -P prints to prompt with color
	print -P "ERROR:"
	print -P "\n  This is not a simple javascipt project!"
	print -P "\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} command to create a new project."
	print -P "\n  Existing projects have a hidden .sj identifier file."
fi
}

# alias to open simple javascript projec
alias sjo='osj'
