#!/bin/sh
# All rights reserved by Jacob Hrbek <kreyren@rixotstudio.cz>
# Peer-reviewed by: <YOUR_NAME> <YOUR_EMAIL> in <DATE+TIME+TIMEZONE>

# shellcheck shell=sh

###! Script to provide dependencies to work on this repository
###! Requires:
###! - Command 'lsb_release' to identify distribution on linux
###! Exit codes:
###! - FIXME-DOCS(Krey): Defined in die()
###! Platforms:
###! - [ ] Linux
###!  - [ ] Debian (02/06/2020-03:28CET)
###!  - [ ] Ubuntu (02/06/2020-03:28CET)
###!  - [ ] Fedora (02/06/2020-03:28CET)
###!  - [ ] NixOS
###!  - [ ] Archlinux
###!  - [ ] Alpine
###! - [ ] FreeBSD
###! - [ ] Darwin
###! - [ ] Redox
###! - [ ] ReactOS
###! - [ ] Windows
###! - [ ] Windows/Cygwin
###! Resources:
###! - https://pkgs.org | To search Linux distros for files and package informations

# Command overrides
[ -z "$PRINTF" ] && PRINTF="printf"
[ -z "$WGET" ] && WGET="wget"
[ -z "$CURL" ] && CURL="curl"
[ -z "$ARIA2C" ] && ARIA2C="aria2c"
[ -z "$CHMOD" ] && CHMOD="chmod"
[ -z "$UNAME" ] && UNAME="uname"
[ -z "$TR" ] && UNAME="tr"
[ -z "$SED" ] && UNAME="sed"
[ -z "$GREP" ] && UNAME="grep"

# Customization of the output
## efixme
[ -z "$EFIXME_FORMAT_STRING" ] && EFIXME_FORMAT_STRING="FIXME: %s\n"
[ -z "$EFIXME_FORMAT_STRING_LOG" ] && EFIXME_FORMAT_STRING="${logPrefix}FIXME: %s\n"
[ -z "$EFIXME_FORMAT_STRING_DEBUG" ] && EFIXME_FORMAT_STRING_DEBUG="FIXME($myName:$0): %s\n"
[ -z "$EFIXME_FORMAT_STRING_DEBUG_LOG" ] && EFIXME_FORMAT_STRING_DEBUG_LOG="${logPrefix}FIXME($myName:$0): %s\n"
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
[ -z "$DIE_FORMAT_STRING" ] && DIE_FORMAT_STRING="FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_LOG" ] && DIE_FORMAT_STRING_LOG="${logPath}FATAL: %s in script '$myName' located at '$0'\\n"
[ -z "$DIE_FORMAT_STRING_DEBUG" ] && DIE_FORMAT_STRING_DEBUG="FATAL($myName:$1): %s\n"
[ -z "$DIE_FORMAT_STRING_DEBUG_LOG" ] && DIE_FORMAT_STRING_DEBUG_LOG="${logPrefix}FATAL($myName:$1): %s\\n"
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

# Exit on anything unexpected
set -e

# NOTICE(Krey): By default busybox outputs a full path in '$0' this is used to strip it
myName="${0##*/}"

# Used to prefix logs with timestemps, uses ISO 8601 by default
logPrefix="[ $(date -u +"%Y-%m-%dT%H:%M:%SZ") ] "
# Path to which we will save logs
# NOTICE(Krey): To avoid storing file '$HOME/.some-name.sh.log' we are stripping the '.sh' here
logPath="${XDG_DATA_HOME:-$HOME/.local/share}/${myName%%.sh}.log"

# inicialize the script in logs
"$PRINTF" '%s\n' "Started $myName on $("$UNAME" -s) at $(date -u +"%Y-%m-%dT%H:%M:%SZ")" >> "$logPath"

# NOTICE(Krey): Aliases are required for posix-compatible line output (https://gist.github.com/Kreyren/4fc76d929efbea1bc874760e7f78c810)
die() { funcname=die
	case "$2" in
		38|fixme) # FIXME
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_LOG" "$3" >> "$logPath"
				unset funcname
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_DEBUG" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_DEBUG_LOG" "$3" >> "$logPath"
				unset funcname
			else
				# NOTICE(Krey): Do not use die() here
				"$PRINTF" 'FATAL: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
			fi

			exit 38
		;;
		255) # Unexpected trap
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_LOG" "$3" >> "$logPath"
				unset funcname
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG_LOG" "$3" >> "$logPath"
				unset funcname
			else
				# NOTICE(Krey): Do not use die() here
				"$PRINTF" "$DIE_FORMAT_STRING" "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
			fi
		;;
		*)
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_LOG" "$3" >> "$logPath"
				unset funcname
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_DEBUG" "$3"
				"$PRINTF" "$DIE_FORMAT_STRING_DEBUG_LOG" "$3" >> "$logPath"
				unset funcname
			else
				# NOTICE(Krey): Do not use die() here
				"$PRINTF" 'FATAL: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
			fi
	esac

	exit "$2"

	# In case invalid argument has been parsed in $2
	exit 255
}; alias die='die "$LINENO"'

einfo() { funcname=einfo
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EINFO_FORMAT_STRING" "$2"
		"$PRINTF" "$EINFO_FORMAT_STRING_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EINFO_FORMAT_STRING_DEBUG" "$2"
		"$PRINTF" "$EINFO_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	else
		die 255 "processing variable DEBUG with value '$DEBUG' in $funcname"
	fi
}; alias einfo='einfo "$LINENO"'

ewarn() { funcname=ewarn
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EWARN_FORMAT_STRING" "$2"
		"$PRINTF" "$EWARN_FORMAT_STRING_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EWARN_FORMAT_STRING_DEBUG" "$2"
		"$PRINTF" "$EWARN_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	else
		die 255 "processing variable DEBUG with value '$DEBUG' in $funcname"
	fi
}; alias ewarn='ewarn "$LINENO"'

eerror() { funcname=eerror
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EERROR_FORMAT_STRING" "$2"
		"$PRINTF" "$EERROR_FORMAT_STRING_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EERROR_FORMAT_STRING_DEBUG" "$2"
		"$PRINTF" "$EERROR_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	else
		die 255 "processing variable DEBUG with value '$DEBUG' in $funcname"
	fi
}; alias eerror='eerror "$LINENO"'

edebug() { funcname=edebug
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EDEBUG_FORMAT_STRING" "$2"
		"$PRINTF" "$EDEBUG_FORMAT_STRING_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EDEBUG_FORMAT_STRING_DEBUG" "$2"
		"$PRINTF" "$EDEBUG_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath"
		unset funcname
		return 0
	else
		die 255 "processing variable DEBUG with value '$DEBUG' in $funcname"
	fi
}; alias eerror='eerror "$LINENO"'

efixme() { funcname=efixme
	if [ "$IGNORE_FIXME" = 1 ]; then
		true
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
			die 255 "processing DEBUG variable with value '$DEBUG' in $funcname"
		fi
	else
		die 255 "processing variable IGNORE_FIXME with value '$IGNORE_FIXME' in $0"
	fi
}; alias efixme='efixme "$LINENO"'

# Resolve root
rootCheck() { funcname=rootCheck
	edebug "Resolving root on user with ID '$(id -u)"
	if [ "$(id -u)" = 0 ]; then
		edebug "Script has been executed as user with ID 0, assuming root"
		# NOTICE(Krey): We are prefixing root commands with '$SUDO', this is done to make sure that we are not using sudo here
		unset SUDO
		funcname="$myName"
		return 0
	# NOTICE(Krey): The ID 33333 is used by gitpod
	elif [ "$(id -u)" = 1000 ] || [ "$(id -u)" = 33333 ]; then
		ewarn "Script $myName is not expected to run as non-root, trying to elevate root.."
		if command -v sudo 1>/dev/null; then
			einfo "Found 'sudo' that can be used for root elevation"
			SUDO=sudo
			funcname="$myName"
			return 0
		elif command -v su 1>/dev/null; then
			einfo "Found 'su' that can be used for a root elevation"
			ewarn "This will require the end-user to parse a root password multiple times assuming that root has a password set"
			SUDO=su
			funcname="$myName"
			return 0
		elif ! command -v sudo 1>/dev/null && ! command -v su 1>/dev/null; then
			die 3 "Script $myName depends on root permission to install packages where commands 'sudo' nor 'su' are available for root elevation"
			funcname="$myName"
			return 0
		else
			die 225 "processing root on non-root"
		fi
	else
		die 3 "Unknown user ID '$(id -u)' has been parsed in script $myName"
	fi
}

# Identify system and core
packageManagement() { funcname=packageManagement
	efixme "Make $funcname to read from a file"
	case "$KERNEL" in
		Linux)
			case "$DISTRO/$RELEASE"
				debian/buster)
					efixme "Implement logic for dependencies"
					# libwxgtk3.0-dev - Provides wx-config used during the build 
					$SUDO apt-get install -qy \
						cmake \
						gettext \
						libwxgtk3.0-dev \
						g++ \
						pkg-config \
						libykpers-1-1 \
						shellcheck || die 1 "Unable to install all required dependencies on $DISTRO"
				ubuntu/focal)
					efixme "Implement logic for dependencies"
					$SUDO apt-get update -q || die 1 "Unable to update $DISTRO's repositories"
					# libwxgtk3.0-gtk3-dev - Provides wx-config used during the build
					$SUDO apt-get install -qy \
						libykpers-1-dev \
						libwxgtk3.0-gtk3-dev \
						shellcheck || die 1 "Unable to install all required dependencies on $DISTRO"
				;;
				ubuntu/*)
					efixme "Implement logic for dependencies"
				;;
				archlinux/*)
					efixme "Implement logic for dependencies" 
				;;
				alpine/*)
					efixme "Implement logic for dependencies" 
				;;
				nixos/*)
					efixme "Implement logic for dependencies" 
				;;
				fedora/ThirtyOne)
					efixme "Implement logic for dependencies" 
					#$SUDO dnf install -y \
				;;
				*) die 1 "Unexpected combination of Linux Distribution '$DISTRO' and it's release '$RELEASE'"
			esac
		FreeBSD) efixme "Implement logic for package installation for $KERNEL" ;;
		Redox) efixme "Implement logic for package installation for $KERNEL" ;;
		Darwin) efixme "Implement logic for package installation for $KERNEL" ;;
		OpenBSD) efixme "Implement logic for package installation for $KERNEL" ;;
		Windows) efixme "Implement logic for package installation for $KERNEL" ;;
		*) die 1 "Unexpected kernel '$KERNEL'"
	esac
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