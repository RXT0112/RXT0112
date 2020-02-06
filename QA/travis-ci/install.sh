#!/usr/bin/env bash
# shellcheck disable=SC1117
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'install.sh' from rsplib (https://raw.githubusercontent.com/dreibh/rsplib/master/ci/install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

# shellcheck source=QA/travis-ci/travis-common.sh
. "$(dirname "$0")/travis-common.sh"

# shellcheck source=QA/travis-ci/get-container.sh
. "$(dirname "$0")/get-container.sh"

fixme "Travis - install.sh is disabling SC1117 as hotfix"

# QA: Why US mirror?
UBUNTU_MIRROR="us.archive.ubuntu.com"
RETRY_MAXTRIALS=5
RETRY_PAUSE=60

# Linux as-is
if [ "$TRAVIS_OS_NAME" = linux ] && [ -z "$DOCKER" ] && [ -z "$QEMU" ] && [ "$VARIANT" = ubuntu ]; then

	sudo apt update

	if [ "$(apt-cache search libfuse3-dev | grep -o "libfuse3-dev")" = "libfuse3-dev" ]; then

		# Fetch all dependencies
		sudo apt-get install meson uthash-dev libcap-dev cppcheck libattr1-dev clang libfuse3-dev gcc git ninja-build bison libtool autoconf pkg-config libcap-dev indent fakeroot uthash-dev gzip rsync autopoint uthash-dev shellcheck -y

	elif [ "$(apt-cache search libfuse3-dev | grep -o "libfuse3-dev")" = "libfuse3-dev" ]; then

        sudo apt-get install meson uthash-dev libcap-dev cppcheck clang gcc git libattr1-dev ninja-build bison libtool autoconf pkg-config libcap-dev indent fakeroot uthash-dev gzip rsync autopoint shellcheck -y

		# Travis is incompetent to provide usefull version of linux (https://travis-ci.community/t/more-virtual-environments/6213/7) so we have to fetch libfuse3-dev manually
        warn "Travis-CI's ubuntu still doesn NOT offer 'libfuse3-dev', using hack to fetch it manually"
		mkdir "$HOME/build/fuse3"
		fixme "Export latest fuse3 instead of hard-coded in ci/before-install.sh"
		wget https://github.com/libfuse/libfuse/releases/download/fuse-3.6.2/fuse-3.6.2.tar.xz -O "$HOME/build/fuse3/fuse-3.6.2.tar.xz"
		tar xpf "$HOME/build/fuse3/fuse-3.6.2.tar.xz" --directory="$HOME/build/fuse3/"
		mkdir "$HOME/build/fuse3/fuse-3.6.2/build"
		fixme "Avoid using cd in ci/before-install.sh"
		cd "$HOME/build/fuse3/fuse-3.6.2/build"|| die 
		meson .. --prefix /usr
		ninja
		sudo ninja install

	else
		die "Unexpected in install.sh configuring linux as-is"

	fi

	# Fetch shfmt (HACK!)
    if [ "$(apt-cache search shfmt | grep -o "shfmt")" = "shfmt" ]; then
        info "Installing shfmt"
        apt install -y shfmt

    elif [ "$(apt-cache search shfmt | grep -o "shfmt")" != "shfmt" ]; then
        warn "Package shfmt is not available, using hack to fetch it manually.."

        # Get shfmt
        if [ -e /usr/bin/shfmt ]; then
            warn "File /usr/bin/shfmt already exists! This is unexpected assuming that shfmt is already provided on linux as-is?"
        elif [ ! -e /usr/bin/shfmt ]; then
	        sudo wget https://github.com/mvdan/sh/releases/download/v3.0.0-beta1/shfmt_v3.0.0-beta1_linux_amd64 -O /usr/bin/shfmt
            [ ! -x /usr/bin/shfmt ] && sudo chmod +x /usr/bin/shfmt
        else
            die "Unexpected happend in /usr/bin/shfmt"
        fi
    else
        die "Unexpected happend in feteching shfmt in linux as-is"
    fi

# Linux via Docker
elif [ "$TRAVIS_OS_NAME" = linux ] && [ -n "$DOCKER" ] && [ -z "$QEMU" ]; then

	# Apt-based
	if [ "$VARIANT" = ubuntu ] || [ "$VARIANT" = debian ]; then
		# QA: Why are these variables? Looks like perfect scenario for a function..
		APT_UPDATE='env LANG=C.UTF-8 apt-get update -o Acquire::GzipIndexes=false'
		APT_INSTALL="env LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef --no-install-recommends"
		# APT_UPGRADE="env LANG=C.UTF-8 DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y -o Dpkg::Options::=--force-confold -o Dpkg::Options::=--force-confdef --no-install-recommends"
		# APT_ADD_REPOSITORY="env LANG=C.UTF-8 apt-add-repository -y"

		# Prepare container
		info "Preparing container ..."
		# Use uncompressed package lists. Necessary to work around
		# "apt-show-version" problems due to usage of compressed lists in
		# Docker containers:
		# https://askubuntu.com/questions/916199/install-apt-show-versions-inside-an-ubuntu-docker-container
		sudo docker exec "$CONTAINER" env LANG=C.UTF-8 sed -e "s#http://archive.ubuntu.com/ubuntu/#http://$UBUNTU_MIRROR/ubuntu/#g" -i /etc/apt/sources.list
		fixme "Do not use bash in install.sh"
		#sudo docker exec "$CONTAINER" bash -c "find /var/lib/apt/lists/ -maxdepth 1 -type f | xargs rm -f"
		info "Updating docker's repositories for $VARIANT"
		sudo docker exec "$CONTAINER" ci/travis-ci/retry.sh -t "$RETRY_MAXTRIALS" -p "$RETRY_PAUSE" -- "$APT_UPDATE"

		info "Installing dependencies for $VARIANT"
		sudo docker exec "$CONTAINER" ci/travis-ci/retry.sh -t "$RETRY_MAXTRIALS" -p "$RETRY_PAUSE" -- "$APT_INSTALL" build-essential meson cppcheck libcap-dev clang libfuse3-dev gcc git ninja-build bison libtool autoconf pkg-config libcap-dev indent fakeroot libattr1-dev uthash-dev gzip rsync autopoint uthash-dev shellcheck ca-certificates || die "Unable to install all required dependencies"

		info "Fetching repository for $VARIANT"
		sudo docker exec "$CONTAINER" git clone https://github.com/Kreyrock/Kreyrock.git

    # Exherbo        
	elif [ "$VARIANT" = exherbo ]; then
        # Get paludis-config
        sudo docker exec "$CONTAINER" [ -e /etc/paludis ] && rm -r /etc/paludis
        sudo docker exec "$CONTAINER" git clone https://github.com/Kreyrock/paludis-config.git /etc/paludis

        # Sync repositories
        sudo docker exec "$CONTAINER" cave resolve

        # Resolve required repositories
        sudo docker exec "$CONTAINER" cave resolve -x1 repository/{alip,compnerd,virtualization,danyspin97,python,perl,hasufell} || die "Unable to resolve repositories for $TRAVIS_OS_NAME"

        # Resolve required dependencies
        if [ "$COMPILER_C" = gcc ]; then
            info "Using GCC variant for $TRAVIS_OS_NAME"
            sudo docker exec "$CONTAINER" cave resolve sys-devel/meson dev-util/cppcheck sys-devel/gcc sys-fs/fuse dev-scm/git sys-devel/ninja sys-devel/bison sys-devel/libtool sys-devel/autoconf dev-util/pkg-config dev-util/indent sys-apps/fakeroot app-arch/gzip net-misc/rsync sys-devel/autoconf dev-util/shellcheck -x || die "Unable to resolve all dependencies for $TRAVIS_OS_NAME"

        elif [ "$COMPILER_C" = clang ]; then
            info "Using Clang variant for $TRAVIS_OS_NAME"
            sudo docker exec "$CONTAINER" cave resolve sys-devel/meson dev-util/cppcheck sys-devel/clang sys-fs/fuse dev-scm/git sys-devel/ninja sys-devel/bison sys-devel/libtool sys-devel/autoconf dev-util/pkg-config dev-util/indent sys-apps/fakeroot app-arch/gzip net-misc/rsync sys-devel/autoconf dev-util/shellcheck -x || die "Unable to resolve all dependencies for $TRAVIS_OS_NAME"

        else
            die "Unexpected COMPILER_C has been parsed in exherbo variant - '$COMPILER_C'"

        fi

        # Remove build instructions to save space
        sudo docker exec "$CONTAINER" [ -e /var/db/paludis ] && rm -r var/db/paludis

    else
        die "Unexpected variant has been parsed in install.sh - '$VARIANT'"

    fi

# MacOS X
elif [ "$TRAVIS_OS_NAME" = osx ]; then
	# Homebrew takes lots of time on runtime due to the cleanup used, this is a hotfix (https://travis-ci.community/t/macosx-brew-update-takes-too-much-time/6295)
	HOMEBREW_NO_INSTALL_CLEANUP=1 brew update || die "Unable to update brew"
    
	info "Installing dependencies"
	brew install shellcheck cppcheck shfmt || die "Unable to install dependencies on $TRAVIS_OS_NAME"

# FreeBSD via QEMU
elif [ "$TRAVIS_OS_NAME" = "linux" ] && [ "$QEMU" = "FreeBSD" ]; then
	if [ -n "$VARIANT" ]; then
		# Install packages
		# Ensure the file system is true (fuse-ufs2 in write mode is unreliable!)
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			"mount -fr / ; fsck -y /dev/gpt/rootfs ; mount -fw / ; df -h"

		# Basic dependencies:
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			env ASSUME_ALWAYS_YES=yes pkg update
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			env ASSUME_ALWAYS_YES=yes pkg install -y bash autoconf meson cppcheck fusefs-libs3 gcc git ninja bison libtool autoconf pkg-config indent fakeroot gzip rsync autopoint shellcheck

		# Bash shell:
		# Use bash, and make sure it is available under /bin/bash.
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			chsh -s /usr/local/bin/bash
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			ln -s /usr/local/bin/bash /bin/bash || true

		# Ports collection:
		# This is the slow method via portsnap:
		# --- ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
		# --- "portsnap --interactive fetch extract | grep -v ^/usr/ports"
		# Using Git is much faster:
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			"rm -rf /usr/ports ; git clone --depth=1 --filter=tree:0 https://github.com/freebsd/freebsd-ports /usr/ports"

		# Package's dependencies:
		ssh -p 8829 -oStrictHostKeyChecking=no -i "$HOME/.ssh/id_rsa" root@localhost \
			"cd /travis/freebsd/*/ && ( make build-depends-list && make run-depends-list ) | sed -e 's/^.*\///g' -e 's/glib20/glib/g' | sort -u | xargs -r env ASSUME_ALWAYS_YES=yes pkg install -y"

		echo "===== The FreeBSD VM is ready! ====="

	elif [ -z "$VARIANT" ]; then
		die "Variable VARIANT is not set for FreeBSD via QEMU which is fatal, This should be set in travis.yml"

	else
		die "Unexpected in FreeBSD using QEMU"

	fi
else
	die "Invalid setting of TRAVIS_OS_NAME=$TRAVIS_OS_NAME, DOCKER=$DOCKER, QEMU=$QEMU!"

fi
