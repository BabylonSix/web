function sj() {

# import sjContent
sjContent

if [[ -z $1 ]]; then # check if argument is empty
	print '\n${RED}ERROR:${NC}'
	print '\n  Project Name Missing' # if argument is empty
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

sjo

fi # close if statement
}
