#!/usr/bin/env bash
# This file has to be bash since we are using non-POSIX regex
	# Make it POSIX-compatible - using awk? perl?

# shellcheck source=src/slash-bedrock/lib/shell/common-code.sh
. /bedrock/lib/shell/common-code.sh

file="$1"
syntax_err="$2"

# Die if more then one argument has been parsed
[ -n "$syntax_err" ] && die 1 "Wrong argumnet '$syntax_err' has been parsed in 'shellizator.sh'"

# Shift arguments
while [ $# -gt 1 ]; do shift 1; done

# Convert ${var} -> $var where possible (https://regex101.com/r/J7vfQC/5)
sed -i -E 's:([\/\=\ \"\>\-]|^)(\$)\{([a-zA-Z0-9_]+)\}([\,\ \"\n\,\/\!\:\\\-\.]):\1\2\3\4:' "$file" || die 1 "Unable to convert '\${var}' to '\$var' in $file"

# Convert `if [ "${TRAVIS_OS_NAME}" == "linux" -a "${DOCKER}" == "" -a "${QEMU}" == "" ] ; then` in `if [ "${TRAVIS_OS_NAME}" == "linux" ] && [ "${DOCKER}" == "" ] && [ "${QEMU}" == "" ] ; then`

fixme "Implement shellizator if fixing"

# Remove unnecesary spaces in if statements after the `]` and before 'then' (https://regex101.com/r/XhNCZd/1)
sed -i -E 's:(if[^;]+)\s(\;\sthen):\1\2:gm' "$file" || die 1 "Unable to remove unnecesary spaces in if statements"
