# Omarchy (Arch) → Fedora + Sway Migration

Complete migration from **Omarchy (Hyprland on Arch Linux)** to **Fedora with Sway**.

## Why This Migration?

- **Arch → Fedora**: More stable, predictable release cycle, still cutting-edge
- **Hyprland → Sway**: Mature, stable, i3-compatible Wayland compositor
- **Omarchy → Vanilla**: More control, less opinionated defaults

## Current Setup (Omarchy/Arch)

### Components
- **OS**: Arch Linux (Omarchy)
- **Compositor**: Hyprland (Wayland)
- **Theme**: Catppuccin
- **Bar**: Waybar
- **Launcher**: Walker
- **Notifications**: Mako
- **Terminals**: Alacritty, Ghostty, Kitty

## Target Setup (Fedora + Sway)

### Components
- **OS**: Fedora Linux (Workstation or Spin)
- **Compositor**: Sway (Wayland)
- **Theme**: Catppuccin (manually configured)
- **Bar**: Waybar
- **Launcher**: Wofi or Fuzzel (Walker alternatives)
- **Notifications**: Mako or Swaync
- **Terminals**: Alacritty, Foot, Kitty

## Migration Status

| Component | Status | Notes |
|-----------|--------|-------|
| Base OS | 📝 TODO | Fedora installation |
| Sway Config | ✅ Created | Main config + modular files |
| Keybindings | ✅ Created | Translated from Hyprland |
| Waybar | ✅ Created | Adapted for Sway |
| Package replacement | 📝 TODO | Arch → Fedora package mapping |
| Omarchy tools | ⚠️ NEEDS REPLACEMENT | Arch/Omarchy-specific tools won't work |

## Fedora vs Arch Differences

| Aspect | Arch (Omarchy) | Fedora |
|--------|----------------|--------|
| Package manager | `pacman` | `dnf` |
| AUR helper | `yay`, `paru` | RPM Fusion |
| Release model | Rolling | 6-month releases |
| Kernel | Latest always | Latest stable |
| Wayland | Experimental | First-class citizen |
| Omarchy | ✅ Available | ❌ Not available |

## Not Available on Fedora

These Omarchy-specific tools won't work on Fedora:

| Omarchy Tool | Fedora Alternative | Install Command |
|--------------|-------------------|-----------------|
| `omarchy` CLI | Manual config | N/A |
| `omarchy theme` | Manual theme files | N/A |
| `omarchy capture` | `grim` + `slurp` | `sudo dnf install grim slurp` |
| `omarchy toggle nightlight` | `wlsunset` | `sudo dnf install wlsunset` |
| `omarchy menu` | `wofi` or `fuzzel` | `sudo dnf install wofi` |
| `omarchy launch-*` | Direct commands | N/A |
| `omarchy update` | `sudo dnf upgrade` | N/A |

## Fedora Installation Steps

### Option A: Fedora Workstation + Sway (Recommended)
1. Download Fedora Workstation
2. Install normally
3. Install Sway on top: `sudo dnf install @sway`

### Option B: Fedora Sway Spin
1. Download Fedora Sway Spin
2. Pre-configured Sway desktop
3. Customize from there

### Option C: Fedora Everything
1. Minimal install
2. Build up from scratch
3. Maximum control

## Post-Install Checklist

- [ ] Enable RPM Fusion (for multimedia codecs, proprietary drivers)
- [ ] Install Sway and Wayland tools
- [ ] Copy configuration files
- [ ] Install theme and fonts
- [ ] Configure terminal
- [ ] Set up dotfiles

## Files in This Project

```
.
├── config                    # Main Sway configuration
├── config.d/                 # Modular configuration files
│   ├── appearance           # Colors, gaps, borders (Catppuccin)
│   ├── autostart            # Startup applications
│   ├── bindings             # Keybindings (from Hyprland)
│   ├── input                # Keyboard, touchpad settings
│   ├── output               # Monitor configuration
│   └── rules                # Window rules
├── waybar/                   # Waybar configs
│   ├── config.jsonc         # Bar config (sway/workspaces)
│   └── style.css            # Styling
├── fedora/                   # Fedora-specific files
│   ├── packages.txt         # Package list for Fedora
│   ├── install.sh           # Post-install script
│   └── rpm-fusion.sh        # Enable RPM Fusion
├── migrate.sh                # Interactive migration helper
├── MIGRATION.md              # Step-by-step migration guide
├── QUICKREF.md               # Quick reference card
├── TODO.md                   # Migration checklist
└── README.md                 # This file
```

## Quick Start (After Fedora Install)

```bash
# 1. Enable RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# 2. Install Sway and tools
sudo dnf install @sway waybar grim slurp wl-clipboard mako wofi brightnessctl pamixer lxpolkit

# 3. Install this config
mkdir -p ~/.config/sway
cp config ~/.config/sway/
cp -r config.d ~/.config/sway/

# 4. Install Waybar config
mkdir -p ~/.config/waybar
cp waybar/config.jsonc ~/.config/waybar/
cp waybar/style.css ~/.config/waybar/

# 5. Test
sway
```

**Note**: `polkit-gnome` is not available on Fedora. This config uses `lxpolkit` instead, which is lightweight and works well with Sway.

## Omarchy Commands → Fedora Alternatives

### System Updates

```bash
# Arch/Omarchy
omarchy update
sudo pacman -Syu

# Fedora
sudo dnf upgrade --refresh
sudo dnf update
```

### Package Management

```bash
# Arch/Omarchy
sudo pacman -S package
yay -S aur-package

# Fedora
sudo dnf install package
sudo dnf search package
sudo dnf remove package
```

### Screenshots

```bash
# Omarchy
omarchy capture screenshot

# Fedora (with this config)
# Press Print for full screen
# Press Super+Print for region
# Press Super+Shift+Print for window
```

### Night Light

```bash
# Omarchy
omarchy toggle nightlight

# Fedora (manual)
wlsunset -l 37.7749 -L 122.4194  # Set your coordinates
```

## Key Resources

- [Fedora Sway Spin](https://fedoraproject.org/spins/sway/)
- [Fedora Docs](https://docs.fedoraproject.org/)
- [RPM Fusion](https://rpmfusion.org/)
- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)

## Next Steps

1. **Read MIGRATION.md** - Complete Fedora installation guide
2. **Run fedora/install.sh** - Automated package installation
3. **Customize config.d/files** - Adapt to your preferences
4. **Test thoroughly** - Before making Fedora your daily driver

---

**Important**: This project assumes a fresh Fedora installation. If you're dual-booting or have existing data, backup everything first!
