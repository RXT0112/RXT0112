#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Make sure this works
# shellcheck source=src/RXT0112-1/downstream-classes/zeres-0/bash/zernit.bashrc

###! Assertion wrapper that outputs message and exits with specified exit code
# NOTICE-DOCS(Krey): Make sure that the text is easy to follow from the exit code
###! Exit codes:
###! - 0/1 --- General true depending on kernel used
###! - 1/0 --- General false depending on kernel used
###! - 2 ----- syntax error
###! - 3 ----- permission issue
###! - 28 ---- Security trap
###! - 36 ---- Fixme trap
###! - 111 --- Invalid format string (used to capture printf failure)
###! - 126 --- not executable(?)
###! - 223 --- Unexpected trap captured for bug
###! - 255 --- Unexpected trap

# NOTICE(Krey): Aliases are required for posix-compatible line output (https://gist.github.com/Kreyren/4fc76d929efbea1bc874760e7f78c810)
# NOTICE(Krey): End-users are allowed to customize the format string so we have to capture printf failures using `|| { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}` instead of `die invalid-format`
# FIXME-DUP_CODE: Fix duplicate code for easier maintainance
die() { funcname="die"
	case "$2" in
		###! Generic true
		###! - Used to exit the shell successfully
		###! Compatibility: Returns Error code 0 on Unix and Error Code 1 on Windows
		"true")
			# In case no message is provided
			if [ -z "$3" ]; then
				if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
					case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*)
							"$PRINTF" "$DIE_FORMAT_STRING_TRUE" "Exitted successfully"
							"$PRINTF" "$DIE_FORMAT_STRING_TRUE" "Exitted successfully" >> "$logPath"
					esac
				elif [ "$DEBUG" = 1 ]; then
					case "$LANG" in
						en-*|*)
							# FIXME-TRANSLATE: Translate in your language
							"$PRINTF" "$DIE_FORMAT_STRING_TRUE_DEBUG" "Exitted successfully"
							"$PRINTF" "$DIE_FORMAT_STRING_TRUE_DEBUG" "Exitted successfully" >> "$logPath"
					esac
				else
					# NOTICE(Krey): Do not use die() in die for unexpected
					case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
					esac
				fi
			# Message on second argument is provided
			elif [ -n "$3" ]; then
				if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
					"$PRINTF" "$DIE_FORMAT_STRING_TRUE" "$3"
					"$PRINTF" "$DIE_FORMAT_STRING_TRUE" "$3" >> "$logPath"
				elif [ "$DEBUG" = 1 ]; then
					"$PRINTF" "$DIE_FORMAT_STRING_TRUE_DEBUG" "$3"
					"$PRINTF" "$DIE_FORMAT_STRING_TRUE_DEBUG" "$3" >> "$logPath"
				else
					# NOTICE(Krey): Do not use die() in die for unexpected
					case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
					esac
				fi
			fi

			# Assertion
			case "$KERNEL" in
				linux)
					unset funcname
					exit 0 ;;
				windows)
					unset funcname
					exit 1 ;;
				*)
					"$PRINTF" 'BUG: %s\n' "Invalid kernel has been provided in $myName for arguments '$*': $KERNEL"
					unset funcname
					exit 255
			esac
		;;
		###! Generic failure
		###! - Used to exit the shell with fatal error
		###! Compatibility: Returns Error code 1 on Unix and Error Code 0 on Windows
		"false")
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FALSE" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_FALSE_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FALSE_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_FALSE_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
					# FIXME-TRANSLATE: Translate in your language
					en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			# Assertion
			case "$KERNEL" in
				linux)
					unset funcname
					exit 1 ;;
				windows)
					unset funcname
					exit 0 ;;
				*)
					"$PRINTF" 'BUG: %s\n' "Invalid kernel has been provided in $myName: $KERNEL"
					unset funcname
					exit 223
			esac
		;;
		2|syntaxerr)
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_SYNTAXERR" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_SYNTAXERR_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_SYNTAXERR_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_SYNTAXERR_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 28 # In case 'fixme' argument is provided
		;;
		28|"security")
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_SECURITY" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_SECURITY_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_SECURITY_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_SECURITY_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 28 # In case 'fixme' argument is provided
		;;
		38|"fixme") # For features that needs to be implemented and prefents runtime from continuing
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_FIXME_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
						# FIXME-TRANSLATE: Translate in your language
						en-*|*) "$PRINTF" 'BUG: %s\n' "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 38 # In case 'fixme' argument is provided
		;;
		111|"invalid-format")
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
					# FIXME-TRANSLATE: Translate to more languages
					en-*|*) "$PRINTF" "$DIE_FORMAT_STRING" "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 223 # In case 'bug' is used
		;;
		223|"bug") # Unexpected trap
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_BUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_BUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_BUG_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_BUG_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
					# FIXME-TRANSLATE: Translate to more languages
					en-*|*) "$PRINTF" "$DIE_FORMAT_STRING" "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 223 # In case 'bug' is used
		;;
		255|"unexpected") # Unexpected trap
			if [ "$DEBUG" = 0 ] || [ -z "$DEBUG" ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			elif [ "$DEBUG" = 1 ]; then
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG" "$3" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
				"$PRINTF" "$DIE_FORMAT_STRING_UNEXPECTED_DEBUG_LOG" "$3" >> "$logPath" || { "$PRINTF" "$DIE_FORMAT_STRING_INVALID_FORMAT" "Invalid format string was parsed in $funcname calling argument '$2' with message '$3'"; exit 111 ;}
			else
				case "$LANG" in
					# FIXME-TRANSLATE: Translate to more languages
					en-*|*) "$PRINTF" "$DIE_FORMAT_STRING" "Unexpected happend while processing variable DEBUG with value '$DEBUG' in $funcname"
				esac
			fi

			unset funcname
			exit 255 # In case 'unexpected' is used
		;;
		*)
			case "$LANG" in
				# FIXME-TRANSLATE: Translate to more languages
				en-*|*) "$PRINTF" 'BUG: %s\n' "Invalid argument '$2' has been provided in $funcname"
			esac
			unset funcname
			exit 255
	esac
}; alias die='die "${LINENO:-0}"'
