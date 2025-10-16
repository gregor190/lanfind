# LANFind

**LANFind** is a lightweight LAN discovery tool packaged as an AppImage. It uses AWK and shell scripting to detect your local IPv4 subnet and scan for live hosts using `nmap`. Designed for shrine-safe portability, it includes a bundled `gawk` interpreter and requires no installation.

## Features

- Automatic subnet detection via `ip a`
- Host discovery using `nmap -sn`
- AWK-powered parsing and formatting of scan results
- ASCII logo display for bardic flair
- AppImage launcher with terminal-awareness (GUI fallback via `kdialog`)
- GPL v3 or later licensed—free as in config freedom

## Project Structure

```
lanfind-app/
├── AppRun                     # Entry point launcher
├── lanfind.desktop           # Desktop integration scroll
├── lanfind.png               # Icon glyph
├── usr/
│   ├── bin/
│   │   ├── gawk              # Bundled AWK interpreter
│   │   ├── get_subnet.awk    # Subnet extraction script
│   │   ├── parse_nmap.awk    # Scan result parser
│   │   └── run_lanfind       # Main shell script
│   └── share/doc/lanfind/
│       ├── LICENSE           # GPL v3 license scroll
│       └── README.md         # This documentation
```

## Usage

```bash
# Run from usr/bin directory (required for relative paths)
cd usr/bin

./run_lanfind -c              # Output to console
./run_lanfind -o results.txt  # Output to file
./run_lanfind -l              # Show ASCII logo
```

Or launch via AppImage:

```bash
./LANFind-x86_64.AppImage
```

If no terminal is detected, a GUI dialog will inform the user that LANFind is a command-line tool.

## Requirements

- `nmap` must be installed on the host system
- Shell environment with basic POSIX utilities
- AppImage-compatible Linux distro

## License

This project is licensed under the **GNU General Public License v3.0 or later**.  
See the `LICENSE` file in `usr/share/doc/lanfind/` for full terms.

## Credits

Crafted by **Gregor**, config bard and LAN folklorist.  
LANFind is a shrine-safe relic designed for clarity, portability, and remixable discovery.

## AppImage Notes

- `.DirIcon` is symlinked to `lanfind.png` for embedded icon support
- `AppRun` detects terminal presence and invokes `run_lanfind`
- Desktop integration provided via `lanfind.desktop`

For future shrine builders, remixers, and network sages—LANFind is yours to explore.
