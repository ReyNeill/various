#!/bin/bash

echo "
+-----------------------------------+
|   $(tput setaf 2)Available Commands$(tput sgr0)   |
+-----------------------------------+

$(tput setaf 2)1. network_turbo$(tput sgr0)
   Description: Speeds up downloads from GitHub and HuggingFace
   Usage: source /etc/network_turbo

$(tput setaf 2)2. proxychains4$(tput sgr0)
   Description: Changes proxy configuration to a specific command.
   You can see proxy configuration at: nano /etc/proxychains4.conf
   Usage: proxychains4 <rest of command>
"

# Function to display the menu
display_menu() {
    echo "Select a connection preset:"
    echo ""
    echo "1. Setup and Proxys for Accelerated Downloads to GitHub and Huggingface"
    echo "2. Setup and Proxy changes for Unrestricted Internet Access"
    echo "3. Disable Current Setup Configuration"
}

# Function to execute commands based on user choice
execute_option() {
    case $1 in
        1)
            echo "Accelerating Downloads to GitHub and Huggingface..."
            source /etc/network_turbo &> /dev/null
            echo "Increased download speeds towards:
            - github.com
            - githubusercontent.com
            - githubassets.com
            - huggingface.co"
            echo "Current connection preset: 1"
            echo "If downloads speeds decrease, feel free to re-execute"
            echo "+---------------------------+"
            ;;
        2)
            echo "Unrestricting Internet Access..."
            apt-get install autossh proxychains4 -y &> /dev/null
            autossh -M 0 -f -N -L 8443:localhost:8443 containers@szhk.rentan.ai &> /dev/null
            echo "" >> /root/autodl-tmp/.bashrc
            echo "export HTTP_PROXY=localhost:8443" >> /root/autodl-tmp/.bashrc
            echo "export HTTPS_PROXY=localhost:8443" >> /root/autodl-tmp/.bashrc
            echo "alias npm='proxychains4 npm'" >> /root/autodl-tmp/.bashrc
            echo "alias python='proxychains4 python'" >> /root/autodl-tmp/.bashrc
            echo "alias python3='proxychains4 python3'" >> /root/autodl-tmp/.bashrc
            echo "alias yarn='proxychains4 yarn'" >> /root/autodl-tmp/.bashrc
            echo "alias wget='proxychains4 wget'" >> /root/autodl-tmp/.bashrc
            echo "For unrestricted command use, type: proxychains4 <rest of your command>"
            echo "Current connection preset: 2"
            echo "+---------------------------+"
            ;;
        3)
            echo "Disabling Current Setup Configuration..."
            echo "Current connection preset: 3 (Virgin)"
            echo "+---------------------------+"
            ;;
        *)
            echo "Invalid option."
            echo "+---------------------------+"
            exit 1
            ;;
    esac
}

# Main menu logic 

display_menu

read -p "Enter your choice (1-3): " choice
echo ""

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

echo -e "\e[32mChanges completed.\e[0m"
echo "+---------------------------+"
exit 0