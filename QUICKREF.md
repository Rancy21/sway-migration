# Quick Reference Card: Fedora + Sway

Essential commands and keybindings for Fedora with Sway (migrated from Omarchy/Arch).

## Fedora System Commands

### Package Management

| Action | Arch/Omarchy | Fedora |
|--------|--------------|--------|
| Update system | `omarchy update` or `sudo pacman -Syu` | `sudo dnf upgrade --refresh` |
| Install package | `sudo pacman -S package` | `sudo dnf install package` |
| Remove package | `sudo pacman -R package` | `sudo dnf remove package` |
| Search package | `pacman -Ss package` | `dnf search package` |
| List installed | `pacman -Qqe` | `dnf history userinstalled` |
| Clean cache | `sudo pacman -Sc` | `sudo dnf clean all` |
| Remove orphans | `sudo pacman -Rns $(pacman -Qdtq)` | `sudo dnf autoremove` |

### Flatpak (Additional Software)

| Action | Command |
|--------|---------|
| Search app | `flatpak search app-name` |
| Install app | `flatpak install flathub app-id` |
| List installed | `flatpak list` |
| Update all | `flatpak update` |
| Remove app | `flatpak uninstall app-id` |

### Common Flatpak Apps

```bash
# Communication
flatpak install flathub org.signal.Signal
flatpak install flathub com.discordapp.Discord

# Productivity
flatpak install flathub md.obsidian.Obsidian

# Media
flatpak install flathub com.spotify.Client

# Development
flatpak install flathub com.visualstudio.code
```

## Sway Commands

| Action | Command |
|--------|---------|
| Start Sway | `sway` |
| Test config | `sway -c /path/to/config` |
| Reload config | `swaymsg reload` or `$mod+Shift+c` |
| Exit Sway | `$mod+Shift+e` |
| Lock screen | `swaylock -f -c 1e1e2e` |

## Window Management

| Action | Binding |
|--------|---------|
| Open terminal | `$mod+Return` |
| Open terminal (tmux) | `$mod+Alt+Return` |
| Kill window | `$mod+q` |
| Fullscreen | `$mod+f` |
| Toggle floating | `$mod+Shift+space` |
| Focus mode toggle | `$mod+space` |

## Focus Navigation

| Action | Binding |
|--------|---------|
| Focus left | `$mod+h` or `$mod+Left` |
| Focus down | `$mod+j` or `$mod+Down` |
| Focus up | `$mod+k` or `$mod+Up` |
| Focus right | `$mod+l` or `$mod+Right` |

## Window Movement

| Action | Binding |
|--------|---------|
| Move left | `$mod+Shift+h` or `$mod+Shift+Left` |
| Move down | `$mod+Shift+j` or `$mod+Shift+Down` |
| Move up | `$mod+Shift+k` or `$mod+Shift+Up` |
| Move right | `$mod+Shift+l` or `$mod+Shift+Right` |

## Workspaces

| Action | Binding |
|--------|---------|
| Switch to workspace N | `$mod+1-0` (1-10) |
| Move to workspace N | `$mod+Shift+1-0` |
| Back and forth | `$mod+Tab` |
| Move to scratchpad | `$mod+Shift+-` |
| Show scratchpad | `$mod+-` |

## Layout

| Action | Binding |
|--------|---------|
| Split horizontal | `$mod+b` |
| Split vertical | `$mod+v` |
| Stacking | `$mod+s` |
| Tabbed | `$mod+w` |
| Toggle split | `$mod+e` |

## Applications (From Omarchy Config)

| App | Binding | Fedora Install |
|-----|---------|----------------|
| Terminal | `$mod+Return` | Pre-installed |
| Browser | `$mod+Shift+b` | `sudo dnf install firefox chromium` |
| File manager | `$mod+Shift+f` | `sudo dnf install nautilus` |
| Editor | `$mod+Shift+n` | `sudo dnf install neovim` |
| Btop | `$mod+Shift+t` | `sudo dnf install btop` |
| Music | `$mod+Shift+m` | `flatpak install flathub com.spotify.Client` |

## Resize Mode

Enter resize mode: `$mod+r`

| Action | Binding |
|--------|---------|
| Shrink width | `Left` or `h` |
| Grow width | `Right` or `l` |
| Grow height | `Down` or `j` |
| Shrink height | `Up` or `k` |
| Exit mode | `Return` or `Escape` |

## Screenshots

| Action | Binding | Fedora Package |
|--------|---------|----------------|
| Screenshot full | `Print` | `grim` |
| Screenshot region | `$mod+Print` | `grim slurp` |
| Screenshot window | `$mod+Shift+Print` | `grim slurp` |
| Save to file | `$mod+Ctrl+Print` | `grim` |

Install: `sudo dnf install grim slurp wl-clipboard`

## Media Keys

| Action | Binding | Fedora Package |
|--------|---------|----------------|
| Volume up | `XF86AudioRaiseVolume` | `pamixer` |
| Volume down | `XF86AudioLowerVolume` | `pamixer` |
| Mute | `XF86AudioMute` | `pamixer` |
| Brightness up | `XF86MonBrightnessUp` | `brightnessctl` |
| Brightness down | `XF86MonBrightnessDown` | `brightnessctl` |
| Play/Pause | `XF86AudioPlay` | `playerctl` |

Install: `sudo dnf install pamixer brightnessctl playerctl`

## Omarchy Commands → Fedora Alternatives

### Screenshots

```bash
# Omarchy
omarchy capture screenshot

# Fedora (with this config)
# Print - Full screen
# Super+Print - Select region
# Super+Shift+Print - Current window
```

### Night Light

```bash
# Omarchy
omarchy toggle nightlight

# Fedora
wlsunset -l 37.7749 -L 122.4194  # Set your coordinates

# Add to autostart: exec wlsunset -l LAT -L LONG
```

Install: `sudo dnf install wlsunset`

### Theme Management

```bash
# Omarchy
omarchy theme set catppuccin

# Fedora (manual)
# Edit ~/.config/sway/config.d/appearance
# Edit ~/.config/waybar/style.css
# Use gsettings for GTK theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adw-gtk3-dark'
```

### System Updates

```bash
# Arch/Omarchy
omarchy update
sudo pacman -Syu

# Fedora
sudo dnf upgrade --refresh
sudo dnf update
```

### Package Search

```bash
# Arch
pacman -Ss package
yay -Ss aur-package

# Fedora
dnf search package
flatpak search app-name
```

## Common Commands

```bash
# Show outputs
swaymsg -t get_outputs

# Show inputs
swaymsg -t get_inputs

# Find app_id/class for window rules
swaymsg -t get_tree | jq '.[] | select(.type=="con") | {name, app_id}'

# Restart Waybar
pkill waybar; waybar &

# Lock screen
swaylock -f -c 1e1e2e

# Night light
wlsunset -l 37.7749 -L 122.4194

# Check Fedora version
cat /etc/fedora-release
rpm -E %fedora

# Enable RPM Fusion (first-time setup)
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Find package providing a command
dnf provides /usr/bin/command-name

# View package info
dnf info package-name

# List recent package history
dnf history
```

## File Locations

| File | Path |
|------|------|
| Sway config | `~/.config/sway/config` |
| Sway modules | `~/.config/sway/config.d/` |
| Waybar config | `~/.config/waybar/config.jsonc` |
| Waybar style | `~/.config/waybar/style.css` |
| Mako config | `~/.config/mako/config` |
| Environment vars | `~/.config/environment.d/` |

## Fedora-Specific Tools

| Tool | Purpose | Install |
|------|---------|---------|
| `dnf` | Package manager | Pre-installed |
| `flatpak` | Containerized apps | Pre-installed |
| `rpm-ostree` | Atomic upgrades (Silverblue) | Pre-installed on Silverblue |
| `abstract` | Layered packages (Silverblue) | Pre-installed on Silverblue |
| `firewalld` | Firewall | Pre-installed |
| `selinux` | Security | Pre-installed |

## Default Values

| Setting | Value |
|---------|-------|
| Mod key | `Mod4` (Super/Windows key) |
| Gaps inner | `5px` |
| Gaps outer | `10px` |
| Border size | `2px` |
| Terminal | `xdg-terminal-exec` |
| Launcher | `wofi` |
| Theme | Catppuccin Mocha |

## Color Theme (Catppuccin Mocha)

| Color | Hex |
|-------|-----|
| Base | `#1e1e2e` |
| Text | `#cdd6f4` |
| Blue | `#89b4fa` |
| Lavender | `#b4befe` |
| Green | `#a6e3a1` |
| Red | `#f38ba8` |
| Yellow | `#f9e2af` |
| Mauve | `#cba6f7` |

## Useful Fedora Resources

- Fedora Docs: https://docs.fedoraproject.org/
- RPM Fusion: https://rpmfusion.org/
- Flathub: https://flathub.org/
- Fedora Wiki: https://fedoraproject.org/wiki/
- Bug Reports: https://bugzilla.redhat.com/

## Migration Differences: Arch vs Fedora

| Aspect | Arch (Omarchy) | Fedora |
|--------|----------------|--------|
| Release model | Rolling | 6-month releases |
| Package manager | `pacman` | `dnf` |
| AUR packages | `yay`, `paru` | Use Flatpak or RPM Fusion |
| Config location | `~/.config` | Same |
| Omarchy tools | ✅ Available | ❌ Use alternatives |
| Documentation | Arch Wiki | Fedora Docs |
| Wayland support | Experimental | Well-supported |

## Performance Optimization

```bash
# Check system info
neofetch  # or fastfetch

# Monitor resources
btop

# CPU temperature
sensors

# Disk usage
df -h
du -sh /path/to/dir

# Check for package updates
dnf check-update

# Clean old kernels (keep last 3)
sudo dnf remove --oldinstallonly --setopt installonly_limit=3
```

## Quick Troubleshooting

### Sway won't start
```bash
sway -c ~/.config/sway/config -v  # Verbose output
```

### Waybar not showing
```bash
waybar -c ~/.config/waybar/config.jsonc  # Test manually
```

### Missing applications
```bash
# Search Fedora repos
dnf search app-name

# Search Flathub
flatpak search app-name

# Check what package provides a command
dnf provides /usr/bin/command
```

### Package conflicts
```bash
# View package dependencies
dnf repoquery --deplist package-name

# View what requires a package
dnf repoquery --whatrequires package-name
```

---

**Tip**: Add to your shell for quick reference:
```bash
alias quickref='cat ~/path/to/sway-migration/QUICKREF.md | less'
alias fedorahelp='cat ~/path/to/sway-migration/FEDORA-BASICS.md | less'
```
