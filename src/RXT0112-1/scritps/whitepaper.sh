#!/bin/sh
# shellcheck shell=sh # Made to be POSIX compatible

# Created by Jacob Hrbek <kreyren@rixotstudio.cz> under All Rights Reserved in 13/08/2020 22:55:24 CEST

###! Script to generate the whitepaper file for Zernit's project package manager

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
	PROJECT_NAME

	Preamble

	# Terminology

	# Core concept
	**Simplified:** Efficient way to create and manage a database that then is read from a downstream to be implemented in logic or used by the end-user (i.e in GUI)

	# Freedom of the affiliated parties
	**Simplified(i tried):** You can do whatever you want with the software as long as it doesn't destabilize our business plan or has a negative impact on project economy and doesn't cause permanent or unwanted (permission granted without the use of force or threat) temporary harm to any living life form capable of responding to the pain, having an educated opinion with the ability to argue about their point of view and reasoning using valid arguments based on their method of research unless it's used as a self-defense from conciscously and socially agreed unprovoked attack or to respond to the acts of god to preserve a specie of specified life form without reducing the quality of life of another to the unsustainable point.

	# Security
	**Simplified:** Overengineered as much as possible enigma machine approach without cryptographically guessable secred due to the wrong syntax that doesn't expect the real life usage which is from real life example using "Hail Hitler" prefix used to decrypt the message. Leaking of unwated informations and allowing unwanted parties from accessing the target system is also not acceptable.

	# Privacy
	Simplified: The end-user has to allow the software to use that information for that specific time of when it is needed else bug. These information is also expected to be stored securely without allowing unwanted parties from reading them.

	The end-users are in full control over the informations that they are providing to the zernit project which are required for the runtime that always has to be **opt-in** and never opt-out to ensure that we are not leaking unwanted informations especially for system with a threat model.

	# Transparency
	**Simplified:** This project is made to be as transparent as possible thus comunication with the project is expected to be kept public including legal documents.

	# Code quality
	FIXME-DOCS

	# Humanoid culture
	Planet Earth has around 7.8 Bilion humanoids (as of 14/08/2020) with diferent cultures that influence the law, ethiques and values of that specific group that is expected to be fully comformed in this project as preserving and respecting the culture is considered as critical in this project.

	This is designed to avoid amerikanism <https://en.wikipedia.org/wiki/Americanism_(ideology)> and similar unwanted behavior which has shown to be harmful for the relevant culture violating freedom directive above.
	- This issue was also highlighted in Rammstein's song "Amerika" <https://invidious.snopyta.org/watch?v=Rr8ljRgcJNM>.

	# Legality
	**Simplified:** FIXME-DOCS

	Everything in Computer Science can be abused for illegal activity (as defined by the law in relevant areas) which can not be legally endorsed by the project creators since that could result in project being banned in the relevant area or project creators being legally prosecuted for cases where we possibly woudn't have a strong legal defense.

	To preserve the freedom directive above project will provide a mandatory restriction flags depending on the location of end-user's IP adress where the end-users are not required to provide the IP adress to use the software since this value can be easily faked making our effort meaningless and unsuitable for privacy concious users that can't effort to share this information.

	Thus it was decided that the best approach is to provide a legal warnings to the end-users for situations alike where they have the option to choose their preffered approach at the cost of engaging in illegal activity in their area enforcable by the authorities.

	Authorities that proved their claim for the relevant juristiction are also given the absolute right to enforce the restrictions per area that they have provided a valid proof of authority that is ideally expected to be kept public in the repository to comfort the "Transparency" directive.

	Authorities are also expected to provide a reasoning for each restriction so that it can be peer-reviewd and tracked by qualified experts to ensure that their claim is valid. Providing these records publicly and reasoning for the restriction is not mandatory and depends on the culture from which the relevant law originated for example totalitarian countries are not expected to be required to provide the reasoning.

	# Education
	This project is expected to provide a free education allowing the general public to learn how to contribute and use the project and it's relevant parts alongside of basic and advanced concepts of computer science which includes programming languages and maintaining a welcoming community for humanoids who want to learn. This is expected to be provided for free as it's expected to be provided as contributing to the Free and Open-source movement while providing more qualified people to work on projects like ours.

	# Continous integration
	The ideology of CI in this project is to automate everything. Tasks that require human interfierence are considered as bug.

	# Continuous delivery/deployment
	We are expecting version and rolling release controlled software to the point of invidual patches without skipping any so that the project can be used for education where the rolling release is expected to be released every X time for users who prefer rolling release.
EOF
