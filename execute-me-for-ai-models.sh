#!/bin/bash
# Pretty print
delimiter="################################################################"
# Display menu options
display_menu() {
    clear
    printf "\n%s\n" "${delimiter}"
    printf "\e[1m\e[32mWelcome to ClustAI\n"
    printf "\e[1m\e[34mPlease select an AI model to Install.\e[0m"
    printf "\n%s\n" "${delimiter}"
    echo "1. Stable Diffusion Webui (Automatic1111)"
    echo "2. Oobabooga Text Generation WebUI"
    echo "3. Model C"
    echo "4. Exit"
}

# Prompt user to install Cloudflare Quick Tunnel
install_tunnel() {
    printf "\n%s\n" "${delimiter}"
    read -p "Do you want to install Cloudflare Quick Tunnel in order to access the model's UI on your own browser? (y/n): " choice
    printf "\n%s\n" "${delimiter}"
    case $choice in
        [Yy]*)
            printf "\n%s\n" "${delimiter}"
            echo "Installing Cloudflare Quick Tunnel..."
            printf "\n%s\n" "${delimiter}"
            # Installation commands for Cloudflare Quick Tunnel
            mkdir -p --mode=0755 /usr/share/keyrings
            curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
            echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared jammy main' | tee /etc/apt/sources.list.d/cloudflared.list
            apt-get update && apt-get install cloudflared
            printf "\n%s\n" "${delimiter}"
            echo "Cloudflared Service installed"
            printf "\n%s\n" "${delimiter}"
            echo "Run Cloudflared Quick Tunnel on a new terminal session with the command: cloudflared tunnel --url {URL Provided by the local server {e.g http://127.0.0.1:8000}}"
            printf "\n%s\n" "${delimiter}"
            read -p "Press Enter to continue..."
            printf "\n%s\n" "${delimiter}"
            ;;
        [Nn]*)
            echo "Skipping Cloudflare Quick Tunnel installation."
            ;;
        *)
            echo "Invalid choice, skipping Cloudflare Quick Tunnel installation."
            ;;
    esac
}


# Install selected AI model
install_model() {
    case $1 in
        1)
            printf "\n%s\n" "${delimiter}"
            echo "Iniciating installation process of Stable Diffusion Webui (Automatic1111)..."
            printf "\n%s\n" "${delimiter}"
            # Installation commands 
            apt update && apt upgrade 
            printf "\n%s\n" "${delimiter}"
            echo "Installing python..."
            printf "\n%s\n" "${delimiter}"
            apt install wget git python3 python3-venv libgl1 libglib2.0-0
            printf "\n%s\n" "${delimiter}"
            echo "Creating directory..."
            printf "\n%s\n" "${delimiter}"
            mkdir -p stable-diffusion-webui
            cd stable-diffusion-webui
            wget -q https://raw.githubusercontent.com/ReyNeill/stable-diffusion-webui/master/webui.sh
            chmod +x webui.sh
            source /etc/network_turbo
            printf "\n%s\n" "${delimiter}"
            echo "Dowloading and running model..."
            printf "\n%s\n" "${delimiter}"
            ./webui.sh --api --xformers
            printf "\n%s\n" "${delimiter}"
            echo "This is an installation script, to Run the AI model again, go to it's directory and run ./webui.sh --api --xformers"
            printf "\n%s\n" "${delimiter}"
            ;;
        2)
            printf "\n%s\n" "${delimiter}"
            echo "Iniciating installation process of Oobabooga Text Generation WebUI..."
            printf "\n%s\n" "${delimiter}"
            read -p "Upgrade Nvidia Drivers if neccessary. Press Enter to Continue..."
            # Installation commands
            printf "\n%s\n" "${delimiter}"
            echo "Creating Conda environment 'textgen' and torch"
            printf "\n%s\n" "${delimiter}"
            conda create -n textgen python=3.11
            conda activate textgen
            pip3 install torch==2.2.1 torchvision==0.17.1 torchaudio==2.2.1 --index-url https://download.pytorch.org/whl/cu121
            conda install -y -c "nvidia/label/cuda-12.1.1" cuda-runtime
            source /etc/network_turbo
            printf "\n%s\n" "${delimiter}"
            echo "Cloning repo..."
            printf "\n%s\n" "${delimiter}"
            read -p "To learn how to download models, visit https://github.com/oobabooga/text-generation-webui"
            git clone https://github.com/oobabooga/text-generation-webui
            cd text-generation-webui
            printf "\n%s\n" "${delimiter}"
            echo "Installing requirements..."
            printf "\n%s\n" "${delimiter}"
            pip install -r requirements.txt
            echo "To restart the web UI in the future, just run the 'python server.py'"
            echo "Remember to use cloudflared tunnel --url <provided url> on a new terminal"
            read -p "In case you need to reinstall the requirements, you can simply delete that folder and start the web UI again. Press Enter to Continue..."
            cd text-generation-webui
            python server.py
            ;;
        3)
            echo "Installing Model C..."
            # Installation commands
            ;;
        *)
            echo "Invalid option, please try again."
            ;;
    esac
}

# Main script
while true; do
    display_menu
    read -p "Enter your choice (1-4): " option
    case $option in
        1|2|3)
            install_tunnel
            install_model $option
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
