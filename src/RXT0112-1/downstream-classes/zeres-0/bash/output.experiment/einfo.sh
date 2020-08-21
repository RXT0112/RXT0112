#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=somewhere

###! Function to inform the end-user about what is happening during the runtime

einfo() { funcname="einfo"
	if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
		"$PRINTF" "$EINFO_FORMAT_STRING" "$1" || die invalid-format
		"$PRINTF" "$EINFO_FORMAT_STRING_LOG" "$1" >> "$logPath" || die invalid-format
		unset funcname
		return 0
	elif [ "$DEBUG" = 1 ]; then
		"$PRINTF" "$EINFO_FORMAT_STRING_DEBUG" "$1" || die invalid-format
		"$PRINTF" "$EINFO_FORMAT_STRING_DEBUG_LOG" "$1" >> "$logPath" || die invalid-format
		unset funcname
		return 0
	else
		case "$LANG" in
			# FIXME-TRANSLATE: Translate to more languages
			en-*|*) die bug "processing variable DEBUG with value '$DEBUG' in $funcname"
		esac
	fi
}; alias einfo='einfo "${LINENO:-0}"'
