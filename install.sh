#!/usr/bin/env bash
set -euo pipefail

# Run using "bash install.sh"

# Prompt for architecture
echo "Select architecture:"
echo "  1) arm"
echo "  2) x86"
read -rp "Enter choice [1-2]: " choice

case "$choice" in
    1) NVIM_DIR="nvim-linux-arm64" ;;
    2) NVIM_DIR="nvim-linux-x86_64" ;;
    *) echo "Invalid choice." >&2; exit 1 ;;
esac

TARBALL="${NVIM_DIR}.tar.gz"
URL="https://github.com/neovim/neovim/releases/latest/download/${TARBALL}"

# Download and install
echo "Downloading Neovim (${NVIM_DIR})..."
TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT
curl -L -o "${TMPDIR}/${TARBALL}" "$URL"

echo "Installing to /opt/${NVIM_DIR}..."
sudo rm -rf "/opt/${NVIM_DIR}"
sudo tar -C /opt -xzf "${TMPDIR}/${TARBALL}"

# Make nvim available in the current script for the Paq step
export PATH="$PATH:/opt/${NVIM_DIR}/bin"

# Install Paq plugin manager
PAQ_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/paqs/start/paq-nvim"
if [ -d "$PAQ_DIR" ]; then
    echo "Paq already installed at ${PAQ_DIR}."
else
    echo "Installing Paq..."
    git clone --depth=1 https://github.com/savq/paq-nvim.git "$PAQ_DIR"
fi

echo
echo "============================================================"
echo "Neovim installed to /opt/${NVIM_DIR}"
echo
echo "Add to zsh/bashrc: "
echo
echo "    export PATH=\"\$PATH:/opt/${NVIM_DIR}/bin\""
echo "============================================================"
