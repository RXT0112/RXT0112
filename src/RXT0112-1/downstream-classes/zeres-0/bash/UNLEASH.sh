#!/bin/sh
# All rights reserved by Jacob Hrbek <kreyren@rixotstudio.cz> in 04/2020 (Prepared for four freedom respecting license)
# Peer-reviewed by: <YOUR_NAME> <YOUR_EMAIL> in <DATE+TIME+TIMEZONE>

# shellcheck shell=sh

###! Base bashrc for zernit's bash backend
###! Requires:
# FIXME: Implement logic for this
###! - Command 'uname' to identify the kernel
# FIXME: Implement logic for this
###! - Command 'lsb_release' or file /etc/os-release to identify distribution and release on linux
###! Exit codes:
###! - FIXME-DOCS(Krey): Defined in die()
###! Platforms:
###! - [ ] Linux
###!  - [ ] Debian
###!  - [ ] Ubuntu
###!  - [ ] Fedora
###!  - [ ] NixOS
###!  - [ ] Archlinux
###!  - [ ] Alpine
###! - [ ] FreeBSD
###! - [ ] Darwin
###!  - MacOS
###! - [ ] Redox
###! - [ ] ReactOS
###! - [ ] Windows
###!  - [ ] Windows xp
###!  - [ ] Windows 7
###!  - [ ] Windows 8
###!  - [ ] Windows 8.1
###!  - [ ] Windows 10
###! - [ ] Windows/Cygwin
###!  - [ ] Windows 10
###! Code Quality:
###! - Replace all external commands alike 'uname' with variable to be replaced in command overrides
###! - Everything has to be sanitized
###! - Has to be tested in docker and vagrant
###! - echo() is non-standard on XNU/Darwin -> Use printf
###! - Apply styles to allow translate of the output
###! Resources:
###! - https://pkgs.org | To search Linux distros for files and package informations

# Maintainer info
UPSTREAM="https://github.com/RXT0112/Zernit"
MAINTAINER_EMAIL="kreyren@rixotstudio.cz"
MAINTAINER_NICKNAME="kreyren"
MAINTAINER_NAME="Jacob"
MAINTAINER_SURNAME="Hrbek"

# FIXME: _=${var:="some text"} is less verbose and less error prone than [ -z "$var" ] && var="some text"

# Command overrides
## These may be required on some systems
[ -z "$PRINTF" ] && PRINTF="printf"
[ -z "$WGET" ] && WGET="wget"
[ -z "$CURL" ] && CURL="curl"
[ -z "$ARIA2C" ] && ARIA2C="aria2c"
[ -z "$CHMOD" ] && CHMOD="chmod"
[ -z "$UNAME" ] && UNAME="uname"
[ -z "$TR" ] && TR="tr"
[ -z "$SED" ] && SED="sed"
[ -z "$GREP" ] && GREP="grep"

# Customization of the output
## efixme
[ -z "$EFIXME_FORMAT_STRING" ] && EFIXME_FORMAT_STRING="FIXME: %s\n"
[ -z "$EFIXME_FORMAT_STRING_LOG" ] && EFIXME_FORMAT_STRING="${logPrefix}FIXME: %s\n"
[ -z "$EFIXME_FORMAT_STRING_DEBUG" ] && EFIXME_FORMAT_STRING_DEBUG="FIXME($myName:$LINENO): %s\n"
[ -z "$EFIXME_FORMAT_STRING_DEBUG_LOG" ] && EFIXME_FORMAT_STRING_DEBUG_LOG="${logPrefix}FIXME($myName:$LINENO): %s\n"
## eerror
[ -z "$EERROR_FORMAT_STRING" ] && EERROR_FORMAT_STRING="ERROR: %s\n"
[ -z "$EERROR_FORMAT_STRING_LOG" ] && EERROR_FORMAT_STRING_LOG="${logPrefix}ERROR: %s\n"
[ -z "$EERROR_FORMAT_STRING_DEBUG" ] && EERROR_FORMAT_STRING_DEBUG="ERROR($myName:$0): %s\n"
[ -z "$EERROR_FORMAT_STRING_DEBUG_LOG" ] && EERROR_FORMAT_STRING_DEBUG_LOG="${logPrefix}ERROR($myName:$0): %s\n"
## edebug
[ -z "$EERROR_FORMAT_STRING" ] && EERROR_FORMAT_STRING="ERROR: %s\n"
[ -z "$EERROR_FORMAT_STRING_LOG" ] && EERROR_FORMAT_STRING_LOG="${logPrefix}ERROR: %s\n"
[ -z "$EERROR_FORMAT_STRING_DEBUG" ] && EERROR_FORMAT_STRING_DEBUG="ERROR($myName:$0): %s\n"
[ -z "$EERROR_FORMAT_STRING_DEBUG_LOG" ] && EERROR_FORMAT_STRING_DEBUG_LOG="${logPrefix}ERROR($myName:$0): %s\n"
## einfo
[ -z "$EINFO_FORMAT_STRING" ] && EINFO_FORMAT_STRING="INFO: %s\n"
[ -z "$EINFO_FORMAT_STRING_LOG" ] && EINFO_FORMAT_STRING_LOG="${logPrefix}INFO: %s\n"
[ -z "$EINFO_FORMAT_STRING_DEBUG" ] && EINFO_FORMAT_STRING_DEBUG="INFO($myName:$0): %s\n"
[ -z "$EINFO_FORMAT_STRING_DEBUG_LOG" ] && EINFO_FORMAT_STRING_DEBUG_LOG="${logPrefix}INFO($myName:$0): %s\n"
## die
### Generic
[ -z "$DIE_FORMAT_STRING" ] && DIE_FORMAT_STRING="FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_LOG" ] && DIE_FORMAT_STRING_LOG="${logPath}FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_DEBUG" ] && DIE_FORMAT_STRING_DEBUG="FATAL($myName:$1): %s\n"
[ -z "$DIE_FORMAT_STRING_DEBUG_LOG" ] && DIE_FORMAT_STRING_DEBUG_LOG="${logPrefix}FATAL($myName:$1): %s\\n"
### Success trap
# FIXME: Implement logic
[ -z "$DIE_FORMAT_STRING_SUCCESS" ] && DIE_FORMAT_STRING_SUCCESS="FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_LOG" ] && DIE_FORMAT_STRING_LOG="${logPath}FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_DEBUG" ] && DIE_FORMAT_STRING_DEBUG="FATAL($myName:$1): %s\n"
[ -z "$DIE_FORMAT_STRING_DEBUG_LOG" ] && DIE_FORMAT_STRING_DEBUG_LOG="${logPrefix}FATAL($myName:$1): %s\\n"
### Fixme trap
[ -z "$DIE_FORMAT_STRING_FIXME" ] && DIE_FORMAT_STRING_FIXME="FATAL: %s in script '$myName' located at '$0', fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_LOG" ] && DIE_FORMAT_STRING_FIXME_LOG="${logPrefix}FATAL: %s, fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_DEBUG" ] && DIE_FORMAT_STRING_FIXME_DEBUG="FATAL($myName:$1): %s, fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_DEBUG_LOG" ] && DIE_FORMAT_STRING_FIXME_DEBUG_LOG="${logPrefix}FATAL($myName:$1): %s, fixme?\\n"
### Bug Trap
[ -z "$DIE_FORMAT_STRING_BUG" ] && DIE_FORMAT_STRING_BUG="BUG: Unexpected happend while processing %s in script '$myName' located at '$0'\\n\\nIf you think that this is a bug, the report it to $UPSTREAM to @$MAINTAINER_NICKNAME with output from $logPath for relevant runtime"
[ -z "$DIE_FORMAT_STRING_BUG_LOG" ] && DIE_FORMAT_STRING_BUG_LOG="${logPrefix}$DIE_FORMAT_STRING_BUG"
[ -z "$DIE_FORMAT_STRING_BUG_DEBUG" ] && DIE_FORMAT_STRING_BUG_DEBUG="BUG:($myName:$1): ${DIE_FORMAT_STRING_BUG%%BUG:}"
[ -z "$DIE_FORMAT_STRING_BUG_DEBUG_LOG" ] && DIE_FORMAT_STRING_BUG_DEBUG_LOG="${logPrefix}$DIE_FORMAT_STRING_BUG_DEBUG"
### Fixme trap
[ -z "$DIE_FORMAT_STRING_FIXME" ] && DIE_FORMAT_STRING_FIXME="FATAL: %s in script '$myName' located at '$0', fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_LOG" ] && DIE_FORMAT_STRING_FIXME_LOG="${logPrefix}FATAL: %s, fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_DEBUG" ] && DIE_FORMAT_STRING_FIXME_DEBUG="FATAL($myName:$1): %s, fixme?\n"
[ -z "$DIE_FORMAT_STRING_FIXME_DEBUG_LOG" ] && DIE_FORMAT_STRING_FIXME_DEBUG_LOG="${logPrefix}FATAL($myName:$1): %s, fixme?\\n"
### Unexpected trap
[ -z "$DIE_FORMAT_STRING_UNEXPECTED" ] && DIE_FORMAT_STRING_UNEXPECTED="FATAL: Unexpected happend while %s in $myName located at $0\\n"
[ -z "$DIE_FORMAT_STRING_UNEXPECTED_LOG" ] && DIE_FORMAT_STRING_UNEXPECTED_LOG="${logPrefix}FATAL: Unexpected happend while %s\\n"
[ -z "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG" ] && DIE_FORMAT_STRING_UNEXPECTED_DEBUG="FATAL($myName:$1): Unexpected happend while %s in $myName located at $0\\n"
[ -z "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG_LOG" ] && DIE_FORMAT_STRING_UNEXPECTED_DEBUG="${logPrefix}FATAL($myName:$1): Unexpected happend while %s\\n"
# elog
[ -z "$ELOG_FORMAT_STRING_DEBUG_LOG" ] && ELOG_FORMAT_STRING_DEBUG_LOG="${logPrefix}LOG: %s\\n"
# ebench
[ -z "$EBENCH_FORMAT_STRING_START" ] && EBENCH_FORMAT_STRING="BENCHMARK: Starting benchmark for action %s\n"
[ -z "$EBENCH_FORMAT_STRING_RESULT" ] && EBENCH_FORMAT_STRING="BENCHMARK: Action %s took $SECONDS seconds\n"

# Exit on anything unexpected
set -e

# NOTICE(Krey): By default busybox outputs a full path in '$0' this is used to strip it
myName="${0##*/}"

# Used to prefix logs with timestemps, uses ISO 8601 by default
logPrefix="[ $(date -u +"%Y-%m-%dT%H:%M:%SZ") ] "
# Path to which we will save logs
# NOTICE(Krey): To avoid storing file '$HOME/.some-name.sh.log' we are stripping the '.sh' here
# FIXME-QA: Make sure the the directory path is present or this fails
# FIXME-COMPAT: Make sure this works on Windows and Darwin
logPath="${XDG_DATA_HOME:-$HOME/.local/share}/${myName%%.sh}.log"

# inicialize the script in logs
# FIXME: Allow end-users to customize this
"$PRINTF" '%s\n' "Started $myName on $("$UNAME" -s) at $(date -u +"%Y-%m-%dT%H:%M:%SZ")" >> "$logPath"

# DNM: Specify the path to die()
. path/to/die

# DNM: Specify the path
. path/to/einfo

. path/to/ewarn

. path/to/efixme

efixme() { funcname=efixme
	if [ "$IGNORE_FIXME" = 1 ]; then
		edebug fixme "Fixme message for '$2' disabled"
	elif [ "$IGNORE_FIXME" = 0 ] || [ -z "$IGNORE_FIXME" ]; then
		if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
			"$PRINTF" "$EFIXME_FORMAT_STRING" "$2"
			"$PRINTF" "$EFIXME_FORMAT_STRING" "$2" >> "$logPath"
			unset funcname
			return 0
		elif [ "$DEBUG" = 1 ]; then
			"$PRINTF" "$EFIXME_FORMAT_STRING_DEBUG" "$2"
			"$PRINTF" "$EFIXME_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath"
			unset funcname
			return 0
		else
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) die 255 "processing DEBUG variable with value '$DEBUG' in $funcname"
			esac
		fi
	else
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) die 255 "processing variable IGNORE_FIXME with value '$IGNORE_FIXME' in $0"
		esac
	fi
}; alias efixme='efixme "$LINENO"'

# Resolve root
rootCheck() { funcname=rootCheck
	case "$LANG" in
		# FIXME-TRANSLATE: Translate to more languages
		en-*|*) edebug "Resolving root on user with ID '$(id -u)"
	esac

	if [ "$(id -u)" = 0 ]; then
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) edebug "Script has been executed as user with ID 0, assuming root"
		esac
		# NOTICE(Krey): We are prefixing root commands with '$SUDO', this is done to make sure that we are not using sudo here
		unset SUDO
		funcname="$myName"
		return 0
	# NOTICE(Krey): The ID 33333 is used by gitpod
	elif [ "$(id -u)" = 1000 ] || [ "$(id -u)" = 33333 ]; then
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) ewarn "Script $myName is not expected to run as non-root, trying to elevate root.."
		esac

		if command -v sudo 1>/dev/null; then
			case "$LANG" in
				en-*|*) einfo "Found 'sudo' that can be used for root elevation"
			esac

			SUDO=sudo
			funcname="$myName"
			return 0
		elif command -v su 1>/dev/null; then
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) einfo "Found 'su' that can be used for a root elevation"
			esac
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) ewarn "This will require the end-user to parse a root password multiple times assuming that root has a password set"
			esac
			SUDO=su
			funcname="$myName"
			return 0
		elif ! command -v sudo 1>/dev/null && ! command -v su 1>/dev/null; then
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) die 3 "Script $myName depends on root permission to install packages where commands 'sudo' nor 'su' are available for root elevation"
			esac
			funcname="$myName"
			return 0
		else
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) die 225 "processing root on non-root"
			esac
		fi
	else
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) die 3 "Unknown user ID '$(id -u)' has been parsed in script $myName"
		esac
	fi
}

# Identify system
if command -v "$UNAME" 1>/dev/null; then
	unameKernel="$("$UNAME" -s)"
	edebug "Identified the kernel as '$unameKernel"
	case "$unameKernel" in
		Linux)
			KERNEL="$unameKernel"

			# Assume Linux Distro and release
			# NOTICE(Krey): We are expecting this to return a lowercase value
			if command -v "$LSB_RELEASE" 1>/dev/null; then
				assumedDistro="$("$LSB_RELEASE" -si | "$TR" :[upper]: :[lower]:)"
				assumedRelease="$("$LSB_RELEASE" -cs | "$TR" :[upper]: :[lower]:)"
			elif ! command -v "$LSB_RELEASE" 1>/dev/null && [ -f /etc/os-release ]; then
				assumedDistro="$("$GREP" -o "^ID\=.*" /etc/os-release | "$SED" s/ID=//gm)"
				assumedRelease="$("$GREP" -o"^VERSION_CODENAME\=.*" /etc/os-release | "$SED" s/VERSION_CODENAME=//gm)"
			elif ! command -v "$LSB_RELEASE" 1>/dev/null && [ ! -f /etc/os-release ]; then
				die 1 "Unable to identify linux distribution using  command 'lsb_release' nor file '/etc/os-release'"
			else
				die 255 "attempting to assume linux distro and release"
			fi

			edebug "Identified distribution as '$assumedDistro'"
			edebug "Identified distribution release as '$assumedRelease'"

			# Verify Linux Distro
			efixme "Add sanitization logic for other linux distributions"
			case "$assumedDistro" in
				ubuntu | debian | fedora | nixos | opensuse | gentoo | exherbo)
					DISTRO="$assumedDistro"
				;;
				*) die fixme "Unexpected Linux distribution '$assumedDistro' has been detected."
			esac

			# Verify Linux Distro Release
			efixme "Sanitize verification of linux distro release"
			assumedRelease="$RELEASE"
		;;
		FreeBSD | Redox | Darwin | Windows)
			KERNEL="$unameKernel"
		;;
		*) die 255 "Unexpected kernel '$unameKernel'"
	esac
elif ! command -v "$UNAME" 1>/dev/null; then
	die 1 "Standard command '$UNAME' is not available on this system, unable to identify kernel"
else
	die 255 "Identifying system"
fi

# Define hostname
# NOTICE: Variable 'HOSTNAME' is not defined on POSIX sh
if command -v hostname 1>/dev/null; then
	HOSTNAME="$(hostname)"
elif [ -s /etc/hostname ]; then
	HOSTNAME="$(cat /etc/hostname)"
elif ! command -v hostname 1>/dev/null && [ ! -s /etc/hostname ]; then
	die false "Unable to determine the hostname from command 'hostname' (which doesn't exists) and from file /etc/hostname (that doesn't exists or is blank)"
else
	die unexpected "processing hostname"
fi

# Argument management
while [ "$#" -gt 0 ]; do case "$1" in
	install-deps)
		packageManagement
	;;
	test-docker-debian)
		efixme "Implement logic to make sure that docker is available"
		die fixme "Implement tests for debian on docker"
		$SUDO docker run debian sh -c "true \
			&& apt-get update -q \
			&& apt-get install -qy lsb-release \
			&& sh $0"
	;;
	--help|help)
		efixme "HELP_MESSAGE"
	;;
	*)
		die 2 "FIXME_MESSAGE"
	;;
esac; done
