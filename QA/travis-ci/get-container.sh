#!/bin/sh
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'before-install' from rsplib	(https://raw.githubusercontent.com/dreibh/rsplib/master/ci/before-install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

# shellcheck source=QA/travis-ci/travis-common.sh
. "$(dirname "$0")/travis-common.sh"

if [ -n "$DOCKER" ]; then

	# Check configuration
	if [ -z "$VARIANT" ] ; then
		die "Variable VARIANT is not set"
	fi
	if [ -z "$TOOL" ] ; then
		die "Variable TOOL is not set"
	fi

	# Get name of package
	PACKAGE="Kreyrock"

	# Set container name
	CONTAINER=$(printf '%s\n' "$PACKAGE-$DOCKER-$TOOL" | sed -e "s/:/_/g")
	if [ -n "$COMPILER_C" ]; then
		CONTAINER="$CONTAINER-$COMPILER_C"
	fi
	export CONTAINER

else
	info "Docker is not used"
	unset CONTAINER
fi
