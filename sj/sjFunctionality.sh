sjo() {
# open simple javascript project 


if [[ ! -z $1 ]]; then      # if sjo was given an argument
	if [[ -a $1/.sj ]]; then         # and it's a sj project
		cd $1 || exit; sjOpenProject;  # open the project
	else                             # otherwise
		sjError                        # Print Error
	fi

else                       # if sjo was NOT given an argument
	if [[ -a .sj ]]; then            # but the folder we're in is an sj project
		sjOpenProject                  # open the sj project
	else                             # otherwise
		sjError                        # Print Error
	fi
fi
}



sjError() {
	# Print Error
	print '\n${RED}ERROR:${NC}'
	print '\n  You tried opening a simple javascript project.'
	print '\n  This is not a simple javascipt project!'
	print '\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} command to create a new project.'
	print '\n  Existing projects have a hidden .sj identifier file.'
}



sjOpenProject() {
# Wrapper function for all simple javascript funcitonality

# open currecnt directory in text editor
ot .

sjMoveRight() {
# move project rightz

osascript <<EOF
moveEditor()
moveBrowser()


on moveEditor()
	tell application "${EDITOR}"
		activate
		repeat until application "${EDITOR}" is running
			delay .1 -- give application time to open
		end repeat
	end tell

	tell application "System Events" to tell application process "${EDITOR}"
		try
			get properties of window 1
			set size of window 1 to {$w1_3, $h2_3}
			set position of window 1 to {$w2_3, 0}
		end try
	end tell
end moveEditor

on moveBrowser()
	tell application "Google Chrome"
		activate
		repeat until application "Google Chrome" is running
			delay .1 -- give application time to open
		end repeat
	end tell

	tell application "System Events" to tell application process "Google Chrome"
		try
			get properties of window 1
			set size of window 1 to {$w1_3, $h1_3}
			set position of window 1 to {$w2_3, $h2_3}
		end try
	end tell
end moveBrowser
EOF
}; sjMoveRight &


open_devtools() {
osascript <<EOF
delay 10
tell application "System Events" to tell application process "Google Chrome"
	try
		keystroke "j" using {option down, command down}
		delay .9
		keystroke "r" using {command down}
	end try
end tell

tell application "${EDITOR}"
	activate
end tell
EOF
};



sjrun() {
(jade -w --pretty *.jade) | (open_devtools) | (browser-sync start --server --files="*.jade,js/*.js")
}; sjrun
} # end sjOpenProject
