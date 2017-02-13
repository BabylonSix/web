sjo() {
# open simple javascript project 


if [[ ! -z $1 ]]; then             # if sjo was given an argument
	if [[ -a $1/.sj ]]; then         # and it's a sj project
		cd $1 || exit; sjOpenProject;  # open the project
	else                             # otherwise
		sjError                        # Print Error
	fi

else                               # if sjo was NOT given an argument
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

sjStartProject() {

osascript <<EOF
delay .5
moveEditor()
delay .5
moveBrowser()
delay .5
openDevTools()


on moveEditor()
	repeat until application "${EDITOR}" is running
		delay 2
	end repeat

	tell application "System Events" to tell application process "${EDITOR}"
		get properties of window 1
		set size of window 1 to {$w1_4, $h2_3}
		set position of window 1 to {$w3_4, 0}
	end tell

end moveEditor



on moveBrowser()

	tell application "Google Chrome"
		activate
		repeat until it is running
			delay .2
		end repeat

		if it is running then
			tell application "System Events" to tell application process "Google Chrome"
				try
					get properties of window 1
					set size of window 1 to {$w1_4, $h1_3}
					set position of window 1 to {$w3_4, $h2_3}
				end try
			end tell
		end if
	end tell

end moveBrowser




on openDevTools()

	tell application "Google Chrome"
		activate
	end tell

	tell application "System Events" to tell application process "Google Chrome"
		keystroke "j" using {option down, command down}
	  delay .8
	  keystroke "r" using {command down}
	end tell

	tell application "${EDITOR}"
		activate
	end tell

end openDevTools
EOF
}; sjStartProject &



sjrun() {
(pug -w --pretty ./**/*.pug) | (browser-sync start --server --files="./**/*.pug,js/**/*.js" --browser="Google Chrome")
}; sjrun
} # end sjOpenProject
