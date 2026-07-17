# Quick Reference Card

Essential commands and keybindings for Sway (migrated from Omarchy/Hyprland).

## Essential Commands

| Action | Command |
|--------|---------|
| Test config | `sway -c ./config` |
| Reload config | `$mod+Shift+c` |
| Exit Sway | `$mod+Shift+e` |
| Lock screen | `$mod+Escape` |
| Reload swaymsg | `swaymsg reload` |

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
| Focus parent | `$mod+a` |
| Focus child | `$mod+c` |

## Window Movement

| Action | Binding |
|--------|---------|
| Move left | `$mod+Shift+h` |
| Move down | `$mod+Shift+j` |
| Move up | `$mod+Shift+k` |
| Move right | `$mod+Shift+l` |

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

## Applications (From Hyprland Config)

| App | Binding |
|-----|---------|
| Browser | `$mod+Shift+b` |
| Browser (private) | `$mod+Shift+Alt+b` |
| File manager | `$mod+Shift+f` |
| Editor (VSCode) | `$mod+Shift+c` |
| Editor (Neovim) | `$mod+Shift+n` |
| Music (Spotify) | `$mod+Shift+m` |
| Terminal btop | `$mod+Shift+t` |
| Docker (lazydocker) | `$mod+Shift+d` |
| 1Password | `$mod+Shift+/` |
| Email (HEY) | `$mod+Shift+e` |
| ChatGPT | `$mod+Shift+a` |
| YouTube | `$mod+Shift+y` |
| Signal | `$mod+Shift+g` |
| Suspend | `$mod+Shift+s` |

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

| Action | Binding |
|--------|---------|
| Screenshot region | `$mod+Print` |
| Screenshot full | `Print` |
| Screenshot window | `$mod+Shift+Print` |
| Save to file | `$mod+Ctrl+Print` |

## Media Keys

| Action | Binding |
|--------|---------|
| Volume up | `XF86AudioRaiseVolume` |
| Volume down | `XF86AudioLowerVolume` |
| Mute | `XF86AudioMute` |
| Brightness up | `XF86MonBrightnessUp` |
| Brightness down | `XF86MonBrightnessDown` |
| Play/Pause | `XF86AudioPlay` |
| Next track | `XF86AudioNext` |
| Previous track | `XF86AudioPrev` |

## Gaps Mode

Enter gaps mode: `$mod+Shift+g`

| Action | Binding |
|--------|---------|
| Increase inner gaps | `+` |
| Decrease inner gaps | `-` |
| Reset inner gaps | `0` |
| Increase outer gaps | `Shift++` |
| Decrease outer gaps | `Shift+-` |
| Reset outer gaps | `Shift+0` |
| Exit mode | `Return` or `Escape` |

## Display Mode

Enter display mode: `$mod+Shift+p`

| Action | Binding |
|--------|---------|
| Mirror displays | `m` |
| Extend left | `l` |
| Extend right | `r` |
| Laptop only | `1` |
| External only | `2` |
| Both displays | `3` |

## Common Commands

```bash
# Show outputs
swaymsg -t get_outputs

# Show inputs
swaymsg -t get_inputs

# Show config errors
swaymsg -t get_tree

# List all windows
swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused)'

# Find app_id/class
swaymsg -t get_tree | jq '.[] | select(.type=="con") | {name, app_id}'

# Restart waybar
pkill waybar; waybar &

# Lock screen
swaylock -f -c 1e1e2e

# Suspend
systemctl suspend
```

## Default Values

| Setting | Value |
|---------|-------|
| Mod key | `Mod4` (Super/Windows key) |
| Gaps inner | `5px` |
| Gaps outer | `10px` |
| Border size | `2px` |
| Terminal | `xdg-terminal-exec` |
| Launcher | `walker` (configurable) |
| Theme | Catppuccin Mocha |

## Migration Differences

| Hyprland | Sway |
|----------|------|
| `bind = SUPER, ...` | `bindsym $mod+...` |
| `windowrule = ...` | `for_window [...] ...` |
| `hyprctl` | `swaymsg` |
| Dwindle layout | splith/splitv/tabbed/stacking |
| Advanced animations | Minimal (fade/slide) |
| Blur/shadows | (Use picom for this) |
| `hyprland/workspaces` | `sway/workspaces` |

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

## File Locations

| File | Path |
|------|------|
| Main config | `~/.config/sway/config` |
| Config modules | `~/.config/sway/config.d/` |
| Waybar config | `~/.config/waybar/config.jsonc` |
| Waybar style | `~/.config/waybar/style.css` |
| Mako config | `~/.config/mako/config` |
| Swaylock config | `~/.config/swaylock/config` |

---

**Tip**: Add this to your shell for quick reference:
```bash
alias quickref='cat ~/path/to/sway-migration/QUICKREF.md | less'
```
