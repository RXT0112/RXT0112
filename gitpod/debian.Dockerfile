FROM debian:latest

# FIXME: Outputs `gitpod@ws-ce281d58-997b-44b8-9107-3f2da7feede3:/workspace/gitpod-tests1$` in terminal
# FIXME: Add hadolint executable
# FIXME: We can use /bin/sh instead of /bin/bash to get minor optimization

# To avoid bricked workspaces (https://github.com/gitpod-io/gitpod/issues/1171)
ARG DEBIAN_FRONTEND=noninteractive

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
RUN apt-get update \
  && apt-get install -y rustc cargo pkg-config \
  && : "Install hadolint if not available in downstream" \
  && if ! apt-cache search hadolint | grep -qP "^hadolint -.*"; then { if ! command -v wget >/dev/null; then apt-get install -y wget; fi ;} && wget https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 -O /usr/bin/hadolint && { [ ! -x /usr/bin/hadolint ] && chmod +x /usr/bin/hadolint ;}; elif apt-cache search hadolint | grep -qP "^hadolint -.*"; then apt-get install -y hadolint; fi \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

# Add custom functions
RUN if ! grep -qF 'ix()' /etc/bash.bashrc; then printf '%s\n' \
	'# Custom' \
	"ix() { curl -F 'f:1=<-' ix.io 2>/dev/null ;}" \
	>> /etc/bash.bashrc; fi

USER gitpod
