# Migration Guide: Omarchy (Arch) → Fedora + Sway

Complete step-by-step guide for migrating from **Omarchy (Hyprland on Arch Linux)** to **Fedora with Sway**.

## Overview

This guide will:
1. Help you backup your Arch/Omarchy setup
2. Install Fedora
3. Set up Sway with your migrated configuration
4. Restore your workflows and applications

## Phase 1: Backup Your Arch/Omarchy Setup

Before touching anything, backup all your data and configs.

### 1.1 Backup Configurations

```bash
# Create backup directory
mkdir -p ~/migration-backup

# Backup configs
cp -r ~/.config ~/migration-backup/config
cp -r ~/.local/share ~/migration-backup/local-share

# Backup dotfiles
cp -r ~/dotfiles ~/migration-backup/dotfiles

# Export list of installed packages
pacman -Qqe > ~/migration-backup/arch-packages.txt
pacman -Qqm > ~/migration-backup/aur-packages.txt

# Export keybindings for reference
omarchy menu keybindings --print > ~/migration-backup/hyprland-keybindings.txt

# Backup theme info
omarchy theme current > ~/migration-backup/current-theme.txt

# Backup to external drive or cloud
# rsync -av ~/migration-backup /path/to/external/drive
```

### 1.2 Backup Personal Data

```bash
# Documents, Pictures, Videos, etc.
# rsync -av ~/Documents /path/to/external/drive
# rsync -av ~/Pictures /path/to/external/drive
# rsync -av ~/Videos /path/to/external/drive

# Browser profiles, mail, etc. (if not synced to cloud)
```

### 1.3 Note Your Specific Setup

Record the following for reference:

```bash
# Monitor configuration
hyprctl monitors > ~/migration-backup/monitors.txt

# Input devices
hyprctl devices > ~/migration-backup/devices.txt

# Current theme details
cat ~/.config/omarchy/current/theme/hyprland.conf > ~/migration-backup/theme-config.conf
```

## Phase 2: Install Fedora

### 2.1 Choose Fedora Edition

**Option A: Fedora Workstation** (Recommended)
- Familiar GNOME desktop
- Install Sway on top
- Good hardware support
- Download: https://fedoraproject.org/workstation/

**Option B: Fedora Sway Spin**
- Pre-configured Sway desktop
- Minimal setup required
- Less bloat than Workstation
- Download: https://fedoraproject.org/spins/sway/

**Option C: Fedora Everything**
- Minimal base install
- Build from scratch
- Maximum control
- Download: https://fedoraproject.org/wiki/Releases/Everything

### 2.2 Create Installation Media

```bash
# On Arch (with USB drive inserted)
sudo dd if=Fedora-Workstation-Live-x86_64-XX-Y.iso of=/dev/sdX bs=4M status=progress && sync

# Replace /dev/sdX with your USB device
# Replace XX-Y with version number (e.g., 41-1.0)
```

### 2.3 Install Fedora

1. Boot from USB drive
2. Follow installer prompts
3. Choose "Automatic partitioning" or "Custom partitioning" (if you know what you're doing)
4. For dual-boot: Use custom partitioning, don't format existing partitions you want to keep
5. Create user account
6. Reboot

## Phase 3: Initial Fedora Setup

### 3.1 First Boot

1. Complete initial setup wizard
2. Connect to network
3. Update system:

```bash
sudo dnf upgrade --refresh
```

### 3.2 Enable RPM Fusion

RPM Fusion provides multimedia codecs, proprietary drivers, and additional software not in Fedora's repos.

```bash
# Enable RPM Fusion Free and Non-free
sudo dnf install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update metadata
sudo dnf group update core
```

### 3.3 Install Multimedia Codecs

```bash
# Install multimedia support
sudo dnf group install "Multimedia"

# Install additional codecs
sudo dnf install ffmpeg ffmpeg-libs gstreamer1-plugins-{base,good,bad-free,bad-freeworld,ugly-free,ugly-freeworld}
```

## Phase 4: Install Sway and Tools

### 4.1 Automated Installation (Recommended)

Use the provided installation script:

```bash
# Clone or copy your migration project
cd /path/to/sway-migration

# Make executable
chmod +x fedora/install.sh

# Run installer
./fedora/install.sh

# Choose option 'A' for full installation
```

### 4.2 Manual Installation

Alternatively, install packages manually:

```bash
# Sway ecosystem
sudo dnf install sway swaylock swayidle waybar wl-clipboard grim slurp mako wofi

# Terminals
sudo dnf install alacritty foot kitty

# Utilities
sudo dnf install btop htop curl wget git tmux fzf ripgrep fd-find bat exa

# Development
sudo dnf install neovim python3 nodejs go rustcargo

# Fonts
sudo dnf install jetbrains-mono-fonts-all mozilla-fira-fonts-common

# Audio/Video
sudo dnf install pamixer pavucontrol playerctl brightnessctl

# File managers
sudo dnf install nautilus thunar gvfs

# Browsers
sudo dnf install firefox chromium

# Network and Polkit
sudo dnf install network-manager-applet blueberry lxpolkit
```

**Note**: `polkit-gnome` is not available on Fedora. Use `lxpolkit` instead - it's lightweight and works perfectly with Sway.

### 4.3 Enable Flathub

For additional applications (Spotify, Signal, Obsidian, etc.):

```bash
# Install Flatpak
sudo dnf install flatpak

# Enable Flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install common apps
flatpak install flathub com.spotify.Client
flatpak install flathub org.signal.Signal
flatpak install flathub md.obsidian.Obsidian
```

## Phase 5: Deploy Configuration

### 5.1 Copy Configuration Files

```bash
# If you have the migration project ready
cd /path/to/sway-migration

# Install Sway config
mkdir -p ~/.config/sway
cp config ~/.config/sway/
cp -r config.d ~/.config/sway/

# Install Waybar config
mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/
cp waybar/style.css ~/.config/waybar/
```

### 5.2 Customize for Your Hardware

Edit the configuration to match your hardware:

```bash
# Check available outputs
swaymsg -t get_outputs

# Edit monitor configuration
nano ~/.config/sway/config.d/output

# Check input devices
swaymsg -t get_inputs

# Edit input configuration
nano ~/.config/sway/config.d/input
```

### 5.3 Restore Personal Files

```bash
# Restore from backup
rsync -av /path/to/backup/Documents ~/
rsync -av /path/to/backup/Pictures ~/
rsync -av /path/to/backup/Videos ~/

# Restore other personal data as needed
```

## Phase 6: Test Sway

### 6.1 Test Configuration

```bash
# Test Sway with your config
sway

# Press Super+Shift+e to exit
```

### 6.2 Verify Functionality

Test these essential features:

- [ ] Keybindings work (Super+Return opens terminal)
- [ ] Monitor configuration is correct
- [ ] Waybar displays properly
- [ ] Screenshots work (Print, Super+Print)
- [ ] Volume/brightness keys work
- [ ] Network manager applet works
- [ ] Notifications work (mako)
- [ ] All applications launch

### 6.3 Debug Issues

If something doesn't work:

```bash
# Check Sway logs
journalctl --user -u sway

# Check config errors
swaymsg reload

# Check Waybar logs
journalctl --user -u waybar

# Test Waybar manually
waybar -c ~/.config/waybar/config.jsonc
```

## Phase 7: Daily Driver Setup

### 7.1 Set Sway as Default

**If using GDM (GNOME Display Manager):**

1. Install Sway session file (should already be installed):
   ```bash
   sudo dnf install sway
   ```

2. Log out
3. Click your username
4. Click the gear icon
5. Select "Sway"
6. Log in

**If using TTY (no display manager):**

```bash
# Add to ~/.bash_profile
echo 'if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then' >> ~/.bash_profile
echo '  exec sway' >> ~/.bash_profile
echo 'fi' >> ~/.bash_profile
```

### 7.2 Configure Autostart

Edit `~/.config/sway/config.d/autostart` to enable:

- Waybar
- Mako notifications
- Polkit agent (lxqt-policykit-agent)
- Network applet
- Bluetooth applet

**Important**: Use `lxqt-policykit-agent` on Fedora. The config already includes this, but verify it's uncommented.

### 7.3 Theme Setup

Install Catppuccin theme:

```bash
# GTK theme (from Flathub)
flatpak install flathub org.gtk.Gtk3theme.catppuccin-mocha

# Set GTK theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adw-gtk3-dark'

# For complete Catppuccin theming, see:
# https://github.com/catppuccin/catppuccin
```

### 7.4 Install Additional Apps

From Flatpak (recommended):

```bash
# Communication
flatpak install flathub org.signal.Signal
flatpak install flathub com.discordapp.Discord
flatpak install flathub org.telegram.desktop

# Productivity
flatpak install flathub md.obsidian.Obsidian

# Development
flatpak install flathub com.visualstudio.code
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community

# Media
flatpak install flathub com.spotify.Client
flatpak install flathub org.videolan.VLC
```

From Fedora repos:

```bash
# LibreOffice
sudo dnf install libreoffice-fresh

# Graphics
sudo dnf install gimp inkscape
```

## Phase 8: Omarchy Alternatives on Fedora

### 8.1 Screenshots

**Omarchy:**
```bash
omarchy capture screenshot
```

**Fedora (with this config):**
```bash
# Print - Full screen
# Super+Print - Select region
# Super+Shift+Print - Current window
```

### 8.2 Night Light

**Omarchy:**
```bash
omarchy toggle nightlight
```

**Fedora:**
```bash
# Install wlsunset
sudo dnf install wlsunset

# Run with your coordinates
wlsunset -l 37.7749 -L 122.4194
```

### 8.3 Theme Management

**Omarchy:**
```bash
omarchy theme set catppuccin
```

**Fedora:**
Manual configuration. Edit:
- `~/.config/sway/config.d/appearance` for Sway colors
- `~/.config/waybar/style.css` for Waybar styles
- Use `gsettings` for GTK themes

### 8.4 System Updates

**Omarchy/Arch:**
```bash
omarchy update
sudo pacman -Syu
```

**Fedora:**
```bash
sudo dnf upgrade --refresh
```

### 8.5 Package Management

**Arch/Omarchy:**
```bash
sudo pacman -S package
yay -S aur-package
```

**Fedora:**
```bash
sudo dnf install package
flatpak install flathub app-id
```

## Phase 9: Troubleshooting

### 9.1 Sway Won't Start

```bash
# Check if Sway is installed
which sway

# Check config syntax
sway -c ~/.config/sway/config -v

# Check for missing dependencies
ldd $(which sway)
```

### 9.2 Waybar Not Showing

```bash
# Check if Waybar is running
ps aux | grep waybar

# Test manually
waybar -c ~/.config/waybar/config.jsonc

# Check logs
journalctl --user -u waybar
```

### 9.3 Missing Applications

Some Omarchy apps may not be available on Fedora:

| Omarchy App | Fedora Alternative | Install |
|-------------|-------------------|---------|
| walker | wofi, fuzzel | `sudo dnf install wofi` |
| 1password | 1Password (Flatpak) | `flatpak install 1password` |
| typora | MarkText, Obsidian | `flatpak install obsidian` |

### 9.4 Performance Issues

```bash
# Check GPU drivers
lspci -k | grep -A 2 -E "(VGA|3D)"

# For NVIDIA, you may need proprietary drivers
sudo dnf install akmod-nvidia

# Check Sway performance
swaymsg -t get_outputs
```

### 9.5 Polkit Authentication Issues

If you get "Authentication failed" or no password prompt when running GUI apps:

```bash
# Install polkit agent
sudo dnf install lxpolkit

# Run it manually to test
lxpolkit &

# Add to autostart in ~/.config/sway/config.d/autostart:
# exec lxpolkit

# Other alternatives if lxpolkit doesn't work:
# - mate-polkit: sudo dnf install mate-polkit
# - xfce-polkit: sudo dnf install xfce-polkit
```

## Phase 10: Post-Migration

### 10.1 Cleanup

```bash
# Remove unused packages
sudo dnf autoremove

# Clean package cache
sudo dnf clean all
```

### 10.2 Backup New Setup

```bash
# Backup Fedora configs
mkdir -p ~/fedora-backup
cp -r ~/.config ~/fedora-backup/

# Export Fedora packages
dnf history userinstalled > ~/fedora-backup/installed-packages.txt
flatpak list > ~/fedora-backup/flatpak-apps.txt
```

### 10.3 Final Steps

- [ ] Test all workflows
- [ ] Verify all essential apps work
- [ ] Configure backups (Borg, Timeshift)
- [ ] Set up power management (if laptop)
- [ ] Configure firewall (Firewalld, pre-installed)
- [ ] Enjoy your new Fedora + Sway setup!

## Quick Reference

```bash
# Update system
sudo dnf upgrade --refresh

# Install package
sudo dnf install <package>

# Search package
sudo dnf search <package>

# Remove package
sudo dnf remove <package>

# Install Flatpak
flatpak install flathub <app-id>

# Reload Sway
swaymsg reload

# Restart Waybar
pkill waybar; waybar &

# Lock screen
swaylock -f -c 1e1e2e

# Screenshot region
grim -g "$(slurp)" - | wl-copy
```

## Resources

- [Fedora Documentation](https://docs.fedoraproject.org/)
- [Fedora Sway Spin](https://fedoraproject.org/spins/sway/)
- [RPM Fusion Configuration Guide](https://rpmfusion.org/Configuration)
- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Arch Fedora Wiki](https://wiki.archlinux.org/title/Fedora)

---

**Migration Checklist:**

- [ ] Backup Arch/Omarchy setup
- [ ] Install Fedora
- [ ] Enable RPM Fusion
- [ ] Install Sway and tools
- [ ] Deploy configurations
- [ ] Test Sway
- [ ] Install additional apps
- [ ] Set up alternatives to Omarchy tools
- [ ] Verify all workflows
- [ ] Backup new setup

Good luck with your migration! 🚀
