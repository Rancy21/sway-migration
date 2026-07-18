# Custom Helper Scripts

These scripts replace Omarchy-specific commands with standard Fedora-compatible alternatives.

## Scripts

### launch-or-focus
Launch application or focus existing window.

```bash
# Usage:
launch-or-focus <app-name> [command]

# Examples:
launch-or-focus code                  # Launch VSCode or focus if running
launch-or-focus spotify spotify       # Launch Spotify
launch-or-focus "^signal$" signal-desktop  # Use regex pattern
```

### launch-webapp
Open URL in default browser.

```bash
# Usage:
launch-webapp <url>

# Examples:
launch-webapp "https://chatgpt.com"
launch-webapp "https://youtube.com"
```

### launch-tui
Launch TUI application in terminal.

```bash
# Usage:
launch-tui <command>

# Examples:
launch-tui btop          # System monitor
launch-tui lazydocker    # Docker TUI
launch-tui ncspot        # Spotify TUI
```

### launch-browser
Launch preferred browser (Firefox or Chromium).

```bash
# Usage:
launch-browser [--private]

# Examples:
launch-browser           # Open Firefox
launch-browser --private # Open private/incognito window
```

### launch-editor
Launch preferred text editor (Neovim, vim, or nano).

```bash
# Usage:
launch-editor [file]

# Examples:
launch-editor            # Open Neovim
launch-editor config.txt # Open file in Neovim
```

## Installation

```bash
# Install all scripts to ~/.local/bin/
cd /path/to/sway-migration/scripts
./install.sh

# Or manually:
mkdir -p ~/.local/bin
cp launch-* ~/.local/bin/
chmod +x ~/.local/bin/launch-*
```

## Add to PATH

Add to your shell configuration:

```bash
# For Bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# For Zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Reload shell
source ~/.bashrc  # or source ~/.zshrc
```

## Fedora vs Omarchy Commands

| Omarchy Command | Fedora Alternative | Script |
|-----------------|-------------------|--------|
| `omarchy-launch-browser` | `launch-browser` | `launch-browser` |
| `omarchy-launch-editor` | `launch-editor` | `launch-editor` |
| `omarchy-launch-or-focus` | `launch-or-focus` | `launch-or-focus` |
| `omarchy-launch-webapp` | `launch-webapp` | `launch-webapp` |
| `omarchy-launch-tui` | `launch-tui` | `launch-tui` |
| `omarchy capture screenshot` | `grim` + `slurp` | Built into keybindings |
| `omarchy toggle nightlight` | `wlsunset` | Install separately |

## Customization

Edit scripts to match your preferences:

### launch-browser
Change preferred browser priority:
```bash
# Try Firefox first, then Chromium
if command -v firefox &>/dev/null; then
    firefox "$@"
elif command -v chromium &>/dev/null; then
    chromium "$@"
```

### launch-tui
Change preferred terminal:
```bash
# Try terminals in order
if command -v alacritty &>/dev/null; then
    alacritty -e "$@"
elif command -v foot &>/dev/null; then
    foot "$@"
```

### launch-editor
Change preferred editor:
```bash
# Try Neovim first, then vim
if command -v nvim &>/dev/null; then
    nvim "$@"
elif command -v vim &>/dev/null; then
    vim "$@"
```

## Dependencies

Most scripts use common Fedora packages:

- **Terminal**: `alacritty`, `foot`, `kitty`, or `xdg-terminal-exec`
- **Browser**: `firefox` or `chromium`
- **Editor**: `neovim` or `vim`
- **Sway utilities**: `swaymsg`, `jq` (for launch-or-focus)

Install missing packages:
```bash
sudo dnf install alacritty firefox neovim jq
```

## Integration with Sway

The scripts are integrated into `config.d/bindings`:

```bash
# Browser
bindsym $mod+Shift+b exec ~/.local/bin/launch-browser

# Editor
bindsym $mod+Shift+n exec ~/.local/bin/launch-editor

# Web apps
bindsym $mod+Shift+a exec ~/.local/bin/launch-webapp "https://chatgpt.com"

# TUI apps
bindsym $mod+Shift+t exec ~/.local/bin/launch-tui btop
```

## Troubleshooting

### Scripts not found
```bash
# Check if ~/.local/bin is in PATH
echo $PATH | grep -q "$HOME/.local/bin" || echo "Add to PATH"

# Check if scripts are executable
ls -la ~/.local/bin/launch-*
```

### Terminal not launching
```bash
# Check which terminal is available
which xdg-terminal-exec alacritty foot kitty

# Install terminal if missing
sudo dnf install alacritty
```

### Browser not found
```bash
# Check available browsers
which firefox chromium google-chrome

# Install Firefox
sudo dnf install firefox
```

### jq not found (for launch-or-focus)
```bash
# jq is needed to parse swaymsg output
sudo dnf install jq
```
