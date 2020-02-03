FROM gitpod/workspace-full-vnc:latest

USER gitpod

# Update apt repositories
RUN sudo apt-get update \
    && sudo apt-get upgrade -y \
    && sudo apt dist-upgrade -y \
    && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y shellcheck firefox tree xclip umbrello \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo apt autoremove -y

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	"xcopy() { xclip -se C ;}" \
	>> /etc/bash.bashrc; fi
