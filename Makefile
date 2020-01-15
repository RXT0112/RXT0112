all:
	@ printf '%s\n' "Unknown option parsed in target all" ; exit 2

run:
	@ cargo run \
		--jobs "$$(nproc)" \
		--target-dir target \
		--manifest-path="$$(pwd)/src/Cargo.toml"

experiment:
	@ cargo run "src/experiment.rs" \
		--jobs "$$(nproc)" \
		--target-dir target \
		--manifest-path="$$(pwd)/src/Cargo.toml"

build:
	@ cargo build \
		--jobs "$$(nproc)" \
		--target-dir target \
		--manifest-path="$$(pwd)/src/Cargo.toml"

release:
	@ printf '%s\n' "FIXME: Release logic needed" ; exit 1