#!/bin/sh
# shellcheck shell=sh # Made to be POSIX compatible

# Created by Jacob Hrbek <kreyren@rixotstudio.cz> under All Rights Reserved in 13/08/2020 22:55:24 CEST

###! Script to generate the readme file for Zernit's project package manager

# FIXME: We need a name (https://github.com/RXT0112/Zernit/issues/156)
projectName="UPM" # Unnamed Package Manager (WIP NAME)

readmePath="src/RXT0112-1/README.md"
whitepaperPath="src/RXT0112-1/WHITEPAPER.md"

# Make sure to not confuse the windows users
case "$KERNEL" in
	"windows") fileGroup="folder" ;;
	*) fileGroup="directory"
esac

# Generate the readme file
"$CAT" <<-EOF > "$readmePath"
	NOTICE: This README file is basically a huge ad designed to waste your time and hype you into liking this project. If you want to know how this software works then see the white paper located at $whitepaperPath.

	# $projectName

	$projectName is a package manager designed to work on all hardware capable of running our programming logic with the intention of as efficient as theoretically possible management of the target hardware while providing reliable downstream methods to enhance the functionality for mission critical tasks where the end-user has full control over the informations that they are providing for this runtime which includes the ability to see and change the source code.

	### User-friendly
	If this project is not capable of installing and uninstalling inself on target system without restoring the system into the original state using an intuitive and painless installation process that can be done by the general public then it's considered a bug.

	Please file a new issue to $MAINTAINER_REPOSITORY if you encounter any (including minor) problems during these tasks

	### Efficiency
	This project is designed to have simplified abstract as much as possible to allow it to be rewritten into other programming languages allowing it to be compiled based on the benchmarks conducted on the target system to ensure best possible efficiency with extensive code quality assurance to make it suitable for mission critical tasks.

	### Code Quality
	WIP

	### Privacy
	Designed to provide the full control
EOF
