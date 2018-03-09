sj() {

# import sjContent
sjContent

if [[ -z $1 ]]; then # check if argument is empty
	print '\n${RED}ERROR:${NC}'
	print '\n  Project Name Missing!' # if argument is empty
	print '\n  ${GREEN}sj${NC} ${RED}<project name>${NC}' # if argument is empty
else
# if argument is not empty => create the project

PROJECT=$1 #store entered argument in the PROJECT variable

# Create Project Stucture
d $PROJECT/                # project folder
d $PROJECT/js              # js folder
d $PROJECT/css
f $PROJECT/.sj             # create hidden, 'sj' project identifier file
f $PROJECT/css/style.styl
f $PROJECT/js/$PROJECT.js  # javascript file we'll work on

# go into project folder
cd $PROJECT/ || exit

# starter content
sjContent.index
sjContent.style
sjContent.library
sjContent.gitignore

# version control the project
git init
ga .                        # git add entire current directory
gc started $PROJECT project # first commit message

# open project
sjo

fi # close if statement
}
