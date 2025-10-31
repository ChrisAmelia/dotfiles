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
readonly NVIM_LUA_DIRECTORY=$HOME/.config/nvim/lua
readonly NVIM_FTDETECT_DIRECTORY=$HOME/.config/nvim/ftdetect
readonly NVIM_FTPLUGIN_DIRECTORY=$HOME/.config/nvim/ftplugin

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

	readonly MESSAGE_CREATE_LUA_DIRECTORY="Creating nvim's lua directory if does not exist."
	readonly COMMAND_CREATE_LUA_DIRECTORY="mkdir -p $NVIM_LUA_DIRECTORY"

	evaluateCommand "$MESSAGE_CREATE_LUA_DIRECTORY" "$COMMAND_CREATE_LUA_DIRECTORY"

	readonly MESSAGE_CREATE_FTDETECT_DIRECTORY="Creating nvim's ftdetect directory if does not exist."
	readonly COMMAND_CREATE_FTDETECT_DIRECTORY="mkdir -p $NVIM_FTDETECT_DIRECTORY"

	evaluateCommand "$MESSAGE_CREATE_FTDETECT_DIRECTORY" "$COMMAND_CREATE_FTDETECT_DIRECTORY"

	readonly MESSAGE_CREATE_FTPLUGIN_DIRECTORY="Creating nvim's ftplugin directory if does not exist."
	readonly COMMAND_CREATE_FTPLUGIN_DIRECTORY="mkdir -p $NVIM_FTPLUGIN_DIRECTORY"

	evaluateCommand "$MESSAGE_CREATE_FTPLUGIN_DIRECTORY" "$COMMAND_CREATE_FTPLUGIN_DIRECTORY"
}

#------------------------------------------------------------------
# @description Create neovim's config's symlinks
#------------------------------------------------------------------
createConfigsSymlinks() {
	readonly SYMLINKS=(
		init.lua
	)

	readonly SYMLINKS_FTDETECT=(
	)

	readonly SYMLINKS_FTPLUGIN=(
		lua.lua
	)

	readonly SYMLINKS_LUA=(
		colors.lua
		config.lua
		lsp.lua
		plugins.lua
		settings.lua
		status-line.lua
		stringutil.lua
		winbar.lua
		autocommands.lua
		component.lua
	)

	for symlink in "${SYMLINKS[@]}"; do
		messageRemoveSymlinkConfig="Removing '$symlink'"
		commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/$symlink"
		evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

		messageCreateSymlinkConfig="Creating symlink for '$symlink'"
		commandCreateSymlinkConfig="ln -s $CURRENT_DIR/$symlink $NVIM_DIRECTORY"
		evaluateCreateSymlink "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"

		echo "========================================="
	done

	for symlink in "${SYMLINKS_FTDETECT[@]}"; do
		messageRemoveSymlinkConfig="Removing '$symlink'"
		commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/ftdetect/$symlink"
		evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

		messageCreateSymlinkConfig="Creating symlink for '$symlink'"
		commandCreateSymlinkConfig="ln -s $CURRENT_DIR/ftdetect/$symlink $NVIM_DIRECTORY/ftdetect"
		evaluateCreateSymlink "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"

		echo "========================================="
	done

	for symlink in "${SYMLINKS_FTPLUGIN[@]}"; do
		messageRemoveSymlinkConfig="Removing '$symlink'"
		commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/ftplugin/$symlink"
		evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

		messageCreateSymlinkConfig="Creating symlink for '$symlink'"
		commandCreateSymlinkConfig="ln -s $CURRENT_DIR/ftplugin/$symlink $NVIM_DIRECTORY/ftplugin"
		evaluateCreateSymlink "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"

		echo "========================================="
	done

	for symlink in "${SYMLINKS_LUA[@]}"; do
		messageRemoveSymlinkConfig="Removing '$symlink'"
		commandRemoveSymlinkConfig="rm -f $NVIM_DIRECTORY/lua/$symlink"
		evaluateCommand "$messageRemoveSymlinkConfig" "$commandRemoveSymlinkConfig"

		messageCreateSymlinkConfig="Creating symlink for '$symlink'"
		commandCreateSymlinkConfig="ln -s $CURRENT_DIR/lua/$symlink $NVIM_DIRECTORY/lua"
		evaluateCreateSymlink "$messageCreateSymlinkConfig" "$commandCreateSymlinkConfig"

		echo "========================================="
	done
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
