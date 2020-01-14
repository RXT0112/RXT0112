use clap::{Arg, App, SubCommand};

fn main() {
	//  Capture arguments (https://docs.rs/clap/2.33.0/clap/)
	let matches = App::new("RXT0112")
		.version("0.0.0")
		.author("Jacob Hrbek <kreyren@rixotstudio.cz>")
		.about("Work in progress package manager")
	.get_matches();
}