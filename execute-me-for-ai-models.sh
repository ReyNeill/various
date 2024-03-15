#!/bin/bash
# Display menu options
display_menu() {
    clear
    echo "################################################################"
    echo "Welcome to ClustAI"
    echo "################################################################"
    echo "Please select an AI model to install:"
    echo "1. Stable Diffusion Webui (Automatic1111)"
    echo "2. Model B"
    echo "3. Model C"
    echo "4. Exit"
}

# Install selected AI model
install_model() {
    case $1 in
        1)
            echo "################################################################"
            echo "Installing Stable Diffusion Webui (Automatic1111)..."
            echo "################################################################"
            # Installation commands 
            apt update && apt upgrade 
            echo "################################################################"
            echo "Installing python..."
            echo "################################################################"
            apt install wget git python3 python3-venv libgl1 libglib2.0-0
            echo "################################################################"
            echo "Creating directory..."
            echo "################################################################"
            mkdir -p stable-diffusion-webui
            cd stable-diffusion-webui
            wget -q https://raw.githubusercontent.com/ReyNeill/stable-diffusion-webui/master/webui.sh
            chmod +x webui.sh
            echo "################################################################"
            echo "Dowloading and running model..."
            echo "################################################################"
            ./webui.sh --api --xformers
            echo "################################################################"
            echo "This is an installation script, to Run the AI model again, go to it's directory and run ./webui.sh --api --xformers"
            echo "################################################################"
            ;;
        2)
            echo "Installing Model B..."
            # Installation commands for Model B here
            ;;
        3)
            echo "Installing Model C..."
            # Installation commands for Model C here
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
}

# Prompt user to install Cloudflare Quick Tunnel
install_tunnel() {
    echo "################################################################"
    read -p "Do you want to install Cloudflare Quick Tunnel in order to access the model's UI on your own browser? (y/n): " choice
    echo "################################################################"
    case $choice in
        [Yy]*)
            echo "################################################################"
            echo "Installing Cloudflare Quick Tunnel..."
            echo "################################################################"
            # Installation commands for Cloudflare Quick Tunnel
            mkdir -p --mode=0755 /usr/share/keyrings
            curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
            echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list
            apt-get update && apt-get install cloudflared
            echo "################################################################"
            echo "Cloudflared Service installed"
            echo "################################################################"
            echo "Run Cloudflared Quick Tunnel with the command: cloudflared tunnel --url {URL Provided by the local server {e.g http://127.0.0.1:8000}}"
            echo "################################################################"
            ;;
        [Nn]*)
            echo "Skipping Cloudflare Quick Tunnel installation."
            ;;
        *)
            echo "Invalid choice, skipping Cloudflare Quick Tunnel installation."
            ;;
    esac
}

# Main script
while true; do
    display_menu
    read -p "Enter your choice (1-4): " option
    case $option in
        1|2|3)
            install_model $option
            install_tunnel
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
    read -p "Press Control+C to exit..."
done
