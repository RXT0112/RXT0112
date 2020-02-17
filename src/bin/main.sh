#!/bin/sh

# Source kreypi's output functions
for libs in src/libs/shell/kreypi/output/*; do
	. "src/libs/shell/kreypi/output/$libs"
done

# Source assertion function
. src/libs/shell/kreypi/terminators/die.sh

subcomdir="src/subcoms/shell/"

# Argument management
## NOTICE: This is used to source arguments based on filenames in subcomdir
efixme "Check security of argument management"
code=':'
for file in "$subcomdir/*"; do
	[ ! -f "$file" ] && die 1 "Unable to find a file '$file' in $subcomdir "
	# To avoid code injection
	case $file in *[![:alnum:]]*)
		die 1 "CODE_INJECTION_WARNING: Unsafe name encountered - $file" ;;
	esac
	code="$code | \"$file\""
done
eval "$code"

# LEGACY: Remove me once ready
# while [ $# -ge 1 ]; do case "$1" in 
# 	--help|-h|help)
# 		efixme "Help message here"
# 		shift 1
# 	;;
# 	command1 | command2 | command3 | command4)
# 		something ;;
# 	$(for file in src/subcoms/shell/*; do printf '%s\n' "$file | "; done)X)
# 		efixme "Provide logic to execute subcommands" ;;
# 	*)
# 		die 2 "FIXME: Syntax error"
# esac; done