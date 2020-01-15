FROM gitpod/workspace-full

USER root

# Update apt repositories
RUN apt-get update

# Upgrade the image
RUN apt upgrade -y
RUN apt dist-upgrade -y

# Install linting dependencies
RUN apt install -y shellcheck

# Remove apt sources to clean up space
RUN rm -rf /var/lib/apt/lists/*

# Clean-up unneeded packages
RUN apt autoremove -y
