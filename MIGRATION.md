# Migration Guide: Omarchy (Hyprland) to Sway

Complete step-by-step guide for migrating from Omarchy/Hyprland to Sway.

## Prerequisites

### Required Packages

```bash
# Install Sway and essential components
sudo pacman -S sway swaylock swayidle waybar grim slurp wl-clipboard

# Optional but recommended
sudo pacman -S mako bemenu wofi brightnessctl pamixer playerctl

# Clipboard manager (optional)
sudo pacman -S cliphist

# Policy kit agent (for authentication dialogs)
sudo pacman -S polkit-gnome
```

### Check Current Setup

Before migrating, document your current Hyprland setup:

```bash
# List current keybindings
omarchy menu keybindings --print

# Show monitor configuration
hyprctl monitors

# Export current theme
omarchy theme current

# Backup current configs
cp -r ~/.config/hypr ~/.config/hypr.backup
cp -r ~/.config/waybar ~/.config/waybar.backup
```

## Step 1: Install Sway

```bash
sudo pacman -S sway
```

## Step 2: Test Configuration

Test without leaving Hyprland:

```bash
# From a TTY (Ctrl+Alt+F3) or from within Hyprland
sway -c ./config
```

This will start Sway with your migrated config. Press `$mod+Shift+e` to exit.

## Step 3: Install Required Daemons

### Waybar

```bash
sudo pacman -S waybar
```

Copy the Waybar config:
```bash
mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/
cp waybar/style.css ~/.config/waybar/
```

### Notifications (Mako)

```bash
sudo pacman -S mako
```

You can use your existing Mako config from Omarchy.

### Screenshots

```bash
sudo pacman -S grim slurp wl-clipboard
```

### Idle Management

```bash
sudo pacman -S swaylock swayidle
```

## Step 4: Configure Autostart

Edit `./config.d/autostart` to match your Omarchy startup applications.

Common Omarchy autostart items:
- Waybar (status bar)
- Mako (notifications)
- Walker (app launcher)
- Polkit agent

## Step 5: Migrate Keybindings

Your Hyprland keybindings have been translated to Sway format in `./config.d/bindings`.

### Key Differences:

| Hyprland | Sway | Example |
|----------|------|---------|
| `bind = SUPER, Return, exec, $term` | `bindsym $mod+Return exec $term` | Launch terminal |
| `bind = SUPER SHIFT, Q, killactive` | `bindsym $mod+Shift+q kill` | Kill window |
| `windowrule = float, class:firefox` | `for_window [class="firefox"] floating enable` | Window rules |

## Step 6: Migrate Monitor Configuration

Edit `./config.d/output` based on your monitor setup:

```bash
# Check available outputs
swaymsg -t get_outputs

# Edit config
nano ./config.d/output
```

## Step 7: Migrate Window Rules

Edit `./config.d/rules` to match your Hyprland window rules.

To find app_id or class in Sway:
```bash
swaymsg -t get_tree | jq '.[] | select(.type=="con") | {name, app_id, window_properties}'
```

## Step 8: Test Everything

```bash
# Test sway with your config
sway -c ./config

# Check for errors
swaymsg -t get_outputs
swaymsg -t get_inputs
```

## Step 9: Final Installation

Once you're satisfied with the config:

```bash
# Copy config to standard location
mkdir -p ~/.config/sway
cp config ~/.config/sway/
cp -r config.d ~/.config/sway/

# Copy Waybar config
mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/
cp waybar/style.css ~/.config/waybar/
```

## Step 10: Switch to Sway

### Method A: Display Manager (Recommended for beginners)

If using GDM/SDDM:
1. Logout
2. Select "Sway" from the session menu
3. Login

### Method B: TTY (Recommended for advanced users)

```bash
# Edit ~/.bash_profile or ~/.zprofile
echo 'if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then' >> ~/.bash_profile
echo '  exec sway' >> ~/.bash_profile
echo 'fi' >> ~/.bash_profile
```

Then:
1. Logout
2. Switch to TTY1 (Ctrl+Alt+F1)
3. Login - Sway will start automatically

### Method C: Keep Both (Gradual Migration)

Keep Hyprland as default, manually start Sway when testing:

```bash
# From Hyprland terminal or TTY
sway
```

## Post-Migration Tasks

### 1. Install Missing Tools

Some Omarchy tools won't work in Sway. Alternatives:

| Omarchy | Sway Alternative | Install |
|---------|------------------|---------|
| `omarchy-capture screenshot` | `grim` + `slurp` | `pacman -S grim slurp` |
| `omarchy toggle nightlight` | `wlsunset` or `gammastep` | `pacman -S wlsunset` |
| Walker launcher | `wofi` or `bemenu` | `pacman -S wofi` |

### 2. Configure Idle/Lock

Edit the idle section in `./config.d/autostart`:

```bash
exec swayidle -w \
    timeout 300 'swaylock -f -c 1e1e2e' \
    timeout 600 'swaymsg "output * power off"' \
    resume 'swaymsg "output * power on"' \
    before-sleep 'swaylock -f -c 1e1e2e'
```

### 3. Create Custom Scripts

Some Omarchy commands need replacement scripts:

```bash
mkdir -p ~/.local/bin

# Example: screenshot script
cat > ~/.local/bin/screenshot << 'EOF'
#!/bin/bash
grim -g "$(slurp)" - | wl-copy
EOF
chmod +x ~/.local/bin/screenshot
```

### 4. GTK Theme

Set GTK theme to match Catppuccin:

```bash
# Install Catppuccin GTK theme
yay -S catppuccin-gtk-theme-mocha

# Set theme
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Lavender-Dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'
```

## Troubleshooting

### Waybar not showing workspaces

- Check that you're using `sway/workspaces` not `hyprland/workspaces` in config.jsonc
- Restart waybar: `pkill waybar; waybar &`

### Keyboard shortcuts not working

- Check config syntax: `sway -c ./config -v`
- Verify mod key: ensure `$mod` is set to `Mod4` (Super key)

### Monitor configuration not applied

- Check output names: `swaymsg -t get_outputs`
- Verify config syntax matches output names exactly

### Apps not floating/maximizing correctly

- Find app_id or class: `swaymsg -t get_tree | jq '.[] | select(.type=="con") | {name, app_id}'`
- Update window rules in `./config.d/rules`

### GTK themes not applying

- Install `nwg-look` or `lxappearance`
- Run: `nwg-look` and select theme

### Screen tearing

- Enable vsync: `output * adaptive_sync on`

### No notifications

- Start mako: `mako &`
- Check logs: `journalctl --user -u mako`

## Rollback

If something goes wrong and you want to return to Hyprland:

```bash
# Restore Hyprland configs
cp -r ~/.config/hypr.backup ~/.config/hypr

# Logout and select Hyprland from display manager
# Or from TTY:
hyprland
```

## Resources

- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Sway i3 Migration Guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)
- [Arch Wiki Sway](https://wiki.archlinux.org/title/Sway)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)

## Getting Help

- Sway IRC: #sway on irc.libera.chat
- Reddit: r/swaywm
- Arch Forums: https://bbs.archlinux.org

---

**Next Steps**: After migration is complete, check `README.md` for configuration options and daily usage tips.
