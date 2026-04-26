#!/bin/bash
# Install Hugo for macOS ARM64
set -e

HUGO_VERSION="0.160.1"
HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_darwin-arm64.tar.gz"

echo "Downloading Hugo v${HUGO_VERSION}..."
curl -L "$HUGO_URL" -o /tmp/hugo.tar.gz

echo "Extracting Hugo..."
tar -xzf /tmp/hugo.tar.gz -C /tmp

echo "Installing Hugo to /usr/local/bin..."
sudo mv /tmp/hugo /usr/local/bin/
sudo chmod +x /usr/local/bin/hugo

echo "Verifying installation..."
hugo version

echo "Hugo installed successfully!"
