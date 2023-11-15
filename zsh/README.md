# ZSH scripts used by me.
List of scripts in this directory.

1. 'load_idf.zsh' is used with espressif to auto load the idf tool on new panned. Se #load_idf.
2. 'zsh_colors_flags.zsh' is a script to add colors to the terminal. See #zsh_color_flags.

# Load_idf
This script is loaded with the `.zshrc` file with the source command.

``` BASH
# This is for the espressif platform to auto load each time conditions apply.
ZSH_PRIVATE_SCRIPTS_DIR="$HOME/repos/scripts/zsh/"
ESPRESSIF_EXPORT_SCRIPT="$HOME/esp/esp-idf/export.sh"
# Both the scirpt files and the espressif platform needs to be installd to work.
if [[ -d "$ZSH_PRIVATE_SCRIPTS_DIR" ]]; then
    # Source Colors and Fags.
    source "$ZSH_PRIVATE_SCRIPTS_DIR/zsh_color_flags.zsh"
    if [[ -f $ESPRESSIF_EXPORT_SCRIPT  ]]; then
    # Source the idf functions.
        source "$ZSH_PRIVATE_SCRIPTS_DIR/load_idf.zsh"
    fi
fi
# DONE

```

