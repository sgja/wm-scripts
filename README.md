# Collection of wm scripts

## Niri Animation Selector

This script provides a lightweight, fuzzy-search interface to quickly switch between different animation configurations in Niri. It uses `fuzzel` to display a menu of available animation files and automatically updates your `config.kdl` to include the selection.

### 🛠 Prerequisites

To use this script, ensure you have the following installed:

* **Niri**: The scrollable-tiling Wayland compositor.
* **Fuzzel**: A Wayland-native application launcher (used here in dmenu mode).
* **Standard Unix Tools**: `ls`, `grep`, and `sed`.

## 📂 Directory Structure

The script assumes your Niri configuration is organized as follows:

```text
~/.config/niri/
├── config.kdl             # Your main configuration file
└── animations/            # A folder containing individual .kdl animation files
    ├── bouncy.kdl
    ├── fast.kdl
    └── smooth.kdl
```

> [!NOTE]
> The script specifically looks for files located in `~/.config/niri/animations`.

### 🚀 Installation & Setup

1.  **Save the Script**: Place `choose-animation.sh` in your scripts folder (e.g., `~/.local/bin/`).
2.  **Make it Executable**:
    ```bash
    chmod +x ~/.local/bin/choose-animation.sh
    ```
3.  **Prepare your Config**: Ensure your `config.kdl` has (or is ready to receive) an `include` line. The script will look for lines starting with `include "animations/` to replace them, or append a new one at the end if none are found.

### 📖 How It Works

1.  **Scanning**: The script lists all files within your `~/.config/niri/animations` folder.
2.  **Selection**: It opens a `fuzzel` window with 15 lines of visibility, allowing you to search and select a file.
3.  **Updating**: 
    * If an animation include already exists in `config.kdl`, the script uses `sed` to swap the filename.
    * If no animation include is found, it appends `include "animations/[your-selection]"` to the bottom of the file.

### ⌨️ Integration with Niri

You can bind this script to a key combination in your `config.kdl` for even faster switching:

```kdl
binds {
    Mod+A { spawn "sh" "-c" "~/.config/niri/scripts/choose-animation.sh"; }
}
```

## Mangwc Layout Switcher

This script automates layout management by interfacing with `mmsg` and providing a visual selection menu via `fuzzel`.

### Core Functionality
* [cite_start]**Context Awareness**: The script identifies the currently focused monitor and retrieves the active layout to display it directly in the search prompt[cite: 1].
* [cite_start]**Fuzzy Search Interface**: It pipes a predefined list of 11 layouts (including Scroller, Grid, and Monocle) into `fuzzel` for quick filtering[cite: 1, 2].
* [cite_start]**Dynamic Application**: Once a selection is made, the script extracts the specific layout short-code and applies it via the `mmsg -l` command[cite: 3].

### Supported Layouts
[cite_start]The following layouts are available for selection within the script[cite: 1]:

| Code | Layout | Code | Layout |
| :--- | :--- | :--- | :--- |
| **S** | Scroller | **RT** | Right Tile |
| **T** | Tile | **VS** | Vertical Scroller |
| **G** | Grid | **VG** | Vertical Grid |
| **M** | Monocle | **VK** | Vertical Deck |
| **K** | Deck | **TG** | TGMix |
| **CT** | Center Tile | | |

### Requirements
* [cite_start]**mangwc**: Must be running to utilize the `mmsg` command-line tool[cite: 1].
* [cite_start]**fuzzel**: Required for the dmenu-style selection interface[cite: 2].
* **Standard Utilities**: `grep`, `cut`, and `printf`.

### Integration Tip
To make layout switching seamless, you can bind this script to a key combination within your compositor configuration:
```bash
# Example binding (pseudo-code)
bind = Mod4, Space, spawn, /path/to/layout-switch.bash
```
