#!/bin/sh

printf '%s\n' "ping"

# Simplified assertion
die() {
	printf 'FATAL: %s\n' "$2"
	exit "$1"
}

fixme() {
	[ -z "$IGNORE_FIXME" ] && printf 'FIXME: %s\n' "$1"
}

# Argument management
while [ $# -ge 1 ]; do case $1 in 
	--help|-h|help)
		fixme "Help message here"
		shift 1
	;;
	*)
		die 2 "FIXME: Syntax error"
esac; done