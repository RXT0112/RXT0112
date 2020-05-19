FROM gitpod/workspace-full-vnc:latest

# Blocked by https://github.com/gitpod-io/gitpod/issues/39
COPY gitpod/scripts/root-access.sh /usr/bin/root-access
RUN true "7a8fhs1g" \
	&& chmod +x /usr/bin/root-access \
	&& /usr/bin/root-access \
	&& rm /usr/bin/root-access

# Blocked by https://github.com/gitpod-io/gitpod/issues/1265
COPY gitpod/scripts/vm-support.sh /usr/bin/vm-support
RUN true "dg798sda7h" \
	&& chmod +x /usr/bin/vm-support \
	&& /usr/bin/vm-support \
	&& rm /usr/bin/vm-support

# FIXME: Add hadolint executable

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
    && : "Install hadolint if not available in downstream" \
    && if ! apt-cache search hadolint | grep -qP "^hadolint -.*"; then { if command -v wget >/dev/null; then apt install -y wget; fi ;} && wget https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 -O /usr/bin/hadolint && { [ ! -x hadolint ] && chmod +x /usr/bin/hadolint ;}; elif apt-cache search hadolint | grep -qP "^hadolint -.*"; then apt install -y hadolint; fi \
    && apt-get install -y clang valgrind shellcheck docker-ce docker-ce-cli containerd.io firefox tree xclip umbrello gnuplot fish zsh dia \
    && rm -rf /var/lib/apt/lists/* \
    && apt autoremove -y

## User config
# USER gitpod
# RUN curl -L https://get.oh-my.fish | fish \
#   && sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
#   && git clone --depth=1 https://github.com/Bash-it/bash-it.git /usr/src/bash-it \
#   && /usr/src/bash-it/install.sh

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