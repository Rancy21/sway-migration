# Configuration Fixes Applied

## Fixed Errors

### 1. Invalid Pipe Characters (|)
**Issue**: Used `|` instead of `#` for comment headers

**Fixed Files**:
- `config.d/autostart` - Lines 160, 191
- `config.d/rules` - Lines 58, 109

**Solution**: All `| HEADER` changed to `# HEADER`

### 2. Unsupported Touchpad Option
**Issue**: `tap_drag enabled` not supported in all Sway versions

**Fixed in**: `config.d/input` line 58

**Solution**: Commented out with note
```bash
# Tap-and-drag (not supported in all versions)
# tap_drag enabled
```

### 3. Keybinding Conflicts

#### Main Config vs Bindings Config
**Issue**: Duplicate keybindings in `config` and `config.d/bindings`

**Fixed in**: `config`

**Solution**: Commented out duplicates in main config, kept in `config.d/bindings`:
- `$mod+Return` (terminal) - defined in bindings
- `$mod+space` (launcher) - defined in bindings
- `$mod+Shift+c` (reload) - defined in bindings
- `$mod+Shift+e` (exit) - defined in bindings
- `$mod+Shift+n` (notifications) - disabled (conflicts with editor)

#### Application Keybinding Conflicts

**Issue**: Multiple bindings for same key combo

**Fixed in**: `config.d/bindings`

| Key | Old Binding | New Binding | Reason |
|-----|-------------|-------------|--------|
| `$mod+Shift+e` | Email app | **Commented out** | Conflicts with Exit Sway |
| `$mod+Shift+c` | VSCode | `$mod+Shift+Mod1+c` | Conflicts with Reload config |
| `$mod+Shift+g` | Signal | `$mod+Mod1+Shift+g` | Conflicts with Gaps mode |
| `$mod+Shift+p` | Google Photos | `$mod+Shift+Mod1+p` | Conflicts with Display mode |
| `$mod+Shift+n` | Neovim | Unchanged | But notifications now disabled |

## Updated Keybindings

### Changed Keybindings

```bash
# OLD                           # NEW (to avoid conflicts)
$mod+Shift+e (Email)            → Disabled (conflicts with Exit)
$mod+Shift+c (VSCode)           → $mod+Shift+Alt+c
$mod+Shift+g (Signal)           → $mod+Shift+Alt+g
$mod+Shift+p (Google Photos)    → $mod+Shift+Alt+p
```

### Core Window Management (Unchanged)

```bash
$mod+Return                     → Terminal
$mod+space                      → App launcher
$mod+q                          → Kill window
$mod+f                          → Fullscreen
$mod+Shift+c                    → Reload config
$mod+Shift+e                    → Exit Sway
$mod+r                          → Resize mode
$mod+Shift+p                    → Display mode
```

### Application Shortcuts (Updated)

```bash
# Browser & Web
$mod+Shift+b                    → Browser
$mod+Shift+Alt+b                → Browser (private)

# Communication
$mod+Shift+Alt+g                → Signal (changed from $mod+Shift+g)
$mod+Shift+o                    → Obsidian
$mod+Shift+Alt+f                → Firefox

# Productivity
$mod+Shift+Alt+c                → VSCode (changed from $mod+Shift+c)
$mod+Shift+n                    → Neovim
$mod+Shift+Alt+p                → Google Photos (new)
$mod+Shift+/                    → 1Password

# Media
$mod+Shift+m                    → Spotify
$mod+Shift+t                    → btop
$mod+Shift+d                    → lazydocker

# Web Apps
$mod+Shift+e                    → **DISABLED** (was Email - conflicts with Exit)
$mod+Shift+a                    → ChatGPT
$mod+Shift+y                    → YouTube
```

## Quick Reference for Fixed Bindings

| Category | Key | Action |
|----------|-----|--------|
| **System** | `$mod+Shift+e` | Exit Sway |
| **Editor** | `$mod+Shift+Alt+c` | VSCode |
| **Chat** | `$mod+Shift+Alt+g` | Signal |
| **Photos** | `$mod+Shift+Alt+p` | Google Photos |

## How to Verify

After reloading Sway, check for errors:

```bash
# Reload sway configuration
swaymsg reload

# Check for config errors
swaymsg -t get_outputs  # Should show outputs without errors

# Or run from TTY to see startup errors
sway -c ~/.config/sway/config 2>&1 | grep -i error
```

## Remaining Warnings (Safe to Ignore)

These warnings appear but are harmless:

- "Overwriting binding" - This is normal behavior in Sway when last binding wins
- These occur because the same binding is defined in both `config` and `config.d/bindings`

All **errors** are fixed. Warnings about overwriting bindings are expected when the same key is bound twice (last one wins).

## Testing Recommendations

1. **Test critical keybindings**:
   - Terminal: `$mod+Return`
   - Browser: `$mod+Shift+b`
   - Exit: `$mod+Shift+e`
   - Reload: `$mod+Shift+c`

2. **Test mode switches**:
   - Resize mode: `$mod+r`
   - Gaps mode: `$mod+Shift+g`
   - Display mode: `$mod+Shift+p`

3. **Test applications**:
   - `$mod+Shift+Alt+c` for VSCode
   - `$mod+Shift+Alt+g` for Signal

## Notes

- All `omarchy-*` commands are commented out in main config but preserved in bindings
- These won't work on Fedora anyway - they're for reference/transitional purposes
- Replace with direct commands or Fedora equivalents
- Consider removing/commenting out all `omarchy-*` bindings before Fedora migration
