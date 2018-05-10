isSJ() { # checks if current or entered directory is an SJ project 
  isSJ.Logic() {
    local location=$(sd)
    if [[ $# -lt 2 ]]; then # if one or no arguments are entered
      case $# in
        0) isSJ.CheckForSJ . ;;
        1) isSJ.CheckForSJ $1 ;;
      esac
    else
      sjError.TooManyArguments
    fi
  } # end Logic


  isSJ.CheckForSJ() {
    if [[ -a $1/.sj ]]; then
      print "${GREEN}\n$location IS an SJ project${NC}"
    else
      print "${RED}\n$location is NOT an SJ project${NC}"
    fi
  } # end CheckForSJ
isSJ.Logic
} # end isSJ