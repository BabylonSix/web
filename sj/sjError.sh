sjError() {
# Existing sj projects have a hidden .sj identifier file
# If this file is missing, the project will not be recognized

sjError.MissingName() {
  # Print Error when missing project name
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}Project Name Missing!${NC}' # if argument is empty
  print '\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} to create new sj project' # if argument is empty
} # end MissingName

sjError.CantBranch() {
  # Print Error when can't open project
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}Cannot Branch Project!${NC}'
  print '\n  ${RED}sjb${NC} takes ${BLUE}one${NC} or ${BLUE}two${NC} arguments'
  print '\n  Run: ${RED}sjb${NC} ${GREEN}<branch-name>${NC}\n  from inside existing sj project to create new branch.'
  print '\n  ${BLUE}OR${NC}'
  print '\n  Run: ${RED}sjb${NC} ${GREEN}<sj-project-directory> <branch-name>${NC}\n  to create new branch from existing sj project.'
} # end CantBranch

sjError.CantOpen() {
  # Print Error when cannot branch project
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}This is not a simple javascipt project!${NC}'
  print '\n  Run: ${RED}sj${NC} ${GREEN}<project-name>${NC} to create a new project.'
} # end CantOpen

sjError.NameClash() {
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}Project with this name already exists!${NC}'
  print '\n  Run: ${RED}sj${NC} ${GREEN}<unique-project-name>${NC} to create a new project.'
} # end NameClash

sjError.TooManyArguments() {
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}Too many arguments entered!${NC}'
} # end TooManyArguments

sjError.ShortName() {
  print '\n${RED}ERROR:${NC}'
  print '\n  ${PINK}The name is too short!${NC}'
  print '\n  ${GREEN}<project-name>${NC} needs to be at least 4 characters long'
} # end ShortName
}; sjError