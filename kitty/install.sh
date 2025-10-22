#!/bin/bash

set -o nounset # error when referencing undefined variable

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#-------------------------------------------------------------------
# @description Directories: current and local binaries
#-------------------------------------------------------------------
readonly CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#------------------------------------------------------------------
# @description Rename current appimage to old.
#------------------------------------------------------------------
createKittyConfig() {
	readonly MESSAGE_KITTY_CONFIG="Create kitty config directory."
	readonly COMMAND_KITTY_CONFIG="mkdir -p $HOME/.config/kitty"

	evaluateCommand "$MESSAGE_KITTY_CONFIG" "$COMMAND_KITTY_CONFIG"
}

#------------------------------------------------------------------
# @description Create neovim symlink in local binaries
#------------------------------------------------------------------
createKittySymlink() {
	readonly KITTY_CONF="kitty.conf"
	readonly MESSAGE_REMOVE_KITTY_CONF="Removing 'kitty.conf' if exists."
	readonly COMMAND_REMOVE_KITTY_CONF="rm -f $HOME/.config/kitty/$KITTY_CONF"

	evaluateCommand "$MESSAGE_REMOVE_KITTY_CONF" "$COMMAND_REMOVE_KITTY_CONF"

	readonly MESSAGE_CREATE_SYMLINK_KITTY_CONF="Creating symlink for '$KITTY_CONF'."
	readonly COMMAND_CREATE_SYMLINK_KITTY_CONF="ln -s $CURRENT_DIR/$KITTY_CONF $HOME/.config/kitty/$KITTY_CONF"

	evaluateCommand "$MESSAGE_CREATE_SYMLINK_KITTY_CONF" "$COMMAND_CREATE_SYMLINK_KITTY_CONF"
}


if [ "${PWD##*/}" == "kitty" ]
then
	createKittyConfig
	echo
	createKittySymlink
	echo
	printf "${BACKGROUND_GREEN}END OF 'kitty'${NC}"
fi

exit 0
