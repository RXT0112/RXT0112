/*
	File used for sourcing of libraries
*/

// FIXME: Optimize dependencies depending on what is being called and used

// FIXME: Resolve once name of the project is determined
#![allow(non_snake_case)]

// Library used for cli argument management
extern crate clap;
use clap::{Arg, App, SubCommand};

// Export for metadata?
// FIXME: Verify unused
use std::fs;

// Export of standard library to make a new directory (works cross-platform)
// FIXME: Make create_dir to output TRACE message of level 2
// FIXME: Output helpful error in CLI and logs
use std::fs::create_dir;

// Get die macro
// FIXME: Contribute in die crate to allow customization of messages by the end-user
use die::die;

// Required for create_dir
use std::fs::metadata;

// Required for emkdir
use std::io;