// Created by Jacob Hrbek <kreyren@rixotstudio.cz> under GPL-3 license (https://www.gnu.org/licenses/gpl-3.0.en.html) in 2020

// Source lib.rs
// FIXME-QA: Is this the best way to do this?
use RXT0112::*;

// FIXME: Move macros for output in their standalone crate

// Macro to handle fixme messages
// FIXME: Implement export in log directory based on system used
// FIXME: Allow end-user to customize the message
// FIXME: Allow end-user to mute the messages through configuration
// FIXME: Contribute in log to outsource maintainance on them
macro_rules! fixme {
	($msg:expr) => ( println!("FIXME: {}", $msg);)
}

// Macro to inform the end-user about non-fatal error
// FIXME: Implement export in log directory based on system used
// FIXME: Allow end-user to customize the message
// FIXME: Contribute in log to outsource maintainance on them
macro_rules! error {
	($msg:expr) => ( println!("ERROR: {}", $msg);)
}

// Macro to perform tracing
// FIXME: Implement export in log directory based on system used and debug level
// FIXME: Allow end-user to customize the message
// FIXME: Contribute in log to outsource maintainance on them
// FIXME: Output only if debug level 2 and higger is used
macro_rules! trace {
	($msg:expr) => ( println!("TRACE: {}", $msg);)
}

// Macro to handle info messages
/// FIXME: Implement export in log directory based on system used
/// FIXME: Outsource parts of the code in log crate?
/// FIXME: Allow end-user to customize the message
macro_rules! info {
	($msg:expr) => ( println!("INFO: {}", $msg);)
}

// Macro to overwrite default `unimplemented!();` to be more user-friendly
// FIXME: Determine error code for unimplemented
macro_rules! unimplemented {
	($msg:expr) => (
		die!(126; "UNIMPLEMENTED: {}", $msg);
	)
}

fn main() {
	die!(1; "ping");
	fixme!("Add method to handle translations");
	fixme!("Allow changing name based on config file");
	fixme!("Verify that this works on POSIX");

	// Capture arguments (https://docs.rs/clap/2.33.0/clap/)
  // FIXME-BENCHMARK: Benchmark other option like structOpt (https://docs.rs/structopt/0.3.7/structopt/#subcommands)
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
		.arg(Arg::with_name("dev")
			.short("D")
			.long("development")
			.multiple(true)
			.help("Perform all following actions in a temporary sandboxed directory used for development"))
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
	} else if matches.is_present("dev") {
		// WARNING: Has to be implemented prior to implementing other features
		// FIXME-TEST: Make a test to ensure that features are not escaping sandbox
		// FIXME: Translate in rustlang from english
		fixme!("Create a new directory in tmpdir/name-of-project");
		emkdir("/var/tmp/RXT0112");
		fixme!("Create sandboxed environment for testing of features");
		unimplemented!("Development method is not yet supported");
	}

	// Manage subcommands
	// NOTICE: Do not add else statement to catch unexpecteds since this is handled by clap
	// FIXME: Convert this statement in case which would seem like better implementation
	if let Some(_matches) = matches.subcommand_matches("resolve") {
		// Current approach: Download source to ... ?
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
	} else if let Some(_matches) = matches.subcommand_matches("deploy") {
		fixme!("Perform sanity-checks for hijacking");
		fixme!("Hijack apt");
		fixme!("Hijack pacman");
		fixme!("Hijack portage");
		fixme!("Hijack dnf");
		fixme!("Hijack zypper");
		fixme!("Hijack freebsd pckm");
		fixme!("Hijack MacOS");
		fixme!("Hijack Windows?");
		fixme!("Die if untested system is parsed");
		fixme!("Die if used on invalid directory (suggest deploy instead?)");
		unimplemented!("Hijacking is not yet supported");
	} else if let Some(_matches) = matches.subcommand_matches("remove") {
		fixme!("Remove package from specified root");
		unimplemented!("Removal of packages from specified root is not yet supported");
	}

	fixme!("Returns 0 even when no argument was parsed -> Expecting Exit 2 with help message");
}