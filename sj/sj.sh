sj() {

# import sjContent & sjError
sjContent; sjError

local count=$(charCount $1)

if [[ -z $1 ]]; then # check if argument is empty
	sjError.MissingName
elif [[ -d $1 ]]; then # check if project with same name exists
	sjError.NameClash
elif [[ $count -lt 4 ]]; then # check if project-name > 4 characters
	sjError.ShortName
else
# if argument is not empty => create the project

local PROJECT=$1 #store entered argument in the PROJECT variable

print "${GREEN}\nCreate Project:${NC} ${PINK}$1${NC}\n"
# Create Project Stucture
d $PROJECT/                # project folder
d $PROJECT/src
d $PROJECT/src/pug         # pug folder
d $PROJECT/src/pug/pages   # extra web-pages
d $PROJECT/src/pug/views   # modules and templates
d $PROJECT/src/js          # js folder
d $PROJECT/src/styles      # stylus folder
d $PROJECT/src/css
d $PROJECT/src/styles/mixins/
d $PROJECT/src/styles/mixins/colors
d $PROJECT/src/styles/mixins/utilities
d $PROJECT/build/js
d $PROJECT/build
d $PROJECT/build/css       # css folder
d $PROJECT/build/assets    # pictures folder
f $PROJECT/.sj             # create hidden, 'sj' project identifier file

f $PROJECT/src/styles/$PROJECT.styl # css file we will work on
f $PROJECT/src/js/$PROJECT.js  # javascript file we'll work on

# go into project folder
cd $PROJECT/ || exit

# starter content
sjContent.index
sjContent.cssLibrary
sjContent.jsLibrary
sjContent.gitignore


print "\n\n\n${GREEN}Source Control:${NC}\n"
# version control the project
git init
ga .                        # git add entire current directory
gc started $PROJECT project # first commit message
print "\n"

# open project
sjo

fi # close if statement
}
