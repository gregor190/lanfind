# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## LANFind - Lightweight LAN Discovery Tool

This is an AppImage application that performs network discovery using AWK and nmap. The tool automatically detects the local IPv4 subnet and scans for live hosts.

## Project Structure

This is an AppImage directory structure containing:
- `AppRun`: Entry point launcher script that detects terminal presence
- `usr/bin/run_lanfind`: Main application script
- `usr/bin/gawk`: Bundled AWK interpreter (binary)
- `usr/bin/get_subnet.awk`: AWK script to extract IPv4 subnet from `ip a` output
- `usr/bin/parse_nmap.awk`: AWK script to parse nmap scan results
- Desktop integration files (`lanfind.desktop`, `lanfind.png`)

## Core Architecture

The application follows a Unix pipeline architecture:

1. **Subnet Detection**: `ip a` output is piped to `get_subnet.awk` to extract the local private IPv4 subnet
2. **Network Scanning**: The subnet is passed to `nmap -sn` for host discovery 
3. **Result Parsing**: nmap output is processed by `parse_nmap.awk` for formatted display

The AWK scripts implement:
- IP address to integer conversion and subnet calculations
- Bitwise operations for network masking
- nmap output parsing and formatting

## Common Commands

### Running the Tool
```bash
# Run from usr/bin directory (required due to relative path dependencies)
cd usr/bin
./run_lanfind -c                    # Output to console
./run_lanfind -o results.txt        # Output to file
./run_lanfind -l                    # Show ASCII logo
```

### Testing the AppImage Launcher
```bash
# Test GUI launcher (shows dialog if no terminal)
./AppRun

# Test CLI launcher
./AppRun -c
```

## Development Notes

- The tool requires `nmap` to be installed on the system
- All scripts expect to be run from `usr/bin/` directory due to relative path references
- The bundled `gawk` binary provides consistent AWK behavior across systems
- Error handling includes exit codes: 0 (success), 1 (usage error), 2 (missing files), 3 (runtime failure)
- The tool filters out loopback (127.x.x.x) and link-local (169.254.x.x) addresses

## License

GPL v3 - See LICENSE file for full text.