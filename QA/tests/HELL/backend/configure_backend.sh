#!/bin/sh
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'before-install' from rsplib	(https://raw.githubusercontent.com/dreibh/rsplib/master/ci/before-install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

: '
    This file is used to configure backend depending on expected workflow. This is for example installing dependencies for tests.

    This file expects following variables:
    - KERNEL = Used kernel (linux)
    - VARIANT = Name of used distribution (debian)
    - IDENTIFIER = name of codename or version ("bullseye" or "11")

    In case DOCKER images are used:
    - DOCKER = Name of used docker container (exherbo/exherbo_ci:latest)

    In case QEMU is used:
    - QEMU = Name of (FIXME, not implemented)

    TODO
    - Implement building of DOCKER images
    - Implement QEMU
'

# Configure backend
if [ "$KERNEL" = linux ]; then
    # Install all dependencies
    info "Installing dependencies for on $KERNEL for $VARIANT-$IDENTIFIER"

    case "$VARIANT-$IDENTIFIER" in
        ubuntu-bionic|ubuntu-18.04)
            # Install all dependencies
            apt install -y \
                meson cppcheck libcap-dev clang libfuse3-dev gcc git ninja-build bison libtool autoconf pkg-config libcap-dev indent fakeroot libattr1-dev uthash-dev gzip rsync autopoint uthash-dev shellcheck \
            || die "Unable to install all dependencies for $VARIANT-$IDENTIFIER"

            # libfuse3-dev hack
            if [ "$(apt-cache search libfuse3-dev | grep -o "libfuse3-dev")" != "libfuse3-dev" ]; then
                warn "libfuse3-dev is not available on $VARIANT-$IDENTIFIER, trying to resolve manually"

                apt install -y ninja-build || die 1 "Unable to install dependencies for hack"

                mkdir "$HOME/build/fuse3"

                fixme "Export latest fuse3 instead of hard-coded?"
                if [ ! -e "$HOME/build/fuse3/fuse-3.6.2.tar.xz" ]; then
                    wget https://github.com/libfuse/libfuse/releases/download/fuse-3.6.2/fuse-3.6.2.tar.xz -O "$HOME/build/fuse3/fuse-3.6.2.tar.xz" || die 1 "Unable to fetch fuse"
                elif [ -e "$HOME/build/fuse3/fuse-3.6.2.tar.xz" ]; then
                    info "File '$HOME/build/fuse3/fuse-3.6.2.tar.xz' is already fetched"
                else
                    die 255 "Fetching fuse3 tarball"
                fi

                fixme "Sanitize tarball export (do not export if the tarball already exists)"
                tar xpf "$HOME/build/fuse3/fuse-3.6.2.tar.xz" --directory="$HOME/build/fuse3/"

                # FIXME: Sanitize - Do not create a build dir if it already exists
                mkdir "$HOME/build/fuse3/fuse-3.6.2/build"

                fixme "Do not use 'cd'"
                cd "$HOME/build/fuse3/fuse-3.6.2/build" || die 1 "Unable to change directory in '$HOME/build/fuse3/fuse-3.6.2/build'"

                meson .. --prefix /usr || die 1 "Meson failed, (FIXME: more info required)"

                ninja || die 1 "ninja failed, (FIXME: more info required)"

                ninja install || die 1 "ninja install failed, (FIXME: more info required)"
            elif [ "$(apt-cache search libfuse3-dev | grep -o "libfuse3-dev")" = "libfuse3-dev" ]; then
                info "libfuse3-dev is available on this $VARIANT-$IDENTIFIER, no need to install it manually"
                apt install -y libfuse3-dev || die 1 "Unable to install libfuse3-dev"
            else
                die 255 "libfuse3-dev in $VARIANT"
            fi

            # Hack fof shfmt
            if [ "$(apt-cache search shfmt | grep -o "shfmt")" != "shfmt" ]; then
                warn "This system doesn't have shfmt in build instructions, trying to resolve.."

                if [ -e /usr/bin/shfmt ]; then
                    info "shfmt is already installed, skipping hack"

                elif [ ! -e /usr/bin/shfmt ]; then
                    info "shfmt is not installed, installing.."

                    # Sanitized in if statement's expression
                    wget https://github.com/mvdan/sh/releases/download/v3.0.0-beta1/shfmt_v3.0.0-beta1_linux_amd64 -O /usr/bin/shfmt

                    # Make sure that it is executable
                    [ ! -x /usr/bin/shfmt ] && chmod +x /usr/bin/shfmt
                else
                    die 255 "shfmt hack in $VARIANT"
                fi
            elif [ "$(apt-cache search shfmt | grep -o "shfmt")" = "shfmt" ]; then
                info "shfmt is available on this $VARIANT, no need to install it manually"
                apt install -y shfmt
            else
                die 255 "shfmt hack in ubuntu"
            fi
        ;;
        ubuntu-*)
            apt install -y \
                meson cppcheck libcap-dev clang libfuse3-dev gcc git ninja-build bison libtool autoconf pkg-config libcap-dev indent fakeroot libattr1-dev uthash-dev gzip rsync autopoint uthash-dev shellcheck \
            || die 1 "Unable to install all dependencies for $VARIANT-$IDENTIFIER"
            
            # Hack fof shfmt
            if [ "$(apt-cache search shfmt | grep -o "shfmt")" != "shfmt" ]; then
                warn "This system doesn't have shfmt in build instructions, trying to resolve.."

                if [ -e /usr/bin/shfmt ]; then
                    info "shfmt is already installed, skipping hack"
                elif [ ! -e /usr/bin/shfmt ]; then
                    info "shfmt is not installed, installing.."
                    wget https://github.com/mvdan/sh/releases/download/v3.0.0-beta1/shfmt_v3.0.0-beta1_linux_amd64 -O /usr/bin/shfmt
                    [ ! -x /usr/bin/shfmt ] && chmod +x /usr/bin/shfmt
                else
                    die 255 "shfmt hack in $VARIANT"
                fi
            elif [ "$(apt-cache search shfmt | grep -o "shfmt")" = "shfmt" ]; then
                info "shfmt is available on this $VARIANT, no need to install it manually"
                apt install -y shfmt
            else
                die 255 "shfmt hack in $VARIANT"
            fi
        ;;
        *) die 2 "Unsupported VARIANT-IDENTIFIER - $VARIANT-$IDENTIFIER"
    esac

    # Docker backend
    if [ -n "$DOCKER" ]; then
        info "Preparing the environment to run docker image '$DOCKER'"

        # Install docker dependencies
        info "Installing dependencies for docker"

        case "$VARIANT-$IDENTIFIER" in
            ubuntu*|debian*)
                apt install -y docker-io || die 1 "Unable to install docker dependencies on $VARIANT-$IDENTIFIER"
            ;;
            *) die 2 "Unsupported VARIABLE-IDENTIFIER has been parsed in resoluting docker dependencies"
        esac

        case "$VARIANT-$IDENTIFIER" in
            debian*|ubuntu*|exherbo*)
            	docker run -d --name "$DOCKER" || die 1 "Unable to run docker image '$DOCKER' on $VARIANT-$IDENTIFIER"
            ;;
            *) die "Unsupported VARIANT-IDENTIFIER has been parsed - $VARIANT-$IDENTIRIER"
        esac

        # Get docker image
        case "$DOCKER_IMAGE" in
            */*:*|*/*) # Fetch docker image from dockerhub
                die fixme "Implement using docker images from dockerhub"
            build_*) # Build docker images
                info "Preparing to build docker image ${DOCKERIMAGE#build_}"
                case ${DOCKER_IMAGE#build_} in
                    exherbo)
                        die fixme "Implement building exherbo docker image"
                    ;;
                    *) die 255 "DOCKER_IMAGE - build"
                esac
            ;;
            *) die 255 "DOCKER_IMAGE"
        esac

    # In case Docker is not used
    elif [ -z "$DOCKER" ]; then
        info "Docker is not used, skipping configuration"
    else
        die 255 "Docker backend in $KERNEL"
    fi

    if [ -n "$QEMU" ]; then
        die fixme "Implement tests on QEMU using linux"
    elif [ -z "$QEMU" ]; then
        info "QEMU is not used, skipping configuration"
    else
        die 255 "QEMU in $KERNEL"
    fi

elif [ "$KERNEL" = darwin ]; then
    # Homebrew takes lots of time on runtime due to the cleanup used, this is a hotfix (https://travis-ci.community/t/macosx-brew-update-takes-too-much-time/6295)
	HOMEBREW_NO_INSTALL_CLEANUP=1 brew update || die "Unable to update brew repositories"
    
	info "Installing dependencies on $KERNEL"
	brew install shellcheck cppcheck shfmt || die "Unable to install dependencies on $KERNEL"
elif [ "$KERNEL" = freebsd ]; then
    fixme "$KERNEL is not implemented"
else
    die "Unsupported KERNEL used - $KERNEL"
fi