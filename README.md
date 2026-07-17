# Omarchy to Sway Migration

Migration project from **Omarchy (Hyprland)** to **Sway** on Arch Linux.

## Current Setup (Hyprland/Omarchy)

### Components
- **Compositor**: Hyprland (Wayland)
- **Theme**: Catppuccin (with custom aether theme available)
- **Bar**: Waybar (symlinked to ~/dotfiles)
- **Launcher**: Walker
- **Notifications**: Mako
- **Terminals**: Alacritty, Ghostty, Kitty
- **OSD**: SwayOSD

### Key Configuration Details
- Gaps: 5px inner, 10px outer
- Borders: 2px, active gradient border colors
- Layout: Dwindle
- Workspaces: 10 workspaces with workspace bindings
- Monitor: eDP-1 at 1366x768@60, scaled to 0.9

## Sway Migration Status

| Component | Status | Notes |
|-----------|--------|-------|
| Basic Config | ✅ Created | `config` - Main Sway configuration |
| Keybindings | ✅ Created | Translated from Hyprland bindings |
| Appearance | ✅ Created | Gaps, borders, colors (Catppuccin theme) |
| Waybar | ⚠️ Needs Update | Change `hyprland/workspaces` to `sway/workspaces` |
| Input/Output | ✅ Created | Monitor and input device configuration |
| Autostart | ✅ Created | Startup applications |
| Window Rules | 📝 TODO | Translate Hyprland window rules to Sway `for_window` |
| Idle/Lock | 📝 TODO | Translate hypridle/hyprlock to swayidle/swaylock |
| Screenshots | 📝 TODO | Configure grim/slurp bindings |

## Key Differences: Hyprland vs Sway

| Feature | Hyprland | Sway |
|---------|----------|------|
| Config Syntax | Custom DSL | i3-compatible |
| Layouts | Dwindle, Master | splith/splitv/tabbed/stacking |
| Animations | Advanced animations | Minimal (fade/slide) |
| Decorations | Blur, shadows, rounding | Simple borders |
| Window Rules | `windowrule = ...` | `for_window [...] ...` |
| Keybinding Format | `bind = MOD, key, action` | `bindsym $mod+key action` |

## Testing Sway

To test Sway without replacing Hyprland:

```bash
# From TTY (Ctrl+Alt+F2) or from Hyprland terminal
sway

# Or use a specific config
sway -c ./config
```

To switch completely:
```bash
# Install Sway (if not installed)
sudo pacman -S sway swaylock swayidle waybar grim slurp

# Remove Hyprland from autologin (if configured)
# Edit /etc/gdm/custom.conf or your display manager config

# Enable Sway session at login
# This depends on how you log in (GDM, SDDM, tty + bash_profile)
```

## Files in This Project

```
.
├── config              # Main Sway configuration
├── config.d/           # Modular config files
│   ├── bindings        # Keybindings (translated from Hyprland)
│   ├── appearance      # Colors, gaps, borders (Catppuccin)
│   ├── input          # Keyboard, touchpad, mouse settings
│   ├── output         # Monitor configuration
│   ├── autostart      # Startup applications
│   └── rules          # Window rules
├── waybar/            # Waybar configs adapted for Sway
│   ├── config.jsonc   # Bar config (needs sway/workspaces)
│   └── style.css      # Styling (compatible as-is)
└── README.md          # This file
```

## Next Steps

1. **Test the config**: Run `sway -c ./config` from a TTY
2. **Adapt Waybar**: Replace `hyprland/workspaces` with `sway/workspaces`
3. **Configure idle/lock**: Set up swayidle + swaylock
4. **Screenshot bindings**: Add grim/slurp bindings
5. **Fine-tune**: Adjust keybindings and workspace behavior to match Hyprland

## Resources

- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [i3 User's Guide](https://i3wm.org/docs/userguide.html) (Sway is compatible)
- [Sway Migration Guide](https://github.com/swaywm/sway/wiki/i3-Migration-Guide)
- [Hyprland to Sway Migration Tips](https://github.com/swaywm/sway/wiki/Differences-from-i3)
# sway-migration
