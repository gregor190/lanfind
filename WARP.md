# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## LANFind - Lightweight LAN Discovery AppImage

This is a portable AppImage application that performs automatic LAN discovery using AWK scripting and nmap. The tool detects local IPv4 subnets and scans for live hosts without requiring installation.

## Project Architecture

### Core Structure
- **Root repository**: Contains build scripts, documentation, and the AppImage tool
- **`lanfind-app/`**: AppImage directory structure containing the complete application
- **`dist/`**: Build output directory for generated AppImage files
- **`appimagetool`**: Binary tool for creating AppImages from the directory structure

### AppImage Directory Layout
```
lanfind-app/
├── AppRun                      # Entry point with terminal detection
├── lanfind.desktop/.png        # Desktop integration files
├── usr/bin/
│   ├── gawk                    # Bundled AWK interpreter (binary)
│   ├── run_lanfind             # Main application script
│   ├── get_subnet.awk          # Subnet detection AWK script
│   └── parse_nmap.awk          # nmap output parser AWK script
└── usr/share/doc/lanfind/      # Documentation and license
```

### Pipeline Architecture
The application follows a Unix pipeline pattern:
1. `ip a` → `get_subnet.awk` → extracts private IPv4 subnet
2. Subnet → `nmap -sn` → performs host discovery scan
3. nmap output → `parse_nmap.awk` → formats results for display

## Common Development Commands

### Testing the Application
```bash
# Test from the AppImage directory (required for relative paths)
cd lanfind-app/usr/bin
./run_lanfind -c                    # Console output
./run_lanfind -o results.txt        # File output
./run_lanfind -l                    # Show ASCII logo

# Test AppRun launcher
cd lanfind-app
./AppRun -c                         # CLI mode
./AppRun                            # GUI mode (shows kdialog if no terminal)
```

### Building AppImage
```bash
# Source utility functions
source utils.sh

# Build new AppImage with version
build_appimage "1.0"               # Creates LANFind_v1.0.AppImage in dist/

# Manual build
./appimagetool lanfind-app "LANFind_v1.0.AppImage"
```

### Development Utilities
```bash
# Source development utilities
source utils.sh

# Check if nmap is installed
check_nmap

# Git operations
git_status
git_push
```

### Directory Navigation
All testing must be done from `lanfind-app/usr/bin/` directory due to relative path dependencies in the scripts. The main script `run_lanfind` expects to find AWK scripts and the gawk binary in the current directory.

## Key Technical Details

### Dependencies
- System requirement: `nmap` must be installed
- Bundled: `gawk` binary (provides consistent AWK behavior)
- Optional: `kdialog` for GUI notifications

### AWK Scripts
- **`get_subnet.awk`**: Parses `ip a` output, filters private IPv4 addresses, performs subnet calculations with bitwise operations
- **`parse_nmap.awk`**: Processes nmap scan results, extracts live host information, formats output

### Error Handling
- Exit code 0: Success
- Exit code 1: Usage/argument errors  
- Exit code 2: Missing files or dependencies
- Exit code 3: Runtime failures (corrupted binaries, etc.)

### Network Filtering
- Excludes loopback addresses (127.x.x.x)
- Excludes link-local addresses (169.254.x.x)
- Focuses on private IPv4 ranges (10.x, 172.16-31.x, 192.168.x)

## Testing Requirements

When testing changes:
1. Ensure `nmap` is available on the system
2. Always run from the correct working directory (`lanfind-app/usr/bin/`)
3. Test both console (`-c`) and file output (`-o`) modes
4. Verify AppRun launcher works with and without terminal
5. Test subnet detection on different network configurations