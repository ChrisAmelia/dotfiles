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
# @description Create nvim directory
#------------------------------------------------------------------
createNvimDirectories() {
	readonly MESSAGE_CREATE_NVIM_DIRECTORY="Creating nvim's config directory if does not exist."
	readonly COMMAND_CREATE_NVIM_DIRECTORY="mkdir -p $NVIM_DIRECTORY"

	evaluateCommand "$MESSAGE_CREATE_NVIM_DIRECTORY" "$COMMAND_CREATE_NVIM_DIRECTORY"
}

#------------------------------------------------------------------
# @description Create neovim's config's symlinks
#------------------------------------------------------------------
createConfigsSymlinks() {
	# Symlink for 'init.lua'
	messageRemoveSymlinkInit="Removing 'init.lua'"
	commandRemoveSymlinkInit="rm $NVIM_DIRECTORY/init.lua"
	evaluateCommand "$messageRemoveSymlinkInit" "$commandRemoveSymlinkInit"

	messageCreateSymlinkInit="Create symlink for 'init.lua"
	commandCreateSymlinkInit="ln -s $CURRENT_DIR/init.lua $NVIM_DIRECTORY/init.lua"
	evaluateCommand "$messageCreateSymlinkInit" "$commandCreateSymlinkInit"

	echo "========================================="

	# Symlink for 'ftdetect'
	messageRemoveSymlinkFtDetect="Removing 'ftdetect' directory"
	commandRemoveSymlinkFtDetect="rm -rf $NVIM_DIRECTORY/ftdetect"
	evaluateCommand "$messageRemoveSymlinkFtDetect" "$commandRemoveSymlinkFtDetect"

	messageCreateSymlinkFtDetect="Create symlink for 'ftdetect' directory"
	commandCreateSymlinkFtDetect="ln -s $CURRENT_DIR/ftdetect $NVIM_DIRECTORY/ftdetect"
	evaluateCommand "$messageCreateSymlinkFtDetect" "$commandCreateSymlinkFtDetect"

	echo "========================================="

	# Symlink for 'ftplugin' directory
	messageRemoveSymlinkFtPlugin="Removing 'ftplugin' directory"
	commandRemoveSymlinkFtPlugin="rm -rf $NVIM_DIRECTORY/ftplugin"
	evaluateCommand "$messageRemoveSymlinkFtPlugin" "$commandRemoveSymlinkFtPlugin"

	messageCreateSymlinkFtplugin="Create symlink for 'ftplugin' directory"
	commandCreateSymlinkFtPlugin="ln -s $CURRENT_DIR/ftplugin $NVIM_DIRECTORY/ftplugin"
	evaluateCommand "$messageCreateSymlinkFtplugin" "$commandCreateSymlinkFtPlugin"

	echo "========================================="

	# Symlink for 'lua' directory
	messageRemoveSymlinkLua="Removing 'lua' directory"
	commandRemoveSymLinkLua="rm -rf $NVIM_DIRECTORY/lua"
	evaluateCommand "$messageRemoveSymlinkLua" "$commandRemoveSymLinkLua"

	messageCreateSymlinkLua="Creating symlink for 'lua' directory"
	commandCreateSymlinkLua="ln -s $CURRENT_DIR/lua $NVIM_DIRECTORY/lua"
	evaluateCommand "$messageCreateSymlinkLua" "$commandCreateSymlinkLua"

	echo "========================================="
}

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
createNvimSylink() {
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
	createNvimDirectories
	echo
	createConfigsSymlinks
	echo
	renameCurrentNvimAppImage
	echo
	downloadNvim
	echo
	makeNvimExecutale
	echo
	createNvimSylink
	echo
	echo ""
	printf "${BACKGROUND_GREEN}END OF 'nvim'${NC}"
fi

exit 0
