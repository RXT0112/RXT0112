#!/bin/false
# - Used only for sourcing
#@ Concept created by Jacob Hrbek <kreyren@rixotstudio.cz> under All rights reserved in 03.03.2020
#@ - Temporary set as proprietary until custom four freedom respecting license is finished

# shellcheck shell=sh # Written to be POSIX-compatible

# Function to return a json database of this package
zernit_json() {
	cat <<-EOF > somewhere?
		"package": {
			"name": "$PN",
			"description": "...",
			"conflicts": {
				"some/package:slot::origin[=version]" {
					"reasoning:" "example reasoning"
				}
				# FIXME: What if this conflicts with an option?
				"option": "A" {
					reasoning: "some reasoning to why option A is not expected on this package"
				}
			}
		}
	EOF
}

# Trigger zernit backend to resolve metadata and dependencies
## - Without this zernit will just run this as a script with option to use it's backend on demand
zernit_init

# Used to source a library
# FIXME: We need some way to export specific parts of the library
## NOTICE: Paludis is using `require djvu scm-git autotools [ supported_autoconf=[ 2.5 ] supported_automake=[ 1.13 ] ]`
require someLibrary

phase_call src_metadata

phase_call src_fetch

phase_call src_configure

my_phase() {
	i do something cool
}; my_phase

phase_call src_compile

phase_call src_merge

# FIXME: Add method to create something like 'snap' or 'appimage' that can then be just exported on any system to use the software from a sandboxed environment

maintainer_note \
	"I just wanted to say something important after the package has been merged in the system" \
	"There is a rare bug in version 1.1.1 which might break processing png files, reproduction of the issue provided in url/to/tracking are welcomed!" \
	"Glad to waste your time!"
