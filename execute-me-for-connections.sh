#!/bin/bash

echo "
+-----------------------------------+
|   $(tput bold)Available Commands$(tput sgr0)   |
+-----------------------------------+

$(tput bold)1. network_turbo$(tput sgr0)
   Description: Speeds up downloads from GitHub and HuggingFace
   Usage: source /etc/network_turbo

$(tput bold)2. proxychains4$(tput sgr0)
   Description: Changes proxy configuration to a specific command.
   You can see proxy configuration at: nano /etc/proxychains4.conf
   Usage: proxychains4 <rest of command>

$(tput bold)3. command3$(tput sgr0)
   Description:
   Usage: 

$(tput bold)4. command4$(tput sgr0)
   Description: 
   Usage: 
   "

# Function to display the menu
display_menu() {
    echo "Select a connection preset:"
    echo "1. Setup and Proxys for Fast downloading speeds to GitHub and Huggingface"
    echo "2. Setup and Proxy changes for Unrestricted Internet Access"
    echo "3. Disable current Setup configuration"
}

# Function to execute commands based on user choice
execute_option() {
    case $1 in
        1)
            echo "Executing commands for Fast downloading speeds to GitHub and Huggingface..."
            # Commands
            source /etc/network_turbo > /dev/null
            echo "Current connection preset: 1" 
            echo "If downloads speeds lower, feel free to re-execute"
            ;;
        2)
            echo "Executing commands for Option 2..."
            # Commands

            echo "Current connection preset: 2"
            ;;
        3)
            echo "Executing commands for Option 3..."
            # Commands

            echo "Current connection preset: 3 (Virgin)"
            ;;
        *)
            echo "Funy man... Invalid option."
            exit 1
            ;;
    }
}

# Main menu logic 

display_menu

read -p "Enter your choice (1-3): " choice

case $choice in
    1|2|3)
        execute_option $choice
        echo "Preset selected successfully."
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

echo "Changes completed."
exit 0