#!/bin/bash

### General Paradigm
# Install Rust (if needed)
# Install Bob
# Append Bob stuff to PATH in .bashrc
# Install and use latest nvim
# Install Packer

## Functions
function user_verify() {
    ans=""
    read -n 1 ans
    if [[ -z "$ans" || "$ans" == "Y" || "$ans" == "y" ]]; then
        return 1
    else
        return 0
    fi
}
## Setup
# Parse input args (if any)
quiet=0
bob_inst=1

if [[ $# == 1 ]]; then
    echo "one argument!"
elif [[ $# == 2 ]]; then
    echo "two arguments!"
else
    echo "no arguments?"
fi

## Installations
# Checking Rust Install status
echo "Testing Rust / Cargo..."
carbo -V
rust_ok=$?
if [[ $rust_ok -ne 0 ]]; then
    echo "Rust is not installed!"
    echo -n "Preparing to install Rust toolchain (rustup, rustdoc, cargo, etc.). Proceed? [Y/n]: "
    verif=$(user_verify)
    echo ""
    if [[ $verif ]]; then
        echo "Installing Rust!"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        echo "Verifying Installation"
        if [[ $? ]]; then
            echo "Rust installation failed."
            bob_inst=0
        fi
    fi
    # Test out rust installation
    cargo -V
    if [[ $? ]]; then
        echo "Rust installation failed!"
        bob_inst=0
    else
        echo "Rust installation Successful."
    fi
else
    echo "Rust Toolchain is already installed!"
fi

# Checking Bob Install status
if [[ $bob_inst ]]; then
    echo "Checking Bob installation..."
    bob --version
    bob_ok=$?
    if [[ $bob_ok -ne 0 ]]; then
        echo -n "Preparing to install Bob (neovim version control). Proceed? [Y/n]: "
        verif=$(user_verify)
        echo ""
        if [[ $verif ]]; then
            echo "Installing Bob!"
            cargo install bob-nvim
            if [[ $? ]] then
                # Failed Installation
                echo "Installation of Bob was unsuccessful!"
            else
                #
                # Successful installation
                echo "Installation of Bob Successful!"
            fi
        fi
    else
        echo "Bob is already installed!"
    fi

    # Setup latest nvim version
    bob install latest
    bob use latest



fi
