#!/bin/bash

# Get the program to install from arguments
program=$1

# Check if the program name was provided
if [ -z "$program" ]; then
    echo "Error: No program specified"
    exit 1
fi

# Check if command already exists
if command -v "$program" &> /dev/null; then
    echo "$program is already installed"
    exit 0
fi

# Detect environment and install accordingly
if [[ $(uname) == "Darwin" ]]; then
    # macOS environment
    echo "Detected macOS environment"

    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Please install Homebrew first."
        echo "Run: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi

    # Install the program using Homebrew
    echo "Installing $program via Homebrew..."
    brew install "$program"

elif [[ -d "/data/data/com.termux" ]]; then
    # Termux environment
    echo "Detected Termux environment"

    # Package name mapping for Termux
    declare -A pkg_map
    pkg_map["ripgrep"]="ripgrep"
    pkg_map["fzf"]="fzf"
    pkg_map["git"]="git"
    pkg_map["openssh"]="openssh"

    # Get package name for Termux
    pkg=${pkg_map[$program]:-$program}

    # Install the program using pkg
    echo "Installing $pkg via pkg..."
    pkg install -y "$pkg"

    # Add openssh if needed
    if [[ "$program" == "git" ]]; then
        echo "Installing openssh for git functionality..."
        pkg install -y openssh
    fi

elif [[ -f "/proc/version" ]] && grep -q "Microsoft\|WSL" /proc/version; then
    # Windows WSL environment
    echo "Detected Windows WSL environment"

    # Package name mapping for apt
    declare -A pkg_map
    pkg_map["ripgrep"]="ripgrep"
    pkg_map["fzf"]="fzf"
    pkg_map["git"]="git"

    # Get package name for apt
    pkg=${pkg_map[$program]:-$program}

    # Update package list
    echo "Updating package lists..."
    sudo apt update

    # Install the program using apt
    echo "Installing $pkg via apt..."
    sudo apt install -y "$pkg"

else
    echo "Unsupported environment. Please install $program manually."
    exit 1
fi

# Check if installation was successful
if command -v "$program" &> /dev/null; then
    echo "$program installed successfully"
    exit 0
else
    echo "Failed to install $program"
    exit 1
fi
