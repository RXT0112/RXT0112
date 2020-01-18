# FIXME: in-code docs needed

all:
	@ printf '%s\n' "Unknown option parsed in target all" ; exit 2

## DEVELOPMENT ##

run:
	@ cargo run \
		--jobs "$$(nproc)" \
		--bin main \
		-- "$*"

build:
	@ cargo build \
		--jobs "$$(nproc)" \
		--target-dir "target"
		# --manifest-path="$$(pwd)/src/Cargo.toml"

## RELEASE ## 

release:
	@ printf '%s\n' "FIXME: Release logic needed" ; exit 1

## EXPERIMENTS ##

experiment:
	@ cargo run \
		--bin main-experiment \
		--jobs "$$(nproc)" \
		-- debug