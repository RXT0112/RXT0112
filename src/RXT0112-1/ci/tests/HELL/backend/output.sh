#!/bin/sh
# Copyright 2019 Jacob Hrbek <kreyren@rixotstudio.cz>
# Distributed under the terms of the GNU General Public License v3 (https://www.gnu.org/licenses/gpl-3.0.en.html) or later
# Based in part upon 'before-install' from rsplib	(https://raw.githubusercontent.com/dreibh/rsplib/master/ci/before-install), which is:
# 		Copyright (C) 2018-2019 by Thomas Dreibholz <dreibh@iem.uni-due.de> as GPLv3 or any other GPL at your option

: '
    This file is used for sourcing

    Used for output of various messages
        - die         Outputs a message and exits
        - warn        Output a warning
        - info        Output info
'

# Outputs a message and exits
# SYNOPSIS: die [num] (message)
die() {
    err_code="$1"
    message="$2"

    case "$err_code" in
        0) true ;;
        1)
            if [ -z "$message" ]; then
                case $LANG in
                    en*) printf 'FATAL: %s\n' "Script returned true" ;;
                    # Do not transtale, default message
                    *) printf 'FATAL: %s\n' "Script returned true"
                esac
            elif [ -n "$message" ]; then
                case $LANG in
                    en*) printf 'FATAL: %s\n' "$mesage" ;;
                    # Do not transtale, default message
                    *) printf 'FATAL: %s\n' "$message"
                esac
            else
                printf 'FATAL: %s\n' "Unexpected happend in die 1"
                exit 255
            fi
            exit $err_code
        ;;
        3)
            # FIXME: Implement translate
            # FIXME: Implement message handling
            printf 'FATAL: %s\n' "This script is expected to be invoked as root"
        ;;
        255)
            # FIXME: Implement translate
            # FIXME: Implement output for blank $message

            printf 'FATAL: %s\n' "Unexpected happend in $message"
            exit $err_code
        ;;
        fixme)
            # FIXME: Translate
            # FIXME: Handle scenarios where message is not parsed
            printf 'FIXME: $s\n' "$message"
        ;;
        *) printf 'FATAL: %s\n' "Unexpected argument '$err_code' has been parsed in 'die()'" ; exit 255
    esac

    unset err_code message
}

warn() { printf 'WARN: %s\n' "$1" ;}
info() { printf 'INFO: %s\n' "$1" ;}
fixme() {
    case $1 in
        *) printf 'FIXME: %s\n' "$2"
    esac
}