#!/bin/bash

# Get the current hostname
HOSTNAME=$(hostname)

echo "🐳 Setting up Docker environment for macOS on $HOSTNAME..."

# Add Docker to PATH and shell configuration
echo "🔧 Configuring Docker environment variables..."
echo '' >> ~/.zprofile
echo '# Docker PATH and environment setup' >> ~/.zprofile
echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zprofile
echo 'export DOCKER_HOST=unix:///Users/'"$USER"'/.colima/default/docker.sock' >> ~/.zprofile

# Ensure Homebrew environment is sourced
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Source the updated profile
source ~/.zprofile

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew is already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install Docker CLI and related tools
echo "📦 Installing Docker CLI, Docker Compose, and credential helper..."
brew install docker docker-compose docker-credential-helper

# Install Colima
echo "📦 Installing Colima..."
brew install colima

# Start Colima
echo "🚀 Starting Colima..."
colima start

# Verify installation
echo "🔍 Verifying Docker installation on $HOSTNAME..."

# Check Docker installation
if command -v docker &> /dev/null; then
    if docker ps &> /dev/null; then
        echo "✅ Docker is successfully installed and running!"
        echo "🐳 Current Docker version: $(docker --version)"
        echo "🧩 Current Docker Compose version: $(docker-compose --version)"
        echo "💻 Hostname: $HOSTNAME"
    else
        echo "❌ Docker is installed but not running correctly."
    fi
else
    echo "❌ Docker command not found. Please check your installation."
    echo "Potential fixes:"
    echo "1. Restart your terminal"
    echo "2. Verify Homebrew installation"
    echo "3. Check PATH configuration"
fi

echo "🔆 Setup complete! You can now use Docker on $HOSTNAME."
