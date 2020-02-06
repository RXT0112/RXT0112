#!/bin/sh
# Simplified error handling
die() {
	printf 'FATAL: %s\n' "$*"
	exit 1
}
# Simplified QA handling
fixme() {
	printf 'FIXME: %s/n' "$*"
}
# Simplified info messages
info() {
	printf 'INFO: %s\n' "$*"
}
warn() {
    printf 'WARN: %s\n' "$*"
}