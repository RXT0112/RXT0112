#!/bin/sh
# Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPLv3 <https://www.gnu.org/licenses/gpl-3.0.en.html> in 19/05/2020 16:28

###! Terminate gitpod if the blocking root access bug has not been resolved yet

set -e

bugStatus="$(curl https://api.github.com/repos/gitpod-io/gitpod/issues/1265 2>/dev/null | grep -o state.*)"

case "$bugStatus" in
	"state\": \"open\",")
		printf '\033[31m\033[1mBLOCKED:\033[0m %s\n' "Gitpod does not provide a VM support which blocks cross-platform development, see tracking on https://github.com/gitpod-io/gitpod/issues/1265"
		if [ "$GITPOD_IGNORE_BLOCKERS" != 1 ]; then exit 1; else true ;fi
	;;
	"state\": \"closed\",")
		true
	;;
	*)
		printf '\033[31m\033[1mBUG:\033[0m %s\n' "GitHub API returned an unknown state '$bugStatus' of bug https://github.com/gitpod-io/gitpod/issues/1265"
		exit 1
esac