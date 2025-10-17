#!/bin/bash

# Git push
git_push() {
    echo " Pushing to GitHub..."
    git push && echo " Push complete"
}

# Nmap check
check_nmap() {
    if command -v nmap >/dev/null; then
        echo " Nmap is installed: $(nmap --version | head -n1)"
    else
        echo " Nmap not found. Try: sudo apt install nmap"
    fi
}

#  Clean AppImage build
build_appimage() {
    version="$1"
    if [ -z "$version" ]; then
        echo "Error: No version provided."
        echo "Usage: build_appimage [versions]"
        return 1
    fi

    # Build the AppImage
    ./appimagetool lanfind-app "LANFind_v${version}.AppImage"

    # Create dist folder if it doesn't exist
    mkdir -p dist

    # Move the AppImage to dist/
    mv "LANFind_v${version}.AppImage" dist/

    echo "Success!"
}

# Git status
git_status() {
    git status
}
