#!/bin/sh
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'before-install' from rsplib	(https://raw.githubusercontent.com/dreibh/rsplib/master/ci/before-install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

# NOT_PRODUCTION_READY
printf 'WARN: %s\n' "This file is not production ready, USE ON YOUR OWN RISK!"

# Get output messages
. QA/tests/HELL/backend/output.sh

# Get Variables
. QA/tests/HELL/backend/get-variables.sh

# Configure backend
. QA/tests/HELL/backend/configure_backend.sh