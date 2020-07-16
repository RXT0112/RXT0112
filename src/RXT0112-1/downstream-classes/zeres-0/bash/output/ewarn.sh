#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=somewhere

###! Function to warn the end-user about something important

ewarn() { funcname="ewarn"
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EWARN_FORMAT_STRING" "$2" || die invalid-format
		"$PRINTF" "$EWARN_FORMAT_STRING_LOG" "$2" >> "$logPath" || die invalid-format
		unset funcname
		exit 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EWARN_FORMAT_STRING_DEBUG" "$2" || die invalid-format
		"$PRINTF" "$EWARN_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath" || die invalid-format
		unset funcname
		exit 0
	else
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) die bug "processing variable DEBUG with value '$DEBUG' in $funcname"
		esac
	fi
}; alias ewarn='ewarn "$LINENO"'
