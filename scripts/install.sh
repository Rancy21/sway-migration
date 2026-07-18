#!/bin/bash
# Install helper scripts to ~/.local/bin/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$HOME/.local/bin"

echo "Installing helper scripts to $DEST_DIR..."

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy all scripts
for script in "$SCRIPT_DIR"/launch-*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        cp "$script" "$DEST_DIR/"
        chmod +x "$DEST_DIR/$script_name"
        echo "✓ Installed $script_name"
    fi
done

echo ""
echo "All scripts installed to $DEST_DIR"
echo ""
echo "Installed scripts:"
ls -1 "$DEST_DIR"/launch-*

echo ""
echo "Make sure $DEST_DIR is in your PATH:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "Add to your shell config (~/.bashrc or ~/.zshrc):"
echo "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
