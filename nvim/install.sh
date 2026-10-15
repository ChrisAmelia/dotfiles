#!/bin/bash

set -o nounset # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#-------------------------------------------------------------------
# @description Directories: current and local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly LOCAL_BIN="/usr/local/bin"
readonly NVIM_DIRECTORY=$HOME/.config/nvim

#-------------------------------------------------------------------
# @description nvim
#-------------------------------------------------------------------
readonly NVIM_APPIMAGE="nvim.appimage"

#------------------------------------------------------------------
# @description Rename current appimage to old.
#------------------------------------------------------------------
renameCurrentNvimAppImage() {
	readonly MESSAGE_RENAME_NVIM_APPIMAGE="Renaming current $NVIM_APPIMAGE"
	readonly COMMAND_RENAME_NVIM_APPIMAGE="mv $NVIM_APPIMAGE old.$NVIM_APPIMAGE"

	evaluateCommand "$MESSAGE_RENAME_NVIM_APPIMAGE" "$COMMAND_RENAME_NVIM_APPIMAGE"
}

#------------------------------------------------------------------
# @description Download nighlty build neovim
#------------------------------------------------------------------
downloadNvim() {
	readonly NIGHTLY_NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage"
	readonly MESSAGE_DOWNLOAD_NIGHTLY_BUILD="Downloading Neovim (nightly build):"
	readonly COMMAND_DOWNLOAD_NIGHTLY_NVIM="wget --quiet $NIGHTLY_NVIM_URL --output-document $NVIM_APPIMAGE"

	evaluateCommand "$MESSAGE_DOWNLOAD_NIGHTLY_BUILD" "$COMMAND_DOWNLOAD_NIGHTLY_NVIM"
}

#------------------------------------------------------------------
# @description Make neovim executable
#------------------------------------------------------------------
makeNvimExecutale() {
	readonly MESSAGE_CHMOD_NVIM="Making $NVIM_APPIMAGE executable"
	readonly COMMAND_CHMOD_NVIM="chmod +x '$NVIM_APPIMAGE'"

	evaluateCommand "$MESSAGE_CHMOD_NVIM" "$COMMAND_CHMOD_NVIM"
}

#------------------------------------------------------------------
# @description Create neovim symlink in local binaries
#------------------------------------------------------------------
createNvimSymlink() {
	readonly SYMLINK_NVIM="nvim"
	readonly MESSAGE_REMOVE_SYMLINK_NVIM="Removing existing symlink '$SYMLINK_NVIM' in '$LOCAL_BIN'"
	readonly COMMAND_REMOVE_SYMLINK_NVIM="rm -f $LOCAL_BIN/$SYMLINK_NVIM"

	evaluateCommand "$MESSAGE_REMOVE_SYMLINK_NVIM" "$COMMAND_REMOVE_SYMLINK_NVIM"

	readonly MESSAGE_CREATE_SYMLINK_NVIM="Creating symlink for '$NVIM_APPIMAGE' in '$LOCAL_BIN'"
	readonly COMMAND_CREATE_SYMLINK_NVIM="ln -s $CURRENT_DIR/$NVIM_APPIMAGE $LOCAL_BIN/$SYMLINK_NVIM"

	evaluateCommand "$MESSAGE_CREATE_SYMLINK_NVIM" "$COMMAND_CREATE_SYMLINK_NVIM"
}


if [ "${PWD##*/}" == "nvim" ]
then
	renameCurrentNvimAppImage
	echo
	downloadNvim
	echo
	makeNvimExecutale
	echo
	createNvimSymlink
	echo
	echo ""
	printf "${BACKGROUND_GREEN}END OF 'nvim'${NC}"
fi

exit 0
