FROM debian:latest

# FIXME: Outputs `gitpod@ws-ce281d58-997b-44b8-9107-3f2da7feede3:/workspace/gitpod-tests1$` in terminal
# FIXME: Add hadolint executable


# To avoid bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
ARG DEBIAN_FRONTEND=noninteractive

# Customize PS1 to be more usable
ARG PS1="[ \t : \w : EXIT \$? ]\n\u@gitpod \\$ \[$(tput sgr0)\]"

USER root

ENV LANG=en_US.UTF-8
ENV LC_ALL=C

# Add 'gitpod' user
RUN useradd \
	--uid 33333 \
	--create-home --home-dir /home/gitpod \
	--shell /bin/bash \
	--password gitpod \
	gitpod || exit 1

# Install dependencies
RUN apt update \
  && apt upgrade -y \
  && apt dist-upgrade -y \
  && apt install -y rustc cargo \
  && : "Install hadolint if not available in downstream" \
  && if ! apt-cache search hadolint | grep -qP "^hadolint -.*"; then { if ! command -v wget >/dev/null; then apt install -y wget; fi ;} && wget https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 -O /usr/bin/hadolint && { [ ! -x /usr/bin/hadolint ] && chmod +x /usr/bin/hadolint ;}; elif apt-cache search hadolint | grep -qP "^hadolint -.*"; then apt install -y hadolint; fi \
  && apt autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	>> /etc/bash.bashrc; fi
