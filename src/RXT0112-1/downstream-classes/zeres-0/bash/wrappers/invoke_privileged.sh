#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 08.07.2020 03:32:02 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Specify somewhere
# shellcheck source=src/downstream-classes/zeres-0/bash/UNLEASH.sh

###! Sanitized wrapper to create a directory

# Root elevation on-demand
# SYNOPSIS: rootme [reason for privileged access] [command]
# FIXME-QA: Needs better implementation
invoke_privileged() { funcname="invoke_privileged"

	if [ "$privileged" = "false" ]; then
		die fixme "Implement $funcname to execute '$2' as privileged user, invoke this script as root as a workaround"

		edebug "Script '$myName' has been executed from an unprivileged user, deducing possible elevation"

		# Ask for permission to execute the command
		"$PRINTF" "$INVOKE_PRIVILEGED_FORMAT_STRING_QUESTION" "$1"

		while true; do
			"$PRINTF" '%s\n' "Requesting permission to invoke '$2' as privileged user (y/n)"
			read -r privilege_granted

			case "$privilege_granted" in
				"Y"|"y"|"YES"|"yes")
					edebug "User granted permission to invoke '$2' as privileged user"
					unset privilege_granted
					break
				;;
				"N"|"n"|"NO"|"no")
					die 3 "Unable to execute '$2' as privileged user"
				;;
				*) "$PRINTF" '%s\n' "Input '$privilege_granted' is not recognized, try again.."
			esac
		done

		# Check what we can use for executing command as privileged user
		unset privilege_commands

		# FIXME-QA: Fix duplicate code

		## Check for sudo
		if command -v "$SUDO" 1>/dev/null; then
			privilege_commands="$privilege_commands sudo"
		elif ! command -v "$SUDO" 1>/dev/null; then
			edebug "Command '$SUDO' is not executable in $funcname, unable to use it"
		else
			die bug "checking wether command sudo is executable in $funcname"
		fi

		## Check for su
		if command -v "$SU" 1>/dev/null; then
			privilege_commands="$privilege_commands su"
		elif ! command -v "$SU" 1>/dev/null; then
			edebug "Command '$SU' is not executable in $funcname, unable to use it"
		else
			die bug "checking wether command su is executable in $funcname"
		fi

		case "$("$PRINTF" '%s\n' "$privilege_commands" | tr ' ' '\n' | wc -l)" in
			0) die 3 "Neither of supported commands used to invoke command as privileged user '$privilege_commands' are available on this system, unable to invoke '$2'" ;;
			1)
				cmd_count="$("$PRINTF" '%s\n' "$privilege_commands" | sed "s/ //gm")"
				case "$cmd_count" in
					"sudo")
						while true; do
							printf '%s\n' "Requesting permission to use '${SUDO:-sudo}' for invokation of '$2' (y/n)"
							read -r allowed_to_use_sudo

							case "$allowed_to_use_sudo" in
								"Y"|"y"|"YES"|"yes")
									sudo "$2" | die 3 "Unable to execute '$2' with privileged permission"
									break
								;;
								"N"|"n"|"NO"|"no")
									die 3 "Unable to execute '$2' with privileged permission using sudo, because we were not allowed to proceed"
								;;
								*)
									"$PRINTF" '%s\n' "Input '$allowed_to_use_sudo' is not recognized, retrying.."
									unset allowed_to_use_sudo
							esac
						done
					;;
					"su")
						while true; do
							printf '%s\n' "Requesting permission to use '${SUDO:-sudo}' for invokation of '$2' (y/n)"
							read -r allowed_to_use_sudo

							case "$allowed_to_use_sudo" in
								"Y"|"y"|"YES"|"yes")
									su root -c "$2" | die 3 "Unable to execute '$2' with privileged permission"
									break
								;;
								"N"|"n"|"NO"|"no")
									die 3 "Unable to execute '$2' with privileged permission using sudo, because we were not allowed to proceed"
								;;
								*)
									"$PRINTF" '%s\n' "Input '$allowed_to_use_sudo' is not recognized, retrying.."
									unset allowed_to_use_sudo
							esac
						done
					;;
				esac ;;
			2)
				# NOTICE: This is adapted to allow more commands in the future
				while true; do
					printf '%s\n\n' \
						"We found following commands that we can use to execute the command as privileged user:"

						# FIXME: seq might not be available on the system
						# - yes | head -n 3| nl | cut -f1 | while read i; do echo $i; done
						# - awk 'BEGIN{for(i=0;i<10;i++)print i}
						for num in $(seq 1 "$cmd_count" | tr '\n' ' '); do
							for cmd in $privilege_commands; do
									printf "%s\n" "$num. $cmd"
							done

							printf '%s\n' ""

							printf '%s\n' "Which command do you want to use?"
						done

						read -r privilege_choice

						case "$privilege_choice" in
							[1-2])
								die fixme "Choose the appropriate choice, invoke this script as privileged user as a workaround"
								break
							;;
							*)
								printf '%s\n' "Invalid choice '$privilege_choice', retrying.."
								unset privilege_choice
 						esac
				done

				# DNM: Implement proper logic
				efixme "Implement better logic here, invoking 'sudo' for testing.."

				sudo "$2" || die 3 "unable to use privileged permission" ;;
			*)
				# FIXME-QA: Implement better output
				die bug "Unexpected value has been returned for variable 'privilege_commands'"
		esac

	elif [ "$privileged" = "true" ]; then
		edebug "Executing '$1' as privileged user"
		unset funcname
		return 0

	fi
}
