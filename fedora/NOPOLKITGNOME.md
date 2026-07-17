# Polkit Agents on Fedora

## The Issue

`polkit-gnome` is **not available** on Fedora anymore. You need an alternative polkit authentication agent for GUI applications that require elevated privileges.

## Available Options

| Package | Description | Notes |
|---------|-------------|-------|
| `lxpolkit` | LXDE PolicyKit Agent | ✅ **Recommended** - Lightweight, works well with Sway |
| `mate-polkit` | MATE Desktop PolicyKit | Good alternative |
| `xfce-polkit` | XFCE PolicyKit Agent | Good alternative |
| `polkit-kde-agent` | KDE PolicyKit Agent | Use if you have KDE apps |

## Installation

### Recommended: lxpolkit

```bash
sudo dnf install lxpolkit
```

### Add to Sway Autostart

Edit `~/.config/sway/config.d/autostart`:

```bash
# Polkit authentication agent
exec lxpolkit
```

### Testing

To test if the polkit agent works:

1. Start lxpolkit manually:
   ```bash
   lxpolkit &
   ```

2. Try running an application that needs authentication:
   ```bash
   # Example: Open a system utility that needs admin access
   nm-connection-editor  # Network manager
   # Or try installing software with GNOME Software
   ```

3. You should see a password dialog popup

## Troubleshooting

### No password dialog appears

If you don't see a password prompt when running GUI apps that need elevation:

```bash
# Check if lxpolkit is running
ps aux | grep lxpolkit

# If not running, start it manually
lxpolkit &

# Check logs
journalctl --user -f
```

### Multiple polkit agents conflict

If you have multiple polkit agents installed, only run one:

```bash
# Kill all running polkit agents
pkill lxpolkit
pkill polkit-mate
pkill xfce-polkit
pkill polkit-kde

# Start only lxpolkit
lxpolkit &
```

## What is Polkit?

Polkit (formerly PolicyKit) is a framework for defining system-wide policies for unprivileged processes to speak to privileged processes. In simpler terms:

- When you run a GUI app that needs admin privileges (like changing network settings, mounting drives, installing software)
- Polkit handles the "Please enter your password" dialog
- Without a polkit agent, these operations will silently fail or show errors

## Omarchy vs Fedora

| System | Polkit Agent | Package |
|--------|--------------|---------|
| Omarchy (Arch) | `polkit-gnome` | Pre-installed |
| Fedora | `lxpolkit` | Manual install |

## Why lxpolkit?

- **Lightweight**: Minimal dependencies, perfect for tiling WMs like Sway
- **Stable**: Well-maintained, part of LXDE desktop
- **Simple**: Just works, no complex configuration needed
- **Compatible**: Works with all Wayland compositors including Sway

## Alternative: No Polkit Agent

If you prefer not to run any polkit agent:

- You'll need to use `sudo` for everything in the terminal
- GUI apps requiring elevation won't work properly
- System management tools might fail

**Not recommended** for desktop usage.
