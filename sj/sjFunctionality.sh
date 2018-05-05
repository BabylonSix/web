sjo() {
	# open simple javascript project 

	sjLogic(){
		if [[ ! -z $1 ]]; then             # if sjo was given an argument
			if [[ -a $1/.sj ]]; then         # and it's a sj project
				cd $1 || exit; sjOpenProject;  # open the project
			else                             # otherwise
				sjError; sjCantOpen            # Print Error
			fi

		else                               # if sjo was NOT given an argument
			if [[ -a .sj ]]; then            # but the folder we're in is a sj project
				sjOpenProject                  # open the sj project
			else                             # otherwise
				sjError; sjCantOpen            # Print Error
			fi
		fi
	} # end sjLogic

	sjOpenProject() { # start sjOpenProject
		# open current directory in text editor
		ot .

		sjrun() {
		(pug -w --pretty ./src/index.pug -o ./build/) |
		(stylus --sourcemap -w ./src/styles/*.styl -o ./src/css) |
		(postcss -w ./src/css/*.css --use autoprefixer -d ./build/css) |
		(babel -w ./src/js -d ./build/js) |
		(browser-sync start --server --files="./src/**/*.pug, ./src/js/**/*.js, ./src/**/*.styl" --serveStatic="./build" --browser="${BROWSER}")
		}; sjrun
	} # end sjOpenProject

	#run sjLogic
	sjLogic $1
}




sjb() {
	# branch simple javascript project 

	# TODO:
	# 1) Single Argument Logic
	# 2) Two Argument Logic
	# 3) uncomment # ot .

	sjLogic(){
		if [[ $# -lt 3 ]]; then # when less than 3 arguments are entered
			case $# in
				'0') # for zero arguments
					sjError; sjCantBranch
					;;
				'1') # for one arguments
					if [[ -a ./.sj ]]; then
						# if active directory has .sj file
						# create sj project branch
						# otherwise
						# print error
					else
						sjError; sjCantBranch
					fi
					;;
				'2') # for two arguments
					if [[ -a $1/.sj ]]; then
						# if arg1 is sj project
						# create sj project branch in arg2 location
						# otherwise
						# Print Error
					else
						sjError; sjCantBranch
					fi
					;;
			esac
		else
			sjError; sjCantBranch
		fi
	} # end sjLogic


	sjBranch() { # start sjBranch
		sjbranch() {

		}; sjbranch

	# 3rd TODO item
	# open current directory in text editor
	# ot .
	} # end sjBranch




	#run sjLogic
	sjLogic $@
}