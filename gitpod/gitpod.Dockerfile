FROM gitpod/workspace-full-vnc:latest

USER gitpod

ARG DEBIAN_FRONTEND=noninteractive

# Update apt repositories
RUN apt-get update \
    && apt-get upgrade -y \
    && apt dist-upgrade -y \
    && apt-get install -y shellcheck firefox tree xclip umbrello \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove -y

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	"xcopy() { xclip -se C ;}" \
	>> /etc/bash.bashrc; fi
