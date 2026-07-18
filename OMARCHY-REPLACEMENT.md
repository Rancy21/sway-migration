# Omarchy Commands Replaced

Complete list of Omarchy-specific commands replaced with Fedora-compatible alternatives.

## Summary

All `omarchy-*` commands have been replaced with:
- Custom shell scripts in `scripts/` directory
- Standard Fedora packages
- Direct application launches

## Replacements Table

| Omarchy Command | Fedora Replacement | Type |
|-----------------|-------------------|------|
| `omarchy-launch-browser` | `launch-browser` | Script |
| `omarchy-launch-browser --private` | `launch-browser --private` | Script |
| `omarchy-launch-editor` | `launch-editor` | Script |
| `omarchy-launch-or-focus <app>` | `launch-or-focus <app>` | Script |
| `omarchy-launch-webapp <url>` | `launch-webapp <url>` | Script |
| `omarchy-launch-tui <cmd>` | `launch-tui <cmd>` | Script |
| `omarchy-capture screenshot` | `grim` + `slurp` | Packages |
| `omarchy toggle nightlight` | `wlsunset` | Package |
| `omarchy menu` | `wofi` or `fuzzel` | Package |
| `omarchy theme set` | Manual config edit | N/A |
| `omarchy update` | `sudo dnf upgrade` | Command |
| `omarchy restart waybar` | `pkill waybar; waybar` | Command |

## Keybinding Changes

### Updated in config.d/bindings

```bash
# OLD (Omarchy)                      # NEW (Fedora)
omarchy-launch-browser                → launch-browser
omarchy-launch-browser --private      → launch-browser --private
omarchy-launch-editor                 → launch-editor
omarchy-launch-or-focus code          → code (direct launch)
omarchy-launch-or-focus spotify       → spotify (direct launch)
omarchy-launch-webapp "url"           → launch-webapp "url"
omarchy-launch-tui btop               → launch-tui btop
```

### Waybar Changes

```bash
# OLD
"custom/omarchy": {
    "on-click": "walker"
}

# NEW
"custom/menu": {
    "on-click": "wofi --show drun"
}
```

## Files Modified

### Configuration Files

| File | Changes |
|------|---------|
| `config` | Removed Omarchy variables, updated to standard apps |
| `config.d/bindings` | Replaced all `omarchy-*` calls with scripts/direct commands |
| `waybar/config.jsonc` | Replaced `omarchy` module with `menu`, updated update checker |
| `waybar/style.css` | Renamed `#custom-omarchy` to `#custom-menu` |

### New Files Added

| File | Purpose |
|------|---------|
| `scripts/launch-browser` | Launch Firefox/Chromium |
| `scripts/launch-editor` | Launch Neovim/Vim/Nano |
| `scripts/launch-or-focus` | Launch or focus existing window |
| `scripts/launch-tui` | Launch TUI apps in terminal |
| `scripts/launch-webapp` | Open URLs in browser |
| `scripts/install.sh` | Install scripts to ~/.local/bin |
| `SCRIPTS-README.md` | Documentation for scripts |

## Installation

### 1. Install Scripts

```bash
cd /path/to/sway-migration/scripts
./install.sh
```

This installs all scripts to `~/.local/bin/`.

### 2. Add to PATH

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 3. Install Required Packages

```bash
# For scripts to work
sudo dnf install firefox neovim alacritty jq wofi grim slurp

# For screenshots
sudo dnf install grim slurp wl-clipboard

# For night light
sudo dnf install wlsunset
```

## What No Longer Works

These Omarchy-specific features are **not** available on Fedora:

| Feature | Omarchy | Fedora Alternative |
|---------|---------|-------------------|
| Theme management | `omarchy theme set` | Manual config editing |
| Easy updates | `omarchy update` | `sudo dnf upgrade` |
| Config refresh | `omarchy refresh waybar` | `pkill waybar; waybar` |
| Omarchy menu | `omarchy menu` | `wofi` or `fuzzel` |
| Omarchy icon font | Custom font | Use Nerd Fonts |

## Replacement Details

### Screenshots

**Before:**
```bash
omarchy capture screenshot
```

**After:**
```bash
# Bindings already configured:
Print                  → Full screen to clipboard
$mod+Print            → Select region to clipboard
$mod+Shift+Print      → Current window to clipboard
$mod+Ctrl+Print       → Save to file
```

### Night Light

**Before:**
```bash
omarchy toggle nightlight
```

**After:**
```bash
# Install wlsunset
sudo dnf install wlsunset

# Run with your coordinates
wlsunset -l 37.7749 -L 122.4194

# Add to autostart
exec wlsunset -l 37.7749 -L 122.4194
```

### System Updates

**Before:**
```bash
omarchy update
```

**After:**
```bash
# Fedora command
sudo dnf upgrade --refresh

# Or use the Waybar update button
# (click on update icon in Waybar)
```

### App Launcher

**Before:**
```bash
omarchy menu
# Press Super+Space
```

**After:**
```bash
# Press Super+Shift+Space for Wofi
bindsym $mod+Shift+space exec wofi --show drun

# Or use default launcher if configured
bindsym $mod+space exec wofi --show drun
```

## Testing

After installing scripts:

```bash
# Test each script
launch-browser
launch-browser --private
launch-editor
launch-webapp "https://google.com"
launch-tui btop

# Test app focus
launch-or-focus firefox firefox
```

## Customization

Edit scripts in `~/.local/bin/` to change:

### Preferred Browser
Edit `launch-browser`:
```bash
# Change browser priority
if command -v chromium &>/dev/null; then
    chromium "$@"
elif command -v firefox &>/dev/null; then
    firefox "$@"
```

### Preferred Terminal
Edit `launch-tui`:
```bash
# Change terminal priority
if command -v foot &>/dev/null; then
    foot "$@"
elif command -v alacritty &>/dev/null; then
    alacritty -e "$@"
```

### Preferred Editor
Edit `launch-editor`:
```bash
# Change editor
if command -v code &>/dev/null; then
    code "$@"
elif command -v nvim &>/dev/null; then
    nvim "$@"
```

## Notes

- All scripts check for installed applications before running
- Fallback options provided for most common apps
- Scripts are POSIX-compliant and work with bash/zsh
- Some Omarchy conveniences (like automatic theme switching) require manual setup on Fedora

## Known Issues

1. **Walker launcher not available** → Use `wofi` or `fuzzel` instead
2. **Omarchy theme system** → Manually copy theme files and configs
3. **Omarchy icon font** → Use Nerd Fonts icons instead
4. **Some apps may need different launch commands** → Edit `config.d/bindings` as needed

## Getting Help

- Check `SCRIPTS-README.md` for script documentation
- Check `FIXES-APPLIED.md` for config fixes
- Refer to `MIGRATION.md` for full migration guide
