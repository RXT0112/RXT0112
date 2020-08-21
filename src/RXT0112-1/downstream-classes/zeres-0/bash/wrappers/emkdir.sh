#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=somewhere

###! Sanitized wrapper to create a directory

emkdir() { funcname="emkdir"
	edebug "$funcname" "Instructed to create directory at path '$1'"

	case "$KERNEL" in
		"linux")
			if [ -d "$1" ]; then
				edebug "$funcname" "Directory '$1' already exists, no need to create it"

				unset funcname
				return 0
			elif [ ! -d "$1" ]; then
				einfo "Creating a new directory in '$1' as requested"

				# Create the directory
				if cmd_check "$MKDIR"; then
					mkdir "$1" || die 1 "Function '$funcname' called from '$myName' is unable to create a new directory in '$1'"
					unset funcname
					return 0
				elif ! cmd_check "$MKDIR"; then
					die false "Unable to create a new directory, because neither neither of supported command(s) are available on this system: mkdir"
				else
					die bug "checking for command used to create directories in $funcname"
				fi
			else
				die bug "checking wether '$1' is a directory"
			fi
		;;
		*) die fixme "Function '$funcname' is not implemented for kernel '$KERNEL'"
	esac

die security "Function '$funcname' escaped sanitization"
}
