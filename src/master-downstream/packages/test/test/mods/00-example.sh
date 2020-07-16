# Concept created by Jacob Hrbek <kreyren@rixotstudio.cz> under All rights reserved in 03.03.2020
# - Temporary set as proprietary until custom four freedom respecting license is finished

###! This is a concept for various non-upstream or not directly upstream modifications added to the package

---
# Comment
NAME: something
# FIXME: Implement built-in cap for lenght
SUMMARY: Short summary
Description: does something
# Used to display thumbnail in the GUI/TUI(?)
THUMBNAIL:
	64x64: path/to/image -or- https://some.url
	128x128: path/to/image -or- https://some.url
HOMEPAGE: www.somewhere.something
LICENSE: something
# FIXME: This is not a good implementation
DEPENDENCIES:
	some/dependency:0::origin[>=1.0.0]
		description: something
	either-of-these
		some/dependency:0::origin[=1.0.0]
		some/other-dependency:0::origin[=1.0.0]
# FIXME: This is not a good implementation
OPTIONS:
	# Compiler
	exactly-one
		gcc:
			description: Compile using gcc
		clang:
			description: Compile using clang
	# LibC
	exactly-one
		libc:
			description: Compile with libc
		musl:
			description: Compile with musl
# For tested shell version used to process this file, used to capture changes made by upstream that might break our runtime
# FIXME: Cause a fatal error if the downstream wasn't tested on this version
#  - FIXME: Allow this being skipped in configuration
#  - FIXME: We should implement a method
SHELL_COMPAT:
	1.1.0:
		Tested-by: Some One <email>
---

# Trigger zernit backend to resolve metadata and dependencies
## - Without this zernit will just run this as a script with option to use it's backend on demand
zernit_init

# Used to source a library
# FIXME: We need some way to export specific parts of the library
## NOTICE: Paludis is using `require djvu scm-git autotools [ supported_autoconf=[ 2.5 ] supported_automake=[ 1.13 ] ]`
require someLibrary

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
