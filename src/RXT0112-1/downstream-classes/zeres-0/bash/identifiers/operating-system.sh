#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 18/08/2020 08:13:35 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Make sure this works
# shellcheck source=src/RXT0112-1/downstream-classes/zeres-0/bash/zernit.bashrc

###! Identifier script used to identify:
###! - Kernel - Stored in environment variable 'KERNEL' lowercase i.e 'linux'
###! - Release - Stores

# Identify system
# FIXME: /etc/issue could also be used to identify the system
# FIXME: /etc/debian_version can also be used
# FIXME: /etc/devuan_version can also be used
if "$COMMAND" -v "$UNAME" 1>/dev/null; then
	unameKernel="$("$UNAME" -s)"
	edebug "Identified the kernel as '$unameKernel"
	case "$unameKernel" in
		Linux)
			KERNEL="$(printf '%s\n' "$unameKernel" | "$TR" [[:upper:]] [[:lower:]])"

			# Assume Linux Distro and release
			# NOTICE(Krey): We are expecting this to return a lowercase value
			if "$COMMAND" -v "$LSB_RELEASE" 1>/dev/null; then
				assumedDistro="$("$LSB_RELEASE" -si | "$TR" [[:upper:]] [[:lower:]])"
				assumedRelease="$("$LSB_RELEASE" -cs | "$TR" [[:upper:]] [[:lower:]])"
			elif ! "$COMMAND" -v "$LSB_RELEASE" 1>/dev/null && [ -f /etc/os-release ]; then
				assumedDistro="$("$GREP" -o "^ID\=.*" /etc/os-release | "$SED" s/ID=//gm | "$TR" [[:upper:]] [[:lower:]])"
				assumedRelease="$("$GREP" -o "^VERSION_CODENAME\=.*" /etc/os-release | "$SED" s/VERSION_CODENAME=//gm | "$TR" [[:upper:]] [[:lower:]])"
			elif ! "$COMMAND" -v "$LSB_RELEASE" 1>/dev/null && [ ! -f /etc/os-release ]; then
				die 1 "Unable to identify linux distribution using  command 'lsb_release' nor file '/etc/os-release'"
			else
				die 255 "attempting to assume linux distro and release"
			fi

			edebug "Identified distribution as '$assumedDistro'"
			edebug "Identified distribution release as '$assumedRelease'"

			# Verify Linux Distro
			efixme "Add sanitization logic for other linux distributions"
			case "$assumedDistro" in
				ubuntu | debian | fedora | nixos | opensuse | gentoo | exherbo | devuan)
					DISTRO="$assumedDistro"
				;;
				*) die fixme "Unexpected Linux distribution '$assumedDistro' has been detected."
			esac

			# Verify Linux Distro Release
			efixme "Sanitize verification of linux distro release"
			RELEASE="$assumedRelease"
		;;
		FreeBSD | Redox | Darwin | Windows)
			KERNEL="$unameKernel"
		;;
		*) die 255 "Unexpected kernel '$unameKernel'"
	esac
elif ! "$COMMAND" -v "$UNAME" 1>/dev/null; then
	die 1 "Standard command '$UNAME' is not available on this system, unable to identify kernel"
else
	die 255 "Identifying system"
fi
