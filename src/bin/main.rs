// Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPL-3 license (https://www.gnu.org/licenses/gpl-3.0.en.html) in 2020

// Library used for cli argument management
extern crate clap;
use clap::{Arg, App, SubCommand};

extern crate kreypi;

fn main() {
	// Capture arguments (https://docs.rs/clap/2.33.0/clap/)
	let matches = App::new("RXT0112")
		.version("0.0.0")
		.author("Jacob Hrbek <kreyren@rixotstudio.cz>")
		.about("Work in progress package manager")
		.subcommand(SubCommand::with_name("resolve")
			.about("Resolved package to be imported in the system")
			.arg_from_usage("<category/package> 'Package identifier'"))
		.get_matches();

	if let Some(matches) = matches.subcommand_matches("resolve") {
		efixme("Add abstract");
	} else { // To be adapted for additional arguments
		println!("pong");
	}
}