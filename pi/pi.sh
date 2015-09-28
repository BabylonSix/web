function pi() {

if [[ -z $1 ]]; then # check if argument is empty
	echo 'error: add a project name' # if argument is empty
else
# if argument is not empty => create the project


# Create Project Folder & jump it
md ./$1


# Create Directory Structure
d build/{css,js,img}
d production/{css,js,img}
d src/{copy,stylus,jade/layout,js,assets/{svg,png,jpg,gif}}


# Create jade contents
~/bin/dotfiles/web/pi/content/jade/index.sh


# Create stylus contents
~/bin/dotfiles/web/pi/content/stylus/style.sh


# Create js contents
~/bin/dotfiles/web/pi/content/js/app.sh


# Files and folders git should ignore
~/bin/dotfiles/web/pi/content/gitignore.sh


# Create readme.md
~/bin/dotfiles/web/pi/content/readme.sh


# Create gulpfile.js
~/bin/dotfiles/web/pi/content/gulpfile.sh


# Create secrets.json
~/bin/dotfiles/web/pi/content/secrets.sh


# load all npm dependences
~/bin/dotfiles/web/pi/content/npm.sh


# git init
~/bin/dotfiles/web/pi/content/git.sh


# open project in text editor
ot .


# Start Serving Project
gulp

fi
}
