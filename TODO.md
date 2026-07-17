# Migration Checklist: Omarchy (Arch) → Fedora + Sway

Complete checklist for migrating from Omarchy/Hyprland to Fedora + Sway.

## Phase 1: Pre-Migration Backup

### Arch/Omarchy Backup
- [ ] Backup all configurations
  ```bash
  mkdir -p ~/migration-backup
  cp -r ~/.config ~/migration-backup/config
  cp -r ~/.local/share ~/migration-backup/local-share
  cp -r ~/dotfiles ~/migration-backup/dotfiles
  ```

- [ ] Export package lists
  ```bash
  pacman -Qqe > ~/migration-backup/arch-packages.txt
  pacman -Qqm > ~/migration-backup/aur-packages.txt
  ```

- [ ] Export keybindings for reference
  ```bash
  omarchy menu keybindings --print > ~/migration-backup/keybindings.txt
  omarchy theme current > ~/migration-backup/theme.txt
  hyprctl monitors > ~/migration-backup/monitors.txt
  ```

- [ ] Backup personal data
  - [ ] Documents
  - [ ] Pictures
  - [ ] Videos
  - [ ] Music
  - [ ] Browser profiles (Firefox, Chrome, etc.)
  - [ ] SSH keys (`~/.ssh`)
  - [ ] GPG keys (`~/.gnupg`)

- [ ] Backup to external drive or cloud

## Phase 2: Fedora Installation

### Download Fedora
- [ ] Choose edition:
  - [ ] Fedora Workstation (Recommended)
  - [ ] Fedora Sway Spin
  - [ ] Fedora Everything

- [ ] Download ISO from https://fedoraproject.org/

### Create Installation Media
- [ ] Create bootable USB
  ```bash
  sudo dd if=Fedora-*.iso of=/dev/sdX bs=4M status=progress && sync
  ```

### Install Fedora
- [ ] Boot from USB
- [ ] Follow installer
- [ ] Configure disk partitions (if dual-booting)
- [ ] Create user account
- [ ] Complete installation
- [ ] Reboot

## Phase 3: Initial Fedora Setup

### First Boot
- [ ] Complete initial setup wizard
- [ ] Connect to network
- [ ] Update system
  ```bash
  sudo dnf upgrade --refresh
  ```

### Enable RPM Fusion
- [ ] Enable RPM Fusion repositories
  ```bash
  sudo dnf install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
  ```

- [ ] Update metadata
  ```bash
  sudo dnf group update core
  ```

### Install Multimedia Codecs
- [ ] Install multimedia support
  ```bash
  sudo dnf group install "Multimedia"
  sudo dnf install ffmpeg ffmpeg-libs gstreamer1-plugins-{base,good,bad-free,bad-freeworld}
  ```

## Phase 4: Install Sway and Tools

### Automated Installation (Recommended)
- [ ] Run installation script
  ```bash
  cd /path/to/sway-migration
  chmod +x fedora/install.sh
  ./fedora/install.sh
  ```
- [ ] Choose option 'A' for full installation

### Or Manual Installation

#### Core Sway Packages
- [ ] Install Sway ecosystem
  ```bash
  sudo dnf install sway swaylock swayidle waybar wl-clipboard grim slurp mako wofi
  ```

#### Terminals
- [ ] Install terminal emulators
  ```bash
  sudo dnf install alacritty foot kitty
  ```

#### Utilities
- [ ] Install essential utilities
  ```bash
  sudo dnf install btop htop curl wget git tmux fzf ripgrep fd-find bat exa
  ```

#### Development Tools
- [ ] Install development tools
  ```bash
  sudo dnf install neovim python3 nodejs go rustcargo clang
  ```

#### Fonts
- [ ] Install fonts
  ```bash
  sudo dnf install jetbrains-mono-fonts-all mozilla-fira-fonts-common
  ```

- [ ] Install Nerd Fonts manually from https://www.nerdfonts.com/

#### Audio/Video
- [ ] Install audio/video tools
  ```bash
  sudo dnf install pamixer pavucontrol playerctl brightnessctl
  ```

#### File Managers
- [ ] Install file managers
  ```bash
  sudo dnf install nautilus thunar gvfs
  ```

#### Browsers
- [ ] Install browsers
  ```bash
  sudo dnf install firefox chromium
  ```

#### Network Tools
- [ ] Install network tools
  ```bash
  sudo dnf install network-manager-applet blueberry lxpolkit
  ```

## Phase 5: Deploy Configuration

### Install Configs
- [ ] Install Sway configuration
  ```bash
  mkdir -p ~/.config/sway
  cp config ~/.config/sway/
  cp -r config.d ~/.config/sway/
  ```

- [ ] Install Waybar configuration
  ```bash
  mkdir -p ~/.config/waybar
  cp waybar/config.jsonc ~/.config/waybar/
  cp waybar/style.css ~/.config/waybar/
  ```

### Customize for Hardware
- [ ] Check available monitors
  ```bash
  swaymsg -t get_outputs
  ```

- [ ] Edit monitor configuration
  ```bash
  nano ~/.config/sway/config.d/output
  ```

- [ ] Check input devices
  ```bash
  swaymsg -t get_inputs
  ```

- [ ] Edit input configuration
  ```bash
  nano ~/.config/sway/config.d/input
  ```

## Phase 6: Enable Flathub

- [ ] Install Flatpak
  ```bash
  sudo dnf install flatpak
  ```

- [ ] Enable Flathub repository
  ```bash
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  ```

- [ ] Install common Flatpak apps
  ```bash
  flatpak install flathub com.spotify.Client
  flatpak install flathub org.signal.Signal
  flatpak install flathub md.obsidian.Obsidian
  ```

## Phase 7: Restore Personal Data

- [ ] Restore Documents
- [ ] Restore Pictures
- [ ] Restore Videos
- [ ] Restore Music
- [ ] Restore SSH keys
  ```bash
  cp -r /path/to/backup/.ssh ~/
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_rsa
  ```

- [ ] Restore GPG keys (if applicable)
- [ ] Restore browser profiles (if applicable)
- [ ] Restore other personal files

## Phase 8: Test Sway

### Test Configuration
- [ ] Test Sway config
  ```bash
  sway
  ```

### Verify Keybindings
- [ ] Terminal (Super+Return)
- [ ] Browser (Super+Shift+b)
- [ ] File manager (Super+Shift+f)
- [ ] Kill window (Super+q)
- [ ] Fullscreen (Super+f)
- [ ] Floating toggle (Super+Shift+space)

### Verify Features
- [ ] Monitor configuration correct
- [ ] Waybar displays properly
- [ ] Screenshots work (Print, Super+Print)
- [ ] Volume keys work
- [ ] Brightness keys work (laptop)
- [ ] Network applet works
- [ ] Bluetooth applet works
- [ ] Notifications work (mako)
- [ ] All applications launch

### Debug Issues if Needed
- [ ] Check Sway logs
  ```bash
  journalctl --user -u sway
  ```

- [ ] Test Waybar manually
  ```bash
  waybar -c ~/.config/waybar/config.jsonc
  ```

## Phase 9: Make Fedora Daily Driver

### Set Up Autostart
- [ ] Edit autostart config
  ```bash
  nano ~/.config/sway/config.d/autostart
  ```

- [ ] Enable Waybar
- [ ] Enable Mako
- [ ] Enable network applet
- [ ] Enable other daemons

### Theme Setup
- [ ] Install Catppuccin GTK theme
  ```bash
  flatpak install flathub org.gtk.Gtk3theme.catppuccin-mocha
  ```

- [ ] Set GTK theme
  ```bash
  gsettings set org.gnome.desktop.interface gtk-theme 'Adw-gtk3-dark'
  ```

- [ ] Set icon theme
- [ ] Set cursor theme

### Install Additional Apps

#### Communication
- [ ] Install Signal
  ```bash
  flatpak install flathub org.signal.Signal
  ```

- [ ] Install Discord (if needed)
- [ ] Install Telegram (if needed)

#### Productivity
- [ ] Install Obsidian
  ```bash
  flatpak install flathub md.obsidian.Obsidian
  ```

- [ ] Install LibreOffice
  ```bash
  sudo dnf install libreoffice-fresh
  ```

#### Development
- [ ] Install VS Code (if needed)
  ```bash
  flatpak install flathub com.visualstudio.code
  ```

- [ ] Install IntelliJ (if needed)
- [ ] Configure Git
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```

#### Media
- [ ] Install Spotify
  ```bash
  flatpak install flathub com.spotify.Client
  ```

- [ ] Install VLC or MPV
  ```bash
  sudo dnf install mpv
  ```

## Phase 10: Omarchy Alternatives Setup

### Screenshots
- [ ] Test screenshot bindings
  - [ ] Print (full screen)
  - [ ] Super+Print (region)
  - [ ] Super+Shift+Print (window)

### Night Light
- [ ] Install wlsunset
  ```bash
  sudo dnf install wlsunset
  ```

- [ ] Configure with your coordinates
  ```bash
  wlsunset -l LATITUDE -L LONGITUDE
  ```

- [ ] Add to autostart

### System Updates
- [ ] Learn Fedora update command
  ```bash
  sudo dnf upgrade --refresh
  ```

### Package Management
- [ ] Learn DNF commands
  ```bash
  sudo dnf search <package>
  sudo dnf install <package>
  sudo dnf remove <package>
  ```

- [ ] Learn Flatpak commands
  ```bash
  flatpak search <app>
  flatpak install flathub <app-id>
  flatpak update
  ```

## Phase 11: Power Management (Laptop)

- [ ] Install powertop
  ```bash
  sudo dnf install powertop
  ```

- [ ] Calibrate powertop
  ```bash
  sudo powertop --calibrate
  ```

- [ ] Optionally install TLP (advanced power management)
  ```bash
  sudo dnf install tlp
  sudo systemctl enable tlp
  ```

## Phase 12: Security and Backup

### Firewall
- [ ] Configure Firewalld (pre-installed)
  ```bash
  sudo firewall-cmd --state
  sudo firewall-config  # GUI
  ```

### Backup Solution
- [ ] Set up backup tool
  - [ ] Timeshift (system backups)
    ```bash
    sudo dnf install timeshift
    ```
  - [ ] Borg (personal data)
    ```bash
    sudo dnf install borgbackup
    ```

- [ ] Configure automated backups

## Phase 13: Final Steps

### Cleanup
- [ ] Remove unused packages
  ```bash
  sudo dnf autoremove
  ```

- [ ] Clean package cache
  ```bash
  sudo dnf clean all
  ```

### Backup New Setup
- [ ] Backup Fedora configs
  ```bash
  mkdir -p ~/fedora-backup
  cp -r ~/.config ~/fedora-backup/
  ```

- [ ] Export installed packages
  ```bash
  dnf history userinstalled > ~/fedora-backup/installed.txt
  flatpak list > ~/fedora-backup/flatpaks.txt
  ```

- [ ] Backup to external drive

### Verification
- [ ] All essential apps work
- [ ] All keybindings configured
- [ ] Theme applied correctly
- [ ] Backups configured
- [ ] Performance is good
- [ ] Battery life acceptable (laptop)

## Phase 14: Documentation

- [ ] Document any issues encountered
- [ ] Document custom scripts created
- [ ] Document differences from Omarchy
- [ ] Note Fedora-specific configurations

---

## Quick Commands Reference

```bash
# Update system
sudo dnf upgrade --refresh

# Install package
sudo dnf install <package>

# Search package
dnf search <package>

# Remove package
sudo dnf remove <package>

# Install Flatpak
flatpak install flathub <app-id>

# Search Flatpak
flatpak search <app>

# Reload Sway
swaymsg reload

# Restart Waybar
pkill waybar; waybar &

# Lock screen
swaylock

# Screenshot region
grim -g "$(slurp)" - | wl-copy
```

---

**Migration completed on:** _Date_

**Fedora version:** _Version_

**Notes:**
- _Add your notes here_
