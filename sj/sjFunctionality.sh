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


sjOpenProject() { # start sjOpenProject
# open currecnt directory in text editor
ot .

sjrun() {
(pug -w --pretty ./index.pug) |
(stylus -w ./**/*.styl) |
(browser-sync start --server --files="./**/*.pug,js/**/*.js, ./**/*.styl" --browser="${BROWSER}")
}; sjrun
} # end sjOpenProject