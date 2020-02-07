FROM gitpod/workspace-full-vnc:latest

# To avoid bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
ARG DEBIAN_FRONTEND=noninteractive

# APT management (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get)
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
    && apt-get update \
    && apt-get upgrade -y \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && apt dist-upgrade -y \
    && apt-get install -y shellcheck docker-ce docker-ce-cli containerd.io firefox tree xclip umbrello \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove -y

# Add docker
RUN 

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	"xcopy() { xclip -se C ;}" \
	>> /etc/bash.bashrc; fi
