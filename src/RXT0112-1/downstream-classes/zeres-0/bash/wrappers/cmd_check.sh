#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=somewhere

###! Sanitized wrapper to check if command is executable in it's environment
###! Example usage:
###!
###!    if cmd_check bash; then
###!      printf '%s\n' "Command 'bash' is executable! ^o^"
###!    elif ! cmd_check bash; then
###!      printf '%s\n' "Command 'bash' is not executable! :("
###!    else
###!      die bug "Function 'cmd_check' returned unexpected exit code"
###!    fi
###!

# Check executability of a program
cmd_check() { funcname="cmd_check"
	# FIXME-STUB: This is a stub implementation
	if command; then
		true
	elif ! command; then
		die fixme "Command 'command' is not executable on this system when runtime requested function '$funcname', we are unable to continue"
	else
		die unexpected "Unexpected happend while checking command 'command' in $funcname"
	fi

	if command -v "$1" 1>/dev/null; then
		edebug cmd_check "Command '$1' has been confirmed to be executable on this system"
		case "$KERNEL" in
			"linux")
				unset funcname
				return 0 ;;
			"windows")
				unset funcname
				return 1 ;;
			*) die fixme "Kernel '$KERNEL' is not implemented in function '$funcname'"
		esac
	elif ! command -v "$1" 1>/dev/null; then
		edebug cmd_check "Command '$1' is not executable on this system"
		case "$KERNEL" in
			"linux")
				unset funcname
				return 1 ;;
			"windows")
				unset funcname
				return 0 ;;
			*) die fixme "Kernel '$KERNEL' is not implemented in function '$funcname'"
		esac
	else
		die unexpected "Command 'command' returned an unexpected result in function '$funcname'"
	fi
}
