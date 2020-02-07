# FIXME: in-code docs needed

# FIXME: Windows doesn't support makefiles natively -> if you have a better method then please MR it or make an issue

## Syntax capture ##

all:
	@ printf '%s\n' "Unknown option '$1' parsed in target all"
	@ exit 2

## BUILD ##
# All build targets are expected in 'build/build-LANG' where 'LANG' is the unique identifier of the language used

# FIXME: Build in '$repodir/build/build-rustlang' instead of '$repodir/target' for multilang support
build-rustlang:
	@ cargo build

# FIXME: Replace 'exit 1' with helpful messages
build-gcc:
	@ # Make a build directory
	@ [ ! -d build ] && { mkdir build || exit 1 ;}
	@ [ ! -d build/target-gcc ] && { mkdir build/build-gcc || exit 1 ;}

	@ # Compilation
	@ [ ! -f build/build-gcc ] && { gcc src/bin/main.c -o build/build-gcc/gcc-zernit || exit 1 ;}
	@ printf '%s\n' "Compilation of target for gcc finished"

build-clang:
	@ printf 'FIXME: %s\n' "translate zernit in clang"
	@ exit 1

build-brainfuck:
	@ printf 'FIXME: %s\n' "translate zernit in brainfuck"
	@ exit 1

# FIXME: requires python3.6+ and pip3
build-python:
	@ pip3 install -r requirements.txt

## CLEAN ##

clean:
	@ [ -d build ] && { rm -r build || exit 1 ;}
	@ printf '%s\n' "Build directory has been cleaned"