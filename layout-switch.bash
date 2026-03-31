#!/usr/bin/env bash

current_output=$(mmsg -gol | grep "selmon 1" | cut -d ' ' -f1)
# 1. Get the current layout to display in the prompt
current_layout=$(mmsg -gl | grep $current_output | cut -d ' ' -f3)

layout_list=(
    "S Scroller"
    "T Tile"
    "G Grid"
    "M Monocle"
    "K Deck"
    "CT Center Tile"
    "RT Right Tile"
    "VS Vertical Scroller"
    "VG Vertical Grid"
    "VK Vertical Deck"
    "TG TGMix"
)

# 3. Use fuzzel to select a new layout
# --dmenu: acts as a filter
# --p: sets the prompt text
chosen_layout=$(printf '%s\n' "${layout_list[@]}" | fuzzel --dmenu --prompt "Current: [$current_layout] 󰕰 " --lines ${#layout_list[@]})

#chosen_layout=$(echo -e "${layout_list[*]}" | fuzzel --dmenu --prompt "Current: [$current_layout] 󰕰 ")
# 4. Apply the layout if a selection was made (prevents error on Esc)
if [ -n "$chosen_layout" ]; then
    mmsg -l $(echo $chosen_layout | cut -d' ' -f1)
fi
