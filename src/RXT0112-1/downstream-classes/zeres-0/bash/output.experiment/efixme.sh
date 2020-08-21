#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=somewhere

###! Function to output annoying fixme messages for features that needs to be implemented for the expected runtime, but that doesn't prevent the abstract
###! For example Hotfixes that need proper implementation:
###!
###!  # Not up to standard
###!  efixme "Sanitize rm"
###!  rm something
###!
###!  # Better implementation
###!  [ -e something ] && rm something
###! Can be disabled by storing value '1' in variable IGNORE_FIXME

# FIXME-QA(Krey): Merge in edebug once debugging channels are implemented?
# - (Krey) Probably better to implement a debug channel that efixme is reading from

# NOTICE(Krey): Aliases are required for posix-compatible line output (https://gist.github.com/Kreyren/4fc76d929efbea1bc874760e7f78c810)
efixme() { funcname="efixme"
	if [ "$IGNORE_FIXME" = 1 ]; then
		# FIXME: Implement 'fixme' debug channel
		edebug fixme "Fixme message for '$2' disabled"
		return 0
	elif [ "$IGNORE_FIXME" = 0 ] || [ -z "$IGNORE_FIXME" ]; then
		if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
			"$PRINTF" "$EFIXME_FORMAT_STRING" "$2" || die invalid-format
			"$PRINTF" "$EFIXME_FORMAT_STRING_LOG" "$2" >> "$logPath" || die invalid-format
			unset funcname
			return 0
		elif [ "$DEBUG" = 1 ]; then
			"$PRINTF" "$EFIXME_FORMAT_STRING_DEBUG" "$2" || die invalid-format
			"$PRINTF" "$EFIXME_FORMAT_STRING_DEBUG_LOG" "$2" >> "$logPath" || die invalid-format
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
}; alias efixme='efixme "${LINENO:-0}"'
