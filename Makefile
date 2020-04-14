# FIXME: in-code docs needed

# FIXME: Windows doesn't support makefiles natively -> if you have a better method then please MR it or make an issue

## Syntax capture ##

all:
	@ printf '%s\n' "Unknown option '$1' parsed in target all"
	@ exit 2

## BUILD ##
# All build targets are expected in 'build/build-LANG' where 'LANG' is the unique identifier of the language used
# FIXME: Replace 'exit 1' with helpful messages

build: build-rustlang build-clang-c build-gcc-c build-gcc-ccp build-clang build-brainfuck build-python build-vlang build-golang
	@ printf 'WARN: %s\n' "You are abould to build all targets on multilang project"

# FIXME: Build in '$repodir/build/build-rustlang' instead of '$repodir/target' for multilang support
build-rustlang:
	@ cargo build --verbose

# FIXME: Add logic
build-clang-c:
	@ # Make a build directory
	@ [ ! -d build ] && { mkdir build || exit 1 ;} || exit 0
	@ [ ! -d build/build-clang-c ] && { mkdir build/build-clang-c || exit 1 ;} || exit 0

	@ # Compilation
	@ [ ! -f build/build-clang-c/zernit-clang-c ] && { clang src/bin/main.c -o build/build-clang-c/zernit-clang-c || exit 1 ;} || exit 0
	@ printf '%s\n' "Compilation of target for clang-c finished"

build-gcc-c:
	@ # Make a build directory
	@ [ ! -d build ] && { mkdir build || exit 1 ;} || exit 0
	@ [ ! -d build/target-gcc-c ] && { mkdir build/build-gcc-c || exit 1 ;} || exit 0

	@ # Compilation
	@ [ ! -f build/build-gcc-c/zernit-gcc-c ] && { gcc src/bin/main.c -o build/build-gcc-c/zernit-gcc-c || exit 1 ;} || exit 0
	@ printf '%s\n' "Compilation of target for gcc-c finished"

# FIXME: Replace 'exit 1' with helpful messages
build-gcc-ccp:
	@ # Make a build directory
	@ [ ! -d build ] && { mkdir build || exit 1 ;}
	@ [ ! -d build/target-gcc ] && { mkdir build/build-gcc || exit 1 ;}

	@ # Compilation
	@ [ ! -f build/build-gcc ] && { gcc src/bin/main.c -o build/build-gcc/gcc-zernit || exit 1 ;}
	@ printf '%s\n' "Compilation of target for gcc finished"

build-clang-ccp:
	@ printf 'FIXME: %s\n' "translate zernit in clang"
	@ exit 1

build-brainfuck:
	@ printf 'FIXME: %s\n' "translate zernit in brainfuck"
	@ exit 1

# FIXME: requires python3.6+ and pip3
build-python:
	@ pip3 install -r requirements.txt

build-vlang:
	@ [ ! -d build ] && mkdir build
	@ [ ! -d build/build-vlang ] && mkdir build/build-vlang
	@ /opt/vlang/v -o build/build-vlang/zernit-vlang src/bin/main.v

build-golang:
	@ [ ! -d build ] && mkdir build
	@ [ ! -d build/build-golang ] && mkdir build/build-golang
	@ go build -o build/build-golang/zernit-golang src/bin/main.go

build-golang:
	@ [ ! -d build ] && mkdir build
	@ [ ! -d build/build-nim ] && mkdir build/build-nim
	@ nim c -r -o build/build-nim/zernit-nim src/bin/main.nim
## CHECK/TESTS ##

check:
	@ printf 'FIXME: %s\n' "Check all targets if executed"
	@ exit 1

check-gcc-c:
	@ printf 'FIXME: %s\n' "Add tests for gc"
	@ exit 1

check-clang-c:
	@ printf 'FIXME: %s\n' "Add tests for gcc"
	@ exit 1

check-gcc-ccp:
	@ printf 'FIXME: %s\n' "Add tests for clang"
	@ exit 1

check-python:
	@ printf 'FIXME: %s\n' "Add tests for python"
	@ exit 1

check-rustlang:
	@ printf 'FIXME: %s\n' "Add tests for rustlang"
	@ exit 1

check-brainfuck:
	@ printf 'FIXME: %s\n' "Add tests for brainfuck"
	@ exit 1

check-shell:
	@ printf 'FIXME: %s\n' "Add tests for shell"
	@ exit 1

check-bash:
	@ printf 'FIXME: %s\n' "Add tests for bash"
	@ exit 1

check-vlang:
	@ printf 'FIXME: %s\n' "Add tests for vlang"
	@ exit 1

check-nim:
	@ printf 'FIXME: %s\n' "Add tests for nim"
	@ exit 1
	
## BENCHES ##

# FIXME: Run all benches if this is executed
bench: bench-rustlang

# FIXME: Run vendor and 
bench-rustlang:
	@ cargo bench

## CLEAN ##

clean: clean-vendor clean-benches
	@ [ -d build ] && { rm -rf build || exit 1 ;} || exit 0
	@ printf '%s\n' "Build directory has been cleaned"

clean-vendor:
	@ # FIXME: Output helpful message if directory doesn't exists
	@ [ -d vendor ] && { rm -rf vendor || exit 1 ;} || exit 0