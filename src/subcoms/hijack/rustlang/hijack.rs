/*
	FIXME-DOCS: Add docs
*/

use zernit_logger::fixme;

pub fn hijack() {
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
}