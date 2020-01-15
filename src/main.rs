// Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPL-3 license (https://www.gnu.org/licenses/gpl-3.0.en.html) in 2020

use clap::{Arg, App, SubCommand};

mod output/efixme;

fn main() {
	efixme::run("ping");

	// Capture arguments (https://docs.rs/clap/2.33.0/clap/)
	// let matches = App::new("RXT0112")
	// 	.version("0.0.0")
	// 	.author("Jacob Hrbek <kreyren@rixotstudio.cz>")
	// 	.about("Work in progress package manager")
	// .get_matches();
}