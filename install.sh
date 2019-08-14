#!/bin/bash

#------------------------------------------------------------------
# @constant
# @description:     directories for configuration
#------------------------------------------------------------------
CURRENT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASH="$CURRENT_DIRECTORY/bash_script"
COC="$CURRENT_DIRECTORY/coc"
NVIM="$CURRENT_DIRECTORY/nvim"
PACKAGES="$CURRENT_DIRECTORY/packages"
ZSH="$CURRENT_DIRECTORY/zsh"

#------------------------------------------------------------------
# @constans
# @description:     color constant
#------------------------------------------------------------------
LIGHT_RED='\033[1;31m'
YELLOW='\033[1;33m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GREEN='\033[1;32m'
LIGHT_PURPLE='\033[1;35m'
NC='\033[0m'

#------------------------------------------------------------------
# @constant
# @description:     'install.sh' is the default name for each script
#------------------------------------------------------------------
INSTALL_SH="install.sh"
CHMOD_X_INSTALL="chmod +x $INSTALL_SH"

#------------------------------------------------------------------
# @description      Prints given message in yellow
# @args             $1: message to print
#------------------------------------------------------------------
echoMessage() {
    echo -e "${YELLOW}$1${NC}"
}

#------------------------------------------------------------------
# @description      Prints given message in cyan
# @args             $1: command to print
#------------------------------------------------------------------
echoCommand() {
    commands=()
    for var in "$@"
    do
        commands+=$var" "
    done
    echo -e "${LIGHT_CYAN}+$commands${NC}"
}

#------------------------------------------------------------------
# @description      Echo success of last last executed command
# @noargs
#------------------------------------------------------------------
echoSuccessFail() {
    if [ $? #eq 0 ]; then
        echo -e "... ${LIGHT_GREEN}OK${NC}"
    else
        echo -e "... ${LIGHT_RED}FAIL${NC}"
    fi
}

#------------------------------------------------------------------
# @description      Print command and evalute it
# @args             $1: message to print
#                   $2: command to execute
#------------------------------------------------------------------
evaluateCommand() {
    echoMessage "$1"
    echoCommand "$2"
    eval "$2" > /dev/null
    echoSuccessFail
}

#------------------------------------------------------------------
# @description      Execute install script in given folder
# @args             $1: folder
#------------------------------------------------------------------
executeInstallScript() {
    MESSAGE_CD="Moving to $1"
    COMMAND_CD="cd $1"
    evaluateCommand "$MESSAGE_CD" "$COMMAND_CD"

    echo ""
    MESSAGE_CHMOD="Making '$INSTALL_SH' executable"
    COMMMAND_CHMOD="$CHMOD_X_INSTALL"
    evaluateCommand "$MESSAGE_CHMOD" "$COMMMAND_CHMOD"

    echo ""
    echoMessage "Executing '$INSTALL_SH' ..."
    ./install.sh
}

#------------------------------------------------------------------
# @description      Loop through folders and execute install script
# @noargs
#------------------------------------------------------------------
installAll() {
    # Installation will be done following the order of the added directory.
    # Some nvim's functionalities require python3 to be installed first.
    INSTALLATION_FOLDERS=(
        $PACKAGES
        $BASH
        $ZSH
        $NVIM
        $COC
    )

    for folder in "${INSTALLATION_FOLDERS[@]}"
    do
        echo ""
        cd $folder
        executeInstallScript $folder
        echoSuccessFail
        cd $CURRENT_DIRECTORY
    done
}

installAll
exit 0
