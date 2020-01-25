FROM gitpod/workspace-full-vnc:latest

USER root

# Update apt repositories
RUN apt-get update

# Upgrade the image
RUN apt upgrade -y
RUN apt dist-upgrade -y

# Install linting dependencies
RUN apt install -y shellcheck firefox tree

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io ;}" \
	"xcopy() { xcopy="xclip -se C" ;}" \
	>> /etc/bash.bashrc; fi

# Remove apt sources to clean up space
RUN rm -rf /var/lib/apt/lists/*

# Clean-up unneeded packages
RUN apt autoremove -y
