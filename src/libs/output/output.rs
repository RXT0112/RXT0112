/*
	FIXME-DOCS: Docummentation needed
*/

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