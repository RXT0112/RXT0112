// Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPL-3 license (https://www.gnu.org/licenses/gpl-3.0.en.html) in 2020

// Library used for cli argument management
extern crate clap;
use clap::{Arg, App, SubCommand};

// Get die macro
/// FIXME: Contribute in die crate to allow customization of messages by the end-user
use die::die;

// Macro to handle fixme messages
/// FIXME: Implement export in log directory based on system used
/// FIXME: Outsource parts of the code in log crate?
/// FIXME: Allow end-user to customize the message
/// FIXME: Allow end-user to mute the messages through configuration
/// FIXME: Contribute in log to outsource maintainance on them
macro_rules! fixme {
	($msg:expr) => ( println!("FIXME: {}", $msg);)
}

// Macro to overwrite default `unimplemented!();` to be more user-friendly
// FIXME: Determine error code for unimplemented
macro_rules! unimplemented {
	($msg:expr) => (
		die!(126; "UNIMPLEMENTED: {}", $msg);
	)
}

fn main() {
	fixme!("Add method to handle translations");
	fixme!("Returns 0 even when no argument was parsed -> Expecting Exit 2 with help message");
	fixme!("Allow changing name based on config file");

	// Capture arguments (https://docs.rs/clap/2.33.0/clap/)
	// FIXME: Check if structOpt (https://docs.rs/structopt/0.3.7/structopt/#subcommands) is not better for our usecase
	// FIXME-TEST: Add test to make sure that clap works the way we want it
	let matches = App::new("RXT0112")
		.version("INIT_PHASE_VERSION") // Replace with valid versioning
		.author("Jacob Hrbek <kreyren@rixotstudio.cz>")
		.about("Work in progress package manager expected to support any kernel on any downstream")
		.arg(Arg::with_name("gui")
			.short("G")
			.long("gui")
			.multiple(true)
			.help("Opens up a Graphical User Interface frontend"))
		// FIXME-QA: Sort subcommands alphabetically
		.subcommand(SubCommand::with_name("resolve")
			.about("Resolved package to be imported in the system")
			.arg_from_usage("<category/package> 'Package identifier'"))
		.subcommand(SubCommand::with_name("remove")
			.about("Remove package from the system")
			.arg_from_usage("-r, remove 'Removing of packages'"))
		.subcommand(SubCommand::with_name("list")
			.about("Listing of packages")
			.arg_from_usage("-l, list 'Listing of packages'"))
		.subcommand(SubCommand::with_name("deploy")
			.about("deploy (WIP-NAME) on target used for initial instalation")
			.arg_from_usage("-l, list 'Listing of packages'"))
			// FIXME: Replace with following: .arg_from_usage("deploy 'Deploy (WIP-NAME) on target which creates required file hierarchy and configuration needed for (WIP-NAME)'"))
		.subcommand(SubCommand::with_name("hijack")
			.about("Import (WIP-NAME) on target system that already exists for (WIP-NAME) to be used as alternative package manager")
			.arg_from_usage("-l, list 'Listing of packages'"))
			// FIXME: Replace with following: .arg_from_usage("hijack 'Import (WIP-NAME) on target system that already exists for (WIP-NAME) to be used as alternative package manager'"))
		.get_matches();

	// Manage arguments
	// NOTICE: Do not add else statement to catch unexpecteds since this is handled by clap
	if matches.is_present("gui") {
		unimplemented!("GUI method is not yet implemented");
	}

	// Manage subcommands
	// NOTICE: Do not add else statement to catch unexpecteds since this is handled by clap
	// FIXME: Convert this statement in case which would seem like better implementation
	if let Some(_matches) = matches.subcommand_matches("resolve") {
		// Current approach: Download source to 
		fixme!("Check if expected file hierarchy is present, if not prompt for init subcommand");
		fixme!("Initiate sandbox");
			fixme!("Allow multiple methods of sandboxing");
		fixme!("Fetch source");
		fixme!("Cache source");
		fixme!("Configure source");
		fixme!("Compile source");
		fixme!("Install source");
		fixme!("Add a method to customize the resolution by the end-user");
		// FIXME: Outputs user-unfriendly message
		unimplemented!("Resolving of packages is not yet implemented");
	} else if let Some(_matches) = matches.subcommand_matches("list") {
		fixme!("Output installed packages");
		unimplemented!("Listing is not yet implemented");
	} else if let Some(_matches) = matches.subcommand_matches("deploy") {
		// ABSTRACT: This is expected to be the installation method for the end-users to get OS with (WIP-NAME)
		fixme!("Deploy on target");
			fixme!("Deploy based on ENV variable");
			fixme!("Deploy based on config file");
			fixme!("Allow selection of file system hierarchy from CLI args");
			fixme!("Deploy kernel based on CLI args");
			fixme!("Deploy toolchain based on CLI args");
			fixme!("Deploy features");
				fixme!("Expected feature: Kreyrock");
				fixme!("Expected feature: winehq for unix");
		unimplemented!("Listing is not yet implemented");
	} else if let Some(_matches) = matches.subcommand_matches("remove") {
		fixme!("Remove package from specified root");
		unimplemented!("Removal of packages from specified root is not yet supported");
	}
}