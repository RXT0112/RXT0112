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
		--bin main \ 
		-- "$*"

## RELEASE ## 

release:
	@ printf '%s\n' "FIXME: Release logic needed, currently unknown usecase" ; exit 1

## EXPERIMENTS ##

experiment:
	@ cargo run \
		--jobs "$$(nproc)" \
		--bin main-experiment \
		-- "$*"