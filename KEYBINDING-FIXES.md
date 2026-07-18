# Keybinding Conflicts Fixed

## Issues Resolved

### 1. Duplicate $mod+Ctrl+f
**Problem**: Two bindings for `$mod+Ctrl+f`
- Line 19: `exec nautilus --new-window "$HOME"`
- Line 55: `exec firefox`

**Fix**: Changed Firefox to `$mod+Ctrl+Shift+f`
```bash
# File manager (home directory)
bindsym $mod+Ctrl+f exec nautilus --new-window "$HOME"

# Firefox browser
bindsym $mod+Ctrl+Shift+f exec firefox
```

### 2. Duplicate $mod+Shift+space
**Problem**: Two bindings for `$mod+Shift+space`
- Line 112: `floating toggle` (window management)
- Line 226: `exec wofi --show drun` (app launcher)

**Fix**: Changed app launcher to `$mod+d`
```bash
# Window management
bindsym $mod+Shift+space floating toggle

# App launcher
bindsym $mod+d exec wofi --show drun
```

### 3. Mod1+Shift vs Shift+Mod1 Conflicts
**Problem**: `Mod1+Shift` = `Shift+Mod1` (order doesn't matter in Sway)

**Fixed bindings**:
| Old Binding | New Binding | Function |
|-------------|-------------|----------|
| `$mod+Mod1+Shift+f` | `$mod+Ctrl+f` | File manager (home) |
| `$mod+Shift+Mod1+g` | `$mod+Ctrl+w` | WhatsApp Web |
| `$mod+Shift+Mod1+f` | `$mod+Ctrl+Shift+f` | Firefox |
| `$mod+Shift+Mod1+p` | `$mod+Ctrl+p` | Google Photos |
| `$mod+Shift+Mod1+a` | `$mod+Ctrl+a` | Grok |
| `$mod+Shift+Mod1+x` | `$mod+Ctrl+x` | X post composer |
| `$mod+Shift+Ctrl+g` | `$mod+Ctrl+m` | Google Messages |
| `$mod+Mod1+Shift+g` | `$mod+Shift+Mod1+s` | Signal |
| `$mod+Alt+Shift+w` | `$mod+Ctrl+n` | Standard Notes |

## Final Keybinding Summary

### Core System (No Changes)
```bash
$mod+Return              → Terminal
$mod+Shift+c             → Reload config
$mod+Shift+e             → Exit Sway
$mod+Shift+q             → Kill window
$mod+f                   → Fullscreen
$mod+Shift+space         → Floating toggle
$mod+space               → Focus mode toggle
$mod+d                   → App launcher (Wofi)
```

### Applications
```bash
$mod+Shift+b             → Browser
$mod+Shift+Mod1+b        → Browser (private)
$mod+Shift+f             → File manager
$mod+Ctrl+f              → File manager (home)
$mod+Shift+n             → Editor (Neovim)
$mod+Shift+Mod1+c        → VSCode
$mod+Shift+m             → Spotify
$mod+Shift+t             → btop
$mod+Shift+d             → lazydocker
```

### Web Apps (Updated)
```bash
$mod+Shift+a             → ChatGPT
$mod+Ctrl+a              → Grok
$mod+Shift+y             → YouTube
$mod+Ctrl+w              → WhatsApp Web
$mod+Ctrl+Shift+f        → Firefox
$mod+Ctrl+p              → Google Photos
$mod+Shift+x             → X/Twitter
$mod+Ctrl+x              → X post composer
$mod+Ctrl+m              → Google Messages
```

### Communication
```bash
$mod+Shift+Mod1+s        → Signal
$mod+Shift+o             → Obsidian
$mod+Ctrl+n              → Standard Notes
```

## How to Verify

No more duplicate keybindings:
```bash
# Check for duplicates (should return nothing)
cat ~/.config/sway/config.d/bindings ~/.config/sway/config | \
  grep "^bindsym" | awk '{print $2}' | sort | uniq -d
```

Reload Sway to apply:
```bash
swaymsg reload
```

## Keybinding Philosophy

**When adding new keybindings:**
- Use `$mod+Shift+<key>` for primary actions
- Use `$mod+Ctrl+<key>` for secondary/alternative actions
- Use `$mod+Mod1+Shift+<key>` is same as `$mod+Shift+Mod1+<key>` (avoid both!)
- Avoid using both `Ctrl` and `Mod1` (Alt) in same binding

**Modifier Reference:**
- `Mod1` = Alt key
- `Mod4` = Super/Windows key (default $mod)
- `Ctrl` = Control key
- `Shift` = Shift key
- Order of modifiers doesn't matter in Sway (`Shift+Mod1` = `Mod1+Shift`)
