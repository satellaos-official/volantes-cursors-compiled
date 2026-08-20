#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to show usage options
show_usage() {
    echo "Usage: $0 [-u | -s | -a]"
    echo "  -u  Install for the current user only (~/.icons)"
    echo "  -s  Install system-wide (/usr/share/themes) [Requires root]"
    echo "  -a  Install for default user skeleton (/etc/skel/.icons) [Requires root]"
}

if [ "$1" = "-u" ]; then
    if [ "$EUID" -eq 0 ]; then
        echo "[ERROR] The '-u' option must not be run as root or with sudo." >&2
        exit 1
    fi
    echo "[INFO] Installing cursors for the current user..."
    mkdir -p "$HOME/.icons"
    cp -r "$DIR/volantes_cursors" "$DIR/volantes_light_cursors" "$HOME/.icons/"
    echo "[SUCCESS] Cursors successfully installed to $HOME/.icons/"

elif [ "$1" = "-s" ]; then
    if [ "$EUID" -ne 0 ]; then
        echo "[ERROR] The '-s' option requires root privileges. Please run with sudo." >&2
        exit 1
    fi
    echo "[INFO] Installing cursors system-wide..."
    cp -r "$DIR/volantes_cursors" "$DIR/volantes_light_cursors" /usr/share/themes/
    echo "[SUCCESS] Cursors successfully installed to /usr/share/themes/"

elif [ "$1" = "-a" ]; then
    if [ "$EUID" -ne 0 ]; then
        echo "[ERROR] The '-a' option requires root privileges. Please run with sudo." >&2
        exit 1
    fi
    echo "[INFO] Installing cursors to skeleton directory..."
    mkdir -p /etc/skel/.icons
    cp -r "$DIR/volantes_cursors" "$DIR/volantes_light_cursors" /etc/skel/.icons/
    echo "[SUCCESS] Cursors successfully installed to /etc/skel/.icons/"

else
    echo "[ERROR] Invalid or missing argument." >&2
    show_usage
    exit 1
fi
