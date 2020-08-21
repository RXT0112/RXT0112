#!/usr/bin/zernit sh
# Created by Jacob Hrbek <kreyren@rixotstudio,cz> under all rights reserved in 11/08/2020 01:02:33 CEST

# shellcheck shell=sh # Written to be POSIX compatible

###! Script designed to generate the white paper for this project in supported language
###! The whitepaper should be done to be understandable by the general public so avoid over-complication where possible.

[ -n "$whitepaperPath" ] || whitepaperPath="README.md"

# FIXME: Implement logic to deduce this
UPSTREAM_NAME="Zernit"

sectionNumber=0

# Exit on anything unexpected to capture code quality issues
set -x

# Wipe the current whipaper
"$PRINTF" '%s\n' "" > "$whitepaperPath"

# Title
case "$LANG" in
	*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			<h1 align="center">
				<a href=$UPSTREAM_REPOSITORY>$PROJECT_NAME</a>
			</h1>
		EOF
esac

# Preamble
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			$PROJECT_NAME is a system-manager designed to make devices capable of running our written logic painless and efficient while maintaining highest possible code quality standard and platform compatibility.

			This whitepaper is not legally bindable and is provided to be used as a reference for the software development and comunity management.

			If you find a conflicting part in the source code, then file a new tracking in $UPSTREAM_REPOSITORY and we will process it with relevant priority to ensure that these conditions are met as soon as possible or brainstorm it for this whitepaper to be updated.

			Contributions to this whitepaper and suggestions are appreciated to influece the relevant software development.
		EOF
esac

# Terminology
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			## $(( sectionNumber + 1 )). Terminology
			Software Users (SU) -- Parties that are using this software or are in other way affiliated with it or it's development
		EOF
esac

# Ethicality
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			## $(( sectionNumber + 1 )). Project ethiques
			FIXME-DOCS
		EOF
esac

# Privacy
# FIXME: Add logic for the sub number
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			### $sectionNumber.1 Privacy
			This project is designed to provide the absolute anonimity without compromise for it's SU unless relevant juristiction forces it to require informations of relevant parties in the area where said juristiction has the rightful authority to enforce these information processing that would otherwise make the usage of this software illegal in that area.

			Data of SU should never be processed without an explicit permission that has to be opted-in and NEVER set by default at the cost of software malfunction (that should be sanitized to avoid fatal failure) where SU should never be prevented from using this software just because they don't want to provide their personal information.

			Functions that explicitely require personal information should fail safely if said information is not provided or use a default value allowing the SU to blend into a crowd of anonymous users.

			From experience with Enoch-based distributions alike Gentoo Linux as explained on hyperlink https://wiki.gentoo.org/wiki/User:MGorny/GCO_real_name_requirement it's required to provide an indentification to be allowed to submit changes to the source code.
			This should never be limited on this project where possible and SU should have the option to submit their contribution under project's name (with their nickname if desired) if they don't want to or can't affort sharing this kind of information assuming that the contribution doesn't break the legal cleanroom and does not have a copyright which would make it impossible to be used in judistical areas that honors copyright law.
		EOF
esac

# Freedom
# FIXME: Add logic for the sub number
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			### $sectionNumber.1 Freedom of relevant parties
			This project is designed to give it's SU the full freedom of doing whatever they want with the software and most importantly with it's source code as long as it doesn't have a negative impact on the business plan with some flexibility from the Software Authorities.

			This solution is not ideal, but it's the best that we currently have, proposals for a better solution are appreciated.

			The license should contain 'Four Freedom Compilance' that should be maintained over time to ensure that the license complies with four essential freedoms of Free Software defined by Free Software Foundation as explained in https://en.wikipedia.org/wiki/The_Free_Software_Definition#The_Four_Essential_Freedoms_of_Free_Software

			It's important to mension that this project can be abused for an illegal activity as a result of provided freedom above that the project has legal obligation to enforce per local juristiction of the user assuming that the user chosed to provide it's locality where these laws applies. Thus users that chosed to not provide their location should be warned about this risk as they can be legally prosecuted by the relevant juristiction for which zernit is not responsible.
		EOF
esac

# Software Design
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			## $(( sectionNumber + 1 )). Software Design
			The software is designed to work everywhere possible to be deployed painlessly to manage the target device as efficiently as possible.
		EOF
esac

## Cross-platform
case "$LANG" in
	en-*|*)
		"$CAT" <<-EOF >> "$whitepaperPath"
			## $(( sectionNumber + 1 )).1 Cross-platform support
			FIXME: Decide
		EOF
esac

# FIXME: The backend is currently undetermined
## Downstream
"$CAT" <<-EOF >> "$whitepaperPath"
	Zernit is designed to make it efficient for it's SU to implement their own package downstream and make it available for everyone if desired.

	Zernit creators are providing their own downstream with work in progress name \`zeres-0\` that is designed to provide system to process source code while giving the SU all available options to efficiently alter the build result

	This downstream management is designed to provide tools that may be useful for package processing, but none of them are mandatory meaning that if desired you can run a blank file and zernit won't stop you.
	To ensure the expected runtime this is expected to be enforced through provided standard per downstream repository.

	## List of downstream items
	Zeres-0 devices it's downstream into a \`downstream items\` each of which is designed to process diferent product.

	### Packages
	Used to process various source code into a package that can be imported on the target system/sandbox.

	This downstream item is designed to either process the source code of the software into a package that then can be imported on the system or using pre-built binary with static options made to work on majority of devices.

	In terms of database this requires following entries:
	- Package Name
	- Package Category
	- Package Version
	- Package Slot
	And optionally:
	- Homepage
	- Upstream repository URL
	- Upstream name
	- Upstream organization
	- License
	- And anything relevant which the SU can cherrypick per system

	Each package is processed through phases that are designed to each process specific part of the package where the developers have the option to specify which phases will be used to process the package meaning than none of these are mandatory at the cost of software malfunction:
	- Fetch
		Fetch the source code in the specified destination for processing

	- Checksum check
		Designed to check the checksum of fetched files that can be (if desired):
		1. Checked agains virustotal database
		2. Checked agains provided checksum by downstream to ensure that expected file is fetched for processing

	- Cache
		Designed to cache the source code tarball for processing

		SU has options to:
			1. Cache the tarball so if the tarball is needed zernit can get this file locally
			2. Provide this file as standalone mirror that can be added to the downstream
			3. Provide this file through torrent for peer-2-peer distribution
			4. Provide this file through custom torrent-inspired distribution system focused on privacy and security

	- Configure
		Designed to configure the source code for proccessing in the \`compile\` phase

	- Compile
		Designed to provide backend required to process the package for compilation

	- Sandbox
		Designed to place the runtime in a jail that prevents the software from accessing the live userland.

	- Containerize
		Designed to place the content of \`IMAGE\` directory into a redistributable container that runs on the target system without the need for dependencies

		To ensure compatibility this has to have a logic to determine wether it's being run on a supported system.

		This can be also used for release of pre-compiled targets

	- Merge
		Merge the content of \`IMAGE\` directory into a live system

	### Audio
	Designed for distribution of audio tracks

	In terms of database this requires following entries:
	- Artist name
	- Song name
	And optionally:
	- License
EOF
