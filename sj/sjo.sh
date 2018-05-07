sjo() {
# open simple javascript project 

# import sjError
sjError

sjLogic(){
  if [[ ! -z $1 ]]; then             # if sjo was given an argument
    if [[ -a $1/.sj ]]; then         # and it's a sj project
      cd $1 || exit; sjOpenProject;  # open the project
    else                             # otherwise
      sjError.CantOpen               # Print Error
    fi

  else                               # if sjo was NOT given an argument
    if [[ -a .sj ]]; then            # but the folder we're in is a sj project
      sjOpenProject                  # open the sj project
    else                             # otherwise
      sjError.CantOpen             # Print Error
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