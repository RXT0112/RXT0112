use zernit_logger::fixme;

pub fn deploy() {
	// ABSTRACT: This is expected to be the installation method for the end-users to get OS with (WIP-NAME)
	fixme!("Deploy on target");
		fixme!("Deploy based on ENV variable -> ROOT='somepath' exports packages in somepath treating it as root");
		fixme!("Deploy based on config file");
		fixme!("Allow selection of file system hierarchy from CLI args");
		fixme!("Deploy kernel based on CLI args");
		fixme!("Deploy toolchain based on CLI args");
		fixme!("Deploy features");
			fixme!("Expected feature: Kreyrock (bedrock)");
			fixme!("Expected feature: winehq for unix");
	unimplemented!("Listing is not yet implemented");
}