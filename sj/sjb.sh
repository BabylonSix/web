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
				sjError.CantBranch
				;;
			'1') # for one arguments
				if [[ -a ./.sj ]]; then # if active directory has .sj file
					ga .
					gc 
					# create sj project branch
					# otherwise
					# print error
				else
					sjError.CantBranch
				fi
				;;
			'2') # for two arguments
				if [[ -a $1/.sj ]]; then # if arg1 is sj project
					# create sj project branch in arg2 location
					# otherwise
					# Print Error
				else
					sjError.CantBranch
				fi
				;;
		esac
	else
		sjError.CantBranch
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