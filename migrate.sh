#!/bin/bash
# Migration Test Script
# Helps you test and deploy your Sway configuration

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Project directory
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Omarchy (Hyprland) → Sway Migration Tool            ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to check command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="${2:-n}"

    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -r -p "$prompt" response
    response=${response:-$default}

    [[ "$response" =~ ^[Yy]$ ]]
}

# Check if running in Sway or Hyprland
detect_current_wm() {
    if [ -n "$SWAYSOCK" ]; then
        echo "Sway"
    elif [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
        echo "Hyprland"
    else
        echo "Unknown"
    fi
}

CURRENT_WM=$(detect_current_wm)
echo -e "${BLUE}Current Window Manager:${NC} $CURRENT_WM"
echo ""

# Menu
show_menu() {
    echo -e "${GREEN}1.${NC} Check prerequisites (required packages)"
    echo -e "${GREEN}2.${NC} Test Sway configuration (dry run)"
    echo -e "${GREEN}3.${NC} Show current monitor configuration"
    echo -e "${GREEN}4.${NC} Show current input devices"
    echo -e "${GREEN}5.${NC} Install configuration to ~/.config/sway"
    echo -e "${GREEN}6.${NC} Install Waybar configuration"
    echo -e "${GREEN}7.${NC} Backup existing configs"
    echo -e "${GREEN}8.${NC} Full deployment (install all configs)"
    echo -e "${GREEN}9.${NC} Quit"
    echo ""
}

# Check prerequisites
check_prerequisites() {
    echo -e "${BLUE}Checking prerequisites...${NC}"
    echo ""

    local missing=()

    # Essential packages
    local packages=("sway" "swaylock" "swayidle" "waybar" "grim" "slurp" "wl-clipboard")

    for pkg in "${packages[@]}"; do
        if command_exists "$pkg"; then
            echo -e "${GREEN}✓${NC} $pkg installed"
        else
            echo -e "${RED}✗${NC} $pkg NOT installed"
            missing+=("$pkg")
        fi
    done

    # Optional packages
    echo ""
    echo -e "${BLUE}Optional packages:${NC}"
    local opt_packages=("mako" "bemenu" "wofi" "brightnessctl" "pamixer" "playerctl" "cliphist")

    for pkg in "${opt_packages[@]}"; do
        if command_exists "$pkg"; then
            echo -e "${GREEN}✓${NC} $pkg installed"
        else
            echo -e "${YELLOW}○${NC} $pkg NOT installed (optional)"
        fi
    done

    if [ ${#missing[@]} -ne 0 ]; then
        echo ""
        echo -e "${YELLOW}Missing essential packages. Install with:${NC}"
        echo -e "  sudo pacman -S ${missing[*]}"
    else
        echo ""
        echo -e "${GREEN}All essential packages are installed!${NC}"
    fi
}

# Test configuration
test_config() {
    echo -e "${BLUE}Testing Sway configuration...${NC}"
    echo ""

    if [ ! -f "$PROJECT_DIR/config" ]; then
        echo -e "${RED}Error: config file not found in $PROJECT_DIR${NC}"
        return 1
    fi

    echo -e "${YELLOW}Starting Sway with test configuration...${NC}"
    echo -e "${YELLOW}Press \$mod+Shift+e to exit${NC}"
    echo ""

    if [ "$CURRENT_WM" == "Hyprland" ]; then
        echo -e "${YELLOW}Warning: You're running Hyprland. It's recommended to test from a TTY.${NC}"
        echo -e "${YELLOW}Press Ctrl+Alt+F3 to switch to TTY, then run this script again.${NC}"
        echo ""

        if ! prompt_yes_no "Continue anyway?" "n"; then
            return 0
        fi
    fi

    sway -c "$PROJECT_DIR/config"
}

# Show monitor config
show_monitors() {
    echo -e "${BLUE}Current monitor configuration:${NC}"
    echo ""

    if command_exists "swaymsg"; then
        swaymsg -t get_outputs | jq -r '.[] | "Output: \(.name)\n  Mode: \(.current_mode.width)x\(.current_mode.height)@\(.current_mode.refresh)Hz\n  Scale: \(.scale)\n  Position: \(.rect.x), \(.rect.y)\n"'
    elif command_exists "hyprctl"; then
        hyprctl monitors | grep -E "(Monitor|Modeline)"
    else
        echo -e "${RED}Neither swaymsg nor hyprctl available${NC}"
    fi
}

# Show input devices
show_inputs() {
    echo -e "${BLUE}Current input devices:${NC}"
    echo ""

    if command_exists "swaymsg"; then
        swaymsg -t get_inputs | jq -r '.[] | "Device: \(.name)\n  Type: \(.type)\n  Identifier: \(.identifier)\n"'
    elif command_exists "hyprctl"; then
        hyprctl devices | grep -A 3 -E "(Keyboard|Mouse|Touchpad)"
    else
        echo -e "${RED}Neither swaymsg nor hyprctl available${NC}"
    fi
}

# Install sway config
install_sway_config() {
    echo -e "${BLUE}Installing Sway configuration...${NC}"

    local sway_dir="$HOME/.config/sway"

    # Create backup if exists
    if [ -d "$sway_dir" ]; then
        echo -e "${YELLOW}Backing up existing config...${NC}"
        mv "$sway_dir" "$sway_dir.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create directory
    mkdir -p "$sway_dir"

    # Copy files
    cp "$PROJECT_DIR/config" "$sway_dir/"
    cp -r "$PROJECT_DIR/config.d" "$sway_dir/"

    echo -e "${GREEN}✓ Sway configuration installed to $sway_dir${NC}"
}

# Install waybar config
install_waybar_config() {
    echo -e "${BLUE}Installing Waybar configuration...${NC}"

    local waybar_dir="$HOME/.config/waybar"

    # Create backup if exists
    if [ -d "$waybar_dir" ]; then
        echo -e "${YELLOW}Backing up existing config...${NC}"
        mv "$waybar_dir" "$waybar_dir.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Create directory
    mkdir -p "$waybar_dir"

    # Copy files
    cp "$PROJECT_DIR/waybar/config.jsonc" "$waybar_dir/"
    cp "$PROJECT_DIR/waybar/style.css" "$waybar_dir/"

    echo -e "${GREEN}✓ Waybar configuration installed to $waybar_dir${NC}"
}

# Backup configs
backup_configs() {
    echo -e "${BLUE}Creating backups...${NC}"

    local backup_dir="$HOME/.config/backup.$(date +%Y%m%d_%H%M%S)"

    [ -d "$HOME/.config/sway" ] && cp -r "$HOME/.config/sway" "$backup_dir/sway"
    [ -d "$HOME/.config/waybar" ] && cp -r "$HOME/.config/waybar" "$backup_dir/waybar"
    [ -d "$HOME/.config/hypr" ] && cp -r "$HOME/.config/hypr" "$backup_dir/hypr"

    echo -e "${GREEN}✓ Backups created in $backup_dir${NC}"
}

# Full deployment
full_deployment() {
    echo -e "${BLUE}Starting full deployment...${NC}"
    echo ""

    if ! prompt_yes_no "This will install all configurations. Continue?" "n"; then
        echo -e "${YELLOW}Deployment cancelled.${NC}"
        return 0
    fi

    backup_configs
    install_sway_config
    install_waybar_config

    echo ""
    echo -e "${GREEN}═══════════════════════════════════════${NC}"
    echo -e "${GREEN}  Deployment Complete!                ${NC}"
    echo -e "${GREEN}═══════════════════════════════════════${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo -e "  1. Logout or switch to TTY (Ctrl+Alt+F1)"
    echo -e "  2. Select 'Sway' from display manager"
    echo -e "     OR run 'sway' from TTY"
    echo ""
    echo -e "${YELLOW}To test without leaving your current session:${NC}"
    echo -e "  sway -c ~/.config/sway/config"
    echo ""
}

# Main loop
while true; do
    show_menu
    read -r -p "Choose an option [1-9]: " choice

    case "$choice" in
        1) check_prerequisites ;;
        2) test_config ;;
        3) show_monitors ;;
        4) show_inputs ;;
        5) install_sway_config ;;
        6) install_waybar_config ;;
        7) backup_configs ;;
        8) full_deployment ;;
        9)
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac

    echo ""
    read -r -p "Press Enter to continue..."
    echo ""
done
