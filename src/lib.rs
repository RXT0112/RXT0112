/*
	File used for sourcing of libraries
*/

// Use modules
mod modules {
  pub mod rustlang;
}

// Use subcommands
pub mod subcoms { 
  pub mod resolve {
      pub mod rustlang {
        pub mod resolve;
      }
  }
}