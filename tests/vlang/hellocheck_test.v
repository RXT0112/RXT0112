// Blocked by https://github.com/vlang/v/issues/3674

module main

fn hellocheck() {
	if hello != "Hello World" {
		exit 1
	}
}