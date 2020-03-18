#!/bin/sh
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'before-install' from rsplib	(https://raw.githubusercontent.com/dreibh/rsplib/master/ci/before-install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

# Get KERNEL Variable
if [ -z "$KERNEL"]; then
    case "$(uname -s)" in 
        Linux) KERNEL=linux ;;
        Darwin KERNEL=darwin ;;
        *) die 255 "Unsupported output of 'uname -s' has been parsed - $(uname -s)"
    esac
elif [ -n "$KERNEL"]; then
    warn "Variable 'KERNEL' is overwritten on '$KERNEL'"
else
    die 255 "Getting KERNEL variable"
fi