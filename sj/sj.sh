sj() {

# import sjContent & sjError
sjContent; sjError

if [[ -z $1 ]]; then # check if argument is empty
	sjError.MissingName
else
# if argument is not empty => create the project

PROJECT=$1 #store entered argument in the PROJECT variable

# Create Project Stucture
d $PROJECT/                # project folder
d $PROJECT/src
d $PROJECT/build
d $PROJECT/src/js          # js folder
d $PROJECT/build/js
d $PROJECT/src/styles      # stylus folder
d $PROJECT/src/css
d $PROJECT/src/styles/colors
d $PROJECT/src/styles/colors/mixins
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

# version control the project
git init
ga .                        # git add entire current directory
gc started $PROJECT project # first commit message

# open project
sjo

fi # close if statement
}
