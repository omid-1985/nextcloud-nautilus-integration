#!/bin/bash

# Installer for "Nextcloud Integration" Nautilus Script
# Coded by: Omid Khalili inspired by initial work of Philipp Fruck (https://gist.github.com/p-fruck/6ec354da8fb348c19cca013c6c64df76)
# License: GNU General Public License (GPL) version 3+
# Description: Implement Nextcloud Nautilus Integration for Nextcloud Flatpak package
# Requires: bash, nautilus, nautilus-python, nextcloud-desktop-client via flatpak 

# Exit on any error
set -e

# Step 1: Download syncstate.py
echo "📥 Downloading syncstate.py..."
curl -L -o syncstate.py https://raw.githubusercontent.com/nextcloud/desktop/master/shell_integration/nautilus/syncstate.py

# Step 2: Create the extensions directory
echo "📂 Creating extensions directory..."
mkdir -p ~/.local/share/nautilus-python/extensions/

# Step 3: Move syncstate.py to the extensions directory
echo "🚚 Moving syncstate.py to extensions directory..."
mv syncstate.py ~/.local/share/nautilus-python/extensions/

# Step 4: Download master.tar.gz
echo "📦 Downloading Nextcloud source (master.tar.gz)..."
curl -L -o master.tar.gz https://github.com/nextcloud/desktop/archive/refs/heads/master.tar.gz

# Step 5: Extract the archive
echo "📤 Extracting master.tar.gz..."
tar -xzvf master.tar.gz

# Step 6: Copy icons to appropriate directories
echo "🎨 Installing icons..."
for size in 128x128 16x16 256x256 32x32 48x48 64x64 72x72
do
  target=~/.local/share/icons/hicolor/${size}/apps
  mkdir -p "${target}"
  for icon in desktop-master/shell_integration/icons/${size}/*
  do
    basename=$(basename "${icon}")
    cp "${icon}" "${target}/${basename/oC/Nextcloud}"
  done
done

# Step 7: Cleanup
echo "🧹 Cleaning up temporary files..."
rm -r desktop-master master.tar.gz

# Step 8: Restart Nautilus
echo "🔄 Restarting Nautilus..."
pkill -9 nautilus

echo "✅ Done! Nautilus integration for Nextcloud is now installed!"

