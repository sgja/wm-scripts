#!/bin/sh

# 1. List files (excluding hidden ones)
# 2. Pipe to fuzzel in dmenu mode
# 3. Store the selection in a variable
ANIMATION_FOLDER="$HOME/.config/niri/animations"
CONFIG_FILE="$HOME/.config/niri/config.kdl"
SELECTION=$(ls -1 --color=never $ANIMATION_FOLDER | fuzzel --dmenu --prompt="Select File: " --lines=15)

# Check if the user actually picked something or hit ESC
if [ -n "$SELECTION" ]; then
    echo "You selected: $SELECTION"
    # You can add actions here, like: xdg-open "$SELECTION"
else
    echo "Selection cancelled."
    exit 1
fi

NEW_LINE="include \"animations/$SELECTION\""

# Check if a line starting with 'include "animations/' already exists
if grep -q 'include "animations/' "$CONFIG_FILE"; then
    # Replace the existing line
    # Using | as a delimiter for sed to avoid escaping the / in the path
    sed -i "s|^include \"animations/.*|$NEW_LINE|" "$CONFIG_FILE"
    echo "Updated existing animation to: $SELECTION"
else
    # Append to the end of the file if it doesn't exist
    echo "$NEW_LINE" >> "$CONFIG_FILE"
    echo "Added new animation include: $SELECTION"
fi
