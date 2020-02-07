#!/bin/bash

printf '%s\n' "ping"

# Argument management
while [ $# -ge 1 ]; do case $1 in 
    --help|-h|help)
        fixme "Help message here"
        shift 1
    ;;
    *)
        die 2 "FIXME: Syntax error"
esac; done