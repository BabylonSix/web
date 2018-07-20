sjb() {
# branch simple javascript project 

local currentDir=$(echo "$(pwd)")

sjLogic() {
  if [[ $# -lt 3 ]]; then # when less than 3 arguments are entered
    case $# in
      '0') # for zero arguments
        sjError.CantBranch
      ;;
      '1') # for one arguments
        if [[ $1 = . ]]; then # if a . is entered as an argument
          # throw a branching error
          sjError.CantBranch
        else
          
          if [[ -a ./.sj ]]; then # if active directory has .sj file
            #set projectName to current directory
            local sj_projectName=$(printf '%s\n' "${PWD##*/}")
            # set branchName to argument
            local sj_branchName=$1

            sjBranch

          else
            sjError.CantBranch
          fi
        fi
      ;;
      '2') # for two arguments
        if [[ -a $1/.sj ]]; then # if arg1 is sj project
          #set projectName to arg1
          local sj_projectName=$1
          # set branchName to arg2
          local sj_branchName=$2

          cd $sj_projectName

          # update variable
          local sj_projectName=$(printf '%s\n' "${PWD##*/}")

          sjBranch
        else
          sjError.CantBranch
        fi
      ;;
    esac
  else
    sjError.CantBranch
  fi
} # end sjLogic


sjBranch() {
  # start sjBranch
  print "\n${GREEN}Branching Project:${NC}\n\n$sj_projectName \-\> $sj_branchName\n"
  
  # copy sjProject to branchName
  cp -r . $currentDir/$sj_branchName

  # go to the new directory
  cd $currentDir/$sj_branchName
  
  # erase old css and html files
  trash ./**/*.{css,html}*


  # suppress std-out
  disableOutput

  # replace all instances of <sj_projectName> with <sj_branchName> in index.pug file
  cat ./src/pug/index.pug \
    | sed -E "s/$sj_projectName/$sj_branchName/g" \
    | tee ./src/pug/index.pug

  # re-enable std-out
  enableOutput

  # rename all project  files of type <pName.*> to <bName.*>
  sjRenameFileNames $sj_projectName $sj_branchName

  # update git with branchName
  sjGitUpdateProjectName

  # start project
  print "\n"
} # end sjBranch


sjGitUpdateProjectName() {
  # if .git file exists
  if [[ -a ./.git ]]; then
    print "\n\n${GREEN}Source Control:${NC}\n"
    ga .
    gc changed project name from \<$sj_projectName\> to \<$sj_branchName\>
  fi
} # end sjGitUpdateProjectName


# rename multiple files in same directory
sjRenameFileNames() {
  # declare local variables
  local oldNamePattern="(**/)$1(.*)"
  local newNamePattern="\$1$2\$2"
  $(zmv $oldNamePattern $newNamePattern)
} # end sj_rn

#run sjLogic
sjLogic $@
}