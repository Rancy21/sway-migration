# Migration Checklist

Track your progress from Omarchy (Hyprland) to Sway.

## Pre-Migration ✓

- [x] Documented current Hyprland setup
- [x] Created Sway config files
- [x] Translated keybindings
- [x] Translated appearance settings
- [x] Translated window rules
- [x] Adapted Waybar config

## Installation

- [ ] Install Sway
  ```bash
  sudo pacman -S sway
  ```

- [ ] Install required packages
  ```bash
  sudo pacman -S swaylock swayidle waybar grim slurp wl-clipboard
  sudo pacman -S mako bemenu brightnessctl pamixer playerctl
  ```

- [ ] Install optional packages
  ```bash
  sudo pacman -S wofi cliphist polkit-gnome
  ```

## Configuration

- [ ] Review and customize `config.d/output` for your monitors
  ```bash
  swaymsg -t get_outputs  # Show available outputs
  ```

- [ ] Review and customize `config.d/input` for keyboard/mouse
  ```bash
  swaymsg -t get_inputs  # Show available inputs
  ```

- [ ] Review `config.d/autostart` and enable desired daemons

- [ ] Review `config.d/rules` and customize window behavior

- [ ] Customize Waybar modules in `waybar/config.jsonc`

## Testing

- [ ] Test Sway configuration
  ```bash
  sway -c ./config
  ```

- [ ] Verify keybindings work

- [ ] Check monitor configuration

- [ ] Test Waybar
  ```bash
  pkill waybar; waybar -c ./waybar/config.jsonc
  ```

- [ ] Test screenshot bindings (Print, Mod+Print)

- [ ] Test volume/brightness keys

- [ ] Test workspace switching

- [ ] Test window rules (floating apps)

## Deployment

- [ ] Copy config to standard location
  ```bash
  mkdir -p ~/.config/sway
  cp config ~/.config/sway/
  cp -r config.d ~/.config/sway/
  ```

- [ ] Copy Waybar config
  ```bash
  mkdir -p ~/.config/waybar
  cp waybar/config.jsonc ~/.config/waybar/
  cp waybar/style.css ~/.config/waybar/
  ```

## Post-Migration

- [ ] Configure swayidle for screen lock
- [ ] Configure swaylock appearance
- [ ] Set up screenshot scripts
- [ ] Configure night light (wlsunset/gammastep)
- [ ] Set GTK theme to Catppuccin
- [ ] Configure clipboard manager (cliphist)
- [ ] Test all Omarchy workflows in Sway

## Optional Enhancements

- [ ] Install picom for additional effects (blur, shadows)
  ```bash
  sudo pacman -S picom
  ```

- [ ] Set up touchpad gestures (libinput-gestures or fusuma)
  ```bash
  sudo pacman -S libinput-gestures
  ```

- [ ] Configure notification filters in Mako

- [ ] Create custom scripts for common tasks

- [ ] Set up dual-monitor workspace assignments

## Known Differences from Hyprland

### Features NOT available in Sway:

- ❌ Advanced animations (fade, slide only)
- ❌ Window blur effects (use picom if needed)
- ❌ Per-window corner radius
- ❌ Advanced workspace animations
- ❌ Hyprland's built-in window grouping

### Alternative Workflows:

| Omarchy Command | Sway Alternative | Status |
|-----------------|------------------|--------|
| `omarchy capture screenshot` | `grim` + `slurp` | [ ] |
| `omarchy toggle nightlight` | `wlsunset` | [ ] |
| `omarchy menu keybindings` | Custom script | [ ] |
| `omarchy theme set` | Manual config edit | [ ] |
| `omarchy restart waybar` | `pkill waybar; waybar` | [ ] |
| `omarchy launch-*` | Direct app launch | [ ] |

## Notes

- Record any issues encountered:
  - _Issue 1:_
  - _Issue 2:_

- Custom scripts needed:
  - _Script 1:_
  - _Script 2:_

- Apps that need special configuration:
  - _App 1:_
  - _App 2:_

## Completion

When all items are checked:

- [ ] Verified all workflows work in Sway
- [ ] Documented any differences from Hyprland
- [ ] Ready to make Sway the daily driver

**Migration completed on:** _Date_

---

## Quick Reference

Test config:
```bash
sway -c ./config
```

Reload sway:
```bash
swaymsg reload
```

Check errors:
```bash
swaymsg -t get_outputs
swaymsg -t get_inputs
```

Restart waybar:
```bash
pkill waybar; waybar &
```

Lock screen:
```bash
swaylock -f -c 1e1e2e
```

Exit sway:
```bash
swaymsg exit
```
