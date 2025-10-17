# LANFind

**LANFind** is a lightweight LAN discovery tool packaged as an **AppImage**.  
It uses **AWK** and **shell scripting** to detect your local IPv4 subnet and scan for live hosts using `nmap`.  

LANFind is fully portable — it comes with its own `gawk` interpreter and doesn’t require installation.

---

## Features

- **Automatic subnet detection** using `ip a`
- **Live host discovery** with `nmap -sn`
- **AWK-powered result parsing** and formatted output
- **Optional ASCII logo** for fun, themed output
- **Portable AppImage** with terminal detection  
  (shows a friendly GUI message via `kdialog` if launched without a terminal)
- **Free and open source** under the GPL v3 or later

---

## Project Structure

```
lanfind-app/
├── AppRun                     # AppImage entry point
├── lanfind.desktop            # Desktop entry file
├── lanfind.png                # Application icon
├── usr/
│   ├── bin/
│   │   ├── gawk               # Bundled AWK interpreter
│   │   ├── get_subnet.awk     # Script for detecting subnet
│   │   ├── parse_nmap.awk     # Script for parsing nmap output
│   │   └── run_lanfind        # Main shell script
│   └── share/doc/lanfind/
│       ├── LICENSE            # GPL v3 license text
│       └── README.md          # Documentation (this file)
```

---

## Usage

Run LANFind from the `usr/bin` directory (required for relative paths):

```bash
cd usr/bin

./run_lanfind -c              # Show scan results in the console
./run_lanfind -o results.txt  # Save scan results to a file
./run_lanfind -l              # Display ASCII logo
```

Or launch the AppImage directly:

```bash
./LANFind-x86_64.AppImage
```

If no terminal is detected, LANFind will attempt to show a small pop-up message using **kdialog**.  
If `kdialog` is not installed, the message will simply not appear — the tool will still run correctly.

---

## Requirements

- `nmap` installed on the system  
- A POSIX-compatible shell environment  
- (Optional) `kdialog` for GUI messages when launched outside a terminal  
- A Linux distribution that supports **AppImage**

---

## License

**LANFind** is released under the **GNU General Public License v3.0 or later**.  
You can find the full license in:

```
usr/share/doc/lanfind/LICENSE
```

---

## Credits

Created by **Gregor** — a curious tinkerer of configs and local networks.  
LANFind was built for clarity, portability, and easy remixing.  

---

## AppImage Notes

- `.DirIcon` is symlinked to `lanfind.png` (for embedded icon support)
- `AppRun` automatically detects if a terminal is available and launches `run_lanfind`
- `lanfind.desktop` provides optional desktop integration

---

**LANFind** is designed for anyone who enjoys understanding their network in a simple, portable way.  
Scan, discover, and explore your local LAN — no installation required.
