#!/bin/bash

 

# macOS Docker Setup Script

# This script installs and configures Docker environment on macOS using Homebrew

 

echo "🐳 Setting up Docker environment for macOS..."

 

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

echo "🔍 Verifying Docker installation..."

if docker ps &> /dev/null; then

    echo "✅ Docker is successfully installed and running!"

    echo "🐳 Current Docker version: $(docker --version)"

    echo "🧩 Current Docker Compose version: $(docker-compose --version)"

else

    echo "❌ There was an issue with Docker setup. Please check the error messages above."

fi

 

echo "🔆 Setup complete! You can now use Docker on your Mac."
