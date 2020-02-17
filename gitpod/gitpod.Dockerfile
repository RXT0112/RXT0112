FROM gitpod/workspace-full-vnc:latest

# To avoid bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
ARG DEBIAN_FRONTEND=noninteractive

# APT management (https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#apt-get)
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" \
    && apt-get update \
    && apt-get upgrade -y \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && apt dist-upgrade -y \
    && apt-get install -y clang valgrind shellcheck docker-ce docker-ce-cli containerd.io firefox tree xclip umbrello gnuplot fish zsh \
    && sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    && curl -L https://get.oh-my.fish | fish
    && git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove -y

### VLANG ###
USER root
ENV VLANG_VERSION="0.1.24"
COPY gitpod/vlang_init4.sh /usr/bin/vlang_init
RUN chmod +x /usr/bin/vlang_init
RUN vlang_init || exit 1

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	"xcopy() { xclip -se C ;}" \
	>> /etc/bash.bashrc; fi