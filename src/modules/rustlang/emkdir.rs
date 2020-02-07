/*
	FIXME-DOCS: Documentation needed
*/

// Sanitized method to make a new directory
fn emkdir<PATH: AsRef<std::path::Path>>(pathname: PATH) {
	//unimplemented!("Mkdir needs implementation");
	// FIXME: Verify that parsed argument is valid
	// FIXME-TEST: Make sure that this works on Linux
	// FIXME-TEST: Make sure that this works on Windows
	// FIXME-TEST: Make sure that this works on Redox
	// FIXME-TEST: Make sure that this works on MacOS
	// FIXME-TEST: Make sure that this works on FreeBSD
	// FIXME: Implement permission management for new directory
	fixme!("die() doesn't accept pathname println-way, using some/path as stub");
	if !metadata(pathname.as_ref()).unwrap().is_dir() {
		match fs::create_dir(pathname.as_ref()) {
			Ok(..) => { trace!("Created a new directory in some/path"); },
			Err(ref error) if error.kind() == io::ErrorKind::AlreadyExists => {
				// For scenerio where pathname was parsed after sanity checks and prior to create_dir() call
				if metadata(pathname.as_ref()).unwrap().is_file() {
					die!(1; "Pathname some/path points to a file, created after sanity checks and prior to create_dir() call, suspecting malicous injection");
				} else if metadata(pathname.as_ref()).unwrap().is_dir() {
					die!(1; "Pathname some/path points to already existing directory, created after sanity checks and prior to create_dir() call suspecting malicious injection");
				} else if false { // FIXME: Check for symlink
					die!(1; "Pathname some/path points to already existing symlink, created after sanity checks and prior to create_dir() call, suspecting malicious injection");
				} else {
					die!(256; "Unexpected happend for creation of some/path after sanity checks and prior to create_dir() call");
				}
			},
			Err(error) => { die!(256; "Unexpected happend while creating a directory some/path"); }
		}
	} else if metadata(pathname.as_ref()).unwrap().is_dir() {
		trace!("Directory some/path already exists no need to create it");
	} else if metadata(pathname.as_ref()).unwrap().is_file() {
		// FIXME: die!(1; "Path {} is already a file which is unexpected", pathname);
			die!(1; "Path somepath is already a file which is unexpected");
	} else if false { // FIXME: Implement checking for symlink
		die!(1; "Path some/path is a symlink which is unexpected for creating a directory");
	} else {
		die!(256; "Unexpected happend while creating a new directory in some/path");
	}
}