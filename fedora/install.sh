#!/bin/bash
# Fedora Post-Install Script
# Run this after installing Fedora to set up Sway and all tools

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Fedora Post-Install for Sway Migration              ║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if running on Fedora
if [ ! -f /etc/fedora-release ]; then
    echo -e "${RED}Error: This script is designed for Fedora Linux${NC}"
    echo -e "${YELLOW}You're running: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2)${NC}"
    exit 1
fi

# Get Fedora version
FEDORA_VERSION=$(rpm -E %fedora)
echo -e "${BLUE}Fedora Version:${NC} $FEDORA_VERSION"
echo ""

# Function to prompt yes/no
prompt_yes_no() {
    local prompt="$1"
    local default="${2:-y}"

    if [[ "$default" == "y" ]]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -r -p "$prompt" response
    response=${response:-$default}

    [[ "$response" =~ ^[Yy]$ ]]
}

# Update system
update_system() {
    echo -e "${BLUE}Updating system...${NC}"
    sudo dnf upgrade --refresh -y --skip-unavailable
    echo -e "${GREEN}✓ System updated${NC}"
}

# Enable RPM Fusion
enable_rpmfusion() {
    echo -e "${BLUE}Enabling RPM Fusion repositories...${NC}"

    # Free
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VERSION}.noarch.rpm

    # Non-free
    sudo dnf install -y \
        https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VERSION}.noarch.rpm

    # Update metadata
    sudo dnf group update core

    echo -e "${GREEN}✓ RPM Fusion enabled${NC}"
}

# Install multimedia codecs
install_codecs() {
    echo -e "${BLUE}Installing multimedia codecs...${NC}"

    sudo dnf group install -y "Multimedia" || echo -e "${YELLOW}Multimedia group already installed or unavailable${NC}"
    sudo dnf install -y --skip-unavailable \
        ffmpeg \
        ffmpeg-libs \
        gstreamer1-plugins-base \
        gstreamer1-plugins-good \
        gstreamer1-plugins-bad-free \
        gstreamer1-plugins-bad-freeworld \
        gstreamer1-plugins-ugly-free \
        gstreamer1-plugins-ugly-freeworld \
        libavcodec-freeworld || echo -e "${YELLOW}Some codecs already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Codecs installed${NC}"
}

# Install Sway and Wayland tools
install_sway() {
    echo -e "${BLUE}Installing Sway and Wayland tools...${NC}"

    sudo dnf install -y --skip-unavailable \
        sway \
        swaylock \
        swayidle \
        waybar \
        wl-clipboard \
        grim \
        slurp \
        mako \
        wofi \
        bemenu || echo -e "${YELLOW}Some packages already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Sway installed${NC}"
}

# Install terminals
install_terminals() {
    echo -e "${BLUE}Installing terminals...${NC}"

    sudo dnf install -y --skip-unavailable alacritty foot kitty || echo -e "${YELLOW}Some terminals already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Terminals installed${NC}"
}

# Install essential utilities
install_utilities() {
    echo -e "${BLUE}Installing essential utilities...${NC}"

    sudo dnf install -y --skip-unavailable \
        btop \
        htop \
        curl \
        wget \
        git \
        tmux \
        fzf \
        ripgrep \
        fd-find \
        bat \
        eza \
        neofetch \
        fastfetch \
        lm_sensors \
        lxpolkit \
        brightnessctl \
        pamixer \
        playerctl \
        pavucontrol || echo -e "${YELLOW}Some utilities already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Utilities installed${NC}"
}

# Install fonts
install_fonts() {
    echo -e "${BLUE}Installing fonts...${NC}"

    sudo dnf install -y \
        jetbrains-mono-fonts-all \
        fira-code-fonts \
        adobe-source-code-pro-fonts \
        google-roboto-fonts \
        adwaita-cursor-theme || echo -e "${YELLOW}Some fonts already installed or unavailable${NC}"

    echo -e "${YELLOW}Note: Install Nerd Fonts manually from https://www.nerdfonts.com/${NC}"
    echo -e "${GREEN}✓ Fonts installed${NC}"
}

# Install development tools
install_dev_tools() {
    echo -e "${BLUE}Installing development tools...${NC}"

    sudo dnf install -y --skip-unavailable \
        neovim \
        vim-enhanced \
        python3 \
        python3-pip \
        nodejs \
        npm \
        go \
        rustcargo \
        clang \
        java-17-openjdk \
        git \
        lazygit || echo -e "${YELLOW}Some development tools already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Development tools installed${NC}"
}

# Install browsers
install_browsers() {
    echo -e "${BLUE}Installing browsers...${NC}"

    sudo dnf install -y --skip-unavailable firefox chromium || echo -e "${YELLOW}Some browsers already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Browsers installed${NC}"
}

# Install file managers
install_file_managers() {
    echo -e "${BLUE}Installing file managers...${NC}"

    sudo dnf install -y --skip-unavailable nautilus thunar file-roller gvfs || echo -e "${YELLOW}Some file managers already installed or unavailable${NC}"

    echo -e "${GREEN}✓ File managers installed${NC}"
}

# Enable Flathub
enable_flathub() {
    echo -e "${BLUE}Enabling Flathub...${NC}"

    sudo dnf install -y flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    echo -e "${GREEN}✓ Flathub enabled${NC}"
    echo -e "${YELLOW}Useful Flatpak apps:${NC}"
    echo -e "  flatpak install flathub com.spotify.Client"
    echo -e "  flatpak install flathub org.signal.Signal"
    echo -e "  flatpak install flathub md.obsidian.Obsidian"
    echo -e "  flatpak install flathub com.github.tchx84.Flatseal"
}

# Install Flatpak apps
install_flatpaks() {
    echo -e "${BLUE}Installing common Flatpak apps...${NC}"

    local apps=(
        "com.spotify.Client"
        "org.signal.Signal"
        "md.obsidian.Obsidian"
        "com.github.tchx84.Flatseal"
        "org.gtk.Gtk3theme.adw-gtk3"
        "org.gtk.Gtk3theme.adw-gtk3-dark"
    )

    for app in "${apps[@]}"; do
        echo -e "${YELLOW}Installing $app...${NC}"
        flatpak install -y flathub "$app"
    done

    echo -e "${GREEN}✓ Flatpak apps installed${NC}"
}

# Install Sway configs
install_configs() {
    echo -e "${BLUE}Installing Sway and Waybar configurations...${NC}"

    # Sway
    mkdir -p ~/.config/sway
    cp -r "$PROJECT_DIR/config" ~/.config/sway/
    cp -r "$PROJECT_DIR/config.d" ~/.config/sway/

    # Waybar
    mkdir -p ~/.config/waybar
    cp -r "$PROJECT_DIR/waybar/config.jsonc" ~/.config/waybar/
    cp -r "$PROJECT_DIR/waybar/style.css" ~/.config/waybar/

    echo -e "${GREEN}✓ Configurations installed${NC}"
}

# Install Catppuccin theme
install_theme() {
    echo -e "${BLUE}Installing Catppuccin theme...${NC}"

    # GTK theme
    flatpak install -y flathub org.gtk.Gtk3theme.catppuccin-mocha

    # Note: For full system theme, you'll need to install manually
    echo -e "${YELLOW}For complete theming, see:${NC}"
    echo -e "  https://github.com/catppuccin/catppuccin"

    echo -e "${GREEN}✓ Basic theme installed${NC}"
}

# Configure network and bluetooth
configure_network() {
    echo -e "${BLUE}Installing network tools...${NC}"

    sudo dnf install -y --skip-unavailable \
        network-manager-applet \
        NetworkManager-wifi \
        blueberry \
        lxpolkit || echo -e "${YELLOW}Some network tools already installed or unavailable${NC}"

    echo -e "${GREEN}✓ Network tools installed${NC}"
    echo -e "${YELLOW}Note: Using lxpolkit (lightweight polkit agent)${NC}"
}

# Configure power management (laptop)
configure_power() {
    echo -e "${BLUE}Configuring power management...${NC}"

    sudo dnf install -y powertop acpi

    # Optional: TLP (advanced power management)
    # sudo dnf install -y tlp
    # sudo systemctl enable tlp

    echo -e "${GREEN}✓ Power management configured${NC}"
}

# Show menu
show_menu() {
    echo ""
    echo -e "${GREEN}1.${NC} Update system"
    echo -e "${GREEN}2.${NC} Enable RPM Fusion"
    echo -e "${GREEN}3.${NC} Install Sway and Wayland tools"
    echo -e "${GREEN}4.${NC} Install terminals"
    echo -e "${GREEN}5.${NC} Install utilities"
    echo -e "${GREEN}6.${NC} Install fonts"
    echo -e "${GREEN}7.${NC} Install development tools"
    echo -e "${GREEN}8.${NC} Install browsers"
    echo -e "${GREEN}9.${NC} Install file managers"
    echo -e "${GREEN}10.${NC} Enable Flathub"
    echo -e "${GREEN}11.${NC} Install common Flatpak apps"
    echo -e "${GREEN}12.${NC} Install configurations"
    echo -e "${GREEN}13.${NC} Install theme"
    echo -e "${GREEN}14.${NC} Configure network/bluetooth"
    echo -e "${GREEN}15.${NC} Configure power management"
    echo -e "${GREEN}A.${NC} Full install (run all steps)"
    echo -e "${GREEN}Q.${NC} Quit"
    echo ""
}

# Main loop
while true; do
    show_menu
    read -r -p "Choose an option [1-15, A, Q]: " choice

    case "$choice" in
        1) update_system ;;
        2) enable_rpmfusion ;;
        3) install_sway ;;
        4) install_terminals ;;
        5) install_utilities ;;
        6) install_fonts ;;
        7) install_dev_tools ;;
        8) install_browsers ;;
        9) install_file_managers ;;
        10) enable_flathub ;;
        11) install_flatpaks ;;
        12) install_configs ;;
        13) install_theme ;;
        14) configure_network ;;
        15) configure_power ;;
        [Aa])
            echo -e "${BLUE}Running full installation...${NC}"
            update_system
            enable_rpmfusion
            install_codecs
            install_sway
            install_terminals
            install_utilities
            install_fonts
            install_dev_tools
            install_browsers
            install_file_managers
            enable_flathub
            install_configs
            install_theme
            configure_network
            configure_power

            echo ""
            echo -e "${GREEN}═══════════════════════════════════════${NC}"
            echo -e "${GREEN}  Full Installation Complete!         ${NC}"
            echo -e "${GREEN}═══════════════════════════════════════${NC}"
            echo ""
            echo -e "${BLUE}Next steps:${NC}"
            echo -e "  1. Edit ~/.config/sway/config.d/output for your monitors"
            echo -e "  2. Log out and select 'Sway' from login manager"
            echo -e "  3. Or run: sway"
            ;;
        [Qq])
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac

    echo ""
    read -r -p "Press Enter to continue..."
done
