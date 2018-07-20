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
sjb ~/bin/web/sj/sjProject/default $PROJECT


print "\n${GREEN}Source Control:${NC}\n"

cd $PROJECT
# version control the project
git init
ga .                        # git add entire current directory
gc started $PROJECT project # first commit message
print "\n"

# open project
sjo

fi # close if statement
}
