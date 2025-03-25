#!/bin/bash

# Set strict error handling
set -e
set -o pipefail

# Color codes for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the current hostname
HOSTNAME=$(hostname)

# Logging function
log() {
    echo -e "${GREEN}🐳 $1${NC}"
}

# Error handling function
error() {
    echo -e "${RED}❌ ERROR: $1${NC}"
    exit 1
}

# Warning function
warn() {
    echo -e "${YELLOW}⚠️ WARNING: $1${NC}"
}

log "Setting up Docker environment for macOS on $HOSTNAME..."

# Determine the appropriate shell configuration file
if [[ "$SHELL" == */zsh* ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [[ "$SHELL" == */bash* ]]; then
    SHELL_CONFIG="$HOME/.bash_profile"
else
    error "Unsupported shell. Please use bash or zsh."
fi

# Ensure the shell configuration file exists
touch "$SHELL_CONFIG"

# Backup existing configuration
cp "$SHELL_CONFIG" "$SHELL_CONFIG.bak"

# Check for Homebrew installation
if ! command -v brew &> /dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || \
        error "Failed to install Homebrew"
else
    log "Homebrew is already installed"
fi

# Update Homebrew
log "Updating Homebrew..."
brew update || warn "Homebrew update failed"

# Install Docker tools
log "Installing Docker CLI tools..."
brew install docker docker-compose docker-credential-helper colima || \
    error "Failed to install Docker tools"

# Check and stop Docker Desktop if running
if pgrep -x "Docker" > /dev/null; then
    warn "Docker Desktop is running. This may conflict with Colima."
    warn "Please quit Docker Desktop before proceeding."
fi

# Configure Docker environment in shell config
{
    echo ''
    echo '# Docker PATH and environment setup'
    echo 'export PATH="/opt/homebrew/bin:$PATH"'
    echo 'export DOCKER_HOST=unix:///Users/'"$USER"'/.colima/default/docker.sock'
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
} >> "$SHELL_CONFIG"

# Source the updated profile
source "$SHELL_CONFIG"

# Start Colima
log "Starting Colima..."
colima stop 2>/dev/null || true
colima start --runtime docker || error "Failed to start Colima"

# Wait for Docker to be ready
log "Waiting for Docker to be ready..."
max_attempts=10
attempt=0
while [ $attempt -lt $max_attempts ]; do
    if docker info >/dev/null 2>&1; then
        log "Docker is running successfully!"
        break
    fi
    
    ((attempt++))
    sleep 3
done

if [ $attempt -eq $max_attempts ]; then
    error "Docker failed to start after $max_attempts attempts"
fi

# Verify Docker installation
log "Docker Verification:"
docker --version
docker-compose --version
echo "Docker socket path: $DOCKER_HOST"

# Verify socket file
DOCKER_SOCKET_PATH="/Users/$USER/.colima/default/docker.sock"
if [ -S "$DOCKER_SOCKET_PATH" ]; then
    log "✅ Docker socket file exists at $DOCKER_SOCKET_PATH"
else
    error "Docker socket file not found at $DOCKER_SOCKET_PATH"
fi

# Final message
log "Docker setup complete on $HOSTNAME! 🐳🚀"

# Recommendation for user
echo ""
echo "🔔 Recommendations:"
echo "- Restart your terminal to ensure all environment variables are loaded"
echo "- If you encounter issues, try running 'colima stop' and 'colima start'"
