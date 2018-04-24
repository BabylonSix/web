sjo() {
	# open simple javascript project 

	sjLogic(){
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
	} # end sjLogic


	sjError() {
		# Print Error
		print '\n${RED}ERROR:${NC}'
		print '\n  This is not a simple javascipt project!'
		print '\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} command to create a new project.'
		print '\n  Existing projects have a hidden .sj identifier file.'
	} # end sjError


	sjOpenProject() { # start sjOpenProject
		# open current directory in text editor
		ot .

		sjrun() {
		(pug -w --pretty ./src/index.pug -o ./build/) |
		(stylus --sourcemap -w ./src/styles/*.styl -o ./src/css) |
		(babel -w ./src/js -d ./build/js) |
		(browser-sync start --server --files="./src/**/*.pug, ./src/js/**/*.js, ./src/**/*.styl" --serveStatic="./build" --browser="${BROWSER}")
		}; sjrun
	} # end sjOpenProject

	#run sjLogic
	sjLogic $1
}