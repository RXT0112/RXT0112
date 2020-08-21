#!/bin/false
# - Used only for sourcing
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> as All Rights Reserved in 18/08/2020 08:13:35 CET
# Peer-reviewed by <NAME> <EMAIL> in <DATE> <TIME> <TIMEZONE>

# shellcheck shell=sh # Written to be posix-compatible
# DNM: Make sure this works
# shellcheck source=src/RXT0112-1/downstream-classes/zeres-0/bash/zernit.bashrc

###! Identifier script used to identify a hostname on the target system and store it in 'HOSTNAME' environment variable

# Define hostname
# POSIX: Variable 'HOSTNAME' is not defined on POSIX sh
if command -v hostname 1>/dev/null; then
	HOSTNAME="$(hostname)"
elif [ -s /etc/hostname ]; then
	HOSTNAME="$("$CAT" /etc/hostname)"
elif ! command -v hostname 1>/dev/null && [ ! -s /etc/hostname ]; then
	die false "Unable to determine the hostname from command 'hostname' (which doesn't exists) and from file /etc/hostname (that doesn't exists or is blank)"
else
	die unexpected "processing hostname"
fi
