/*
	File used for sourcing of libraries
*/

// Use modules
mod modules {
  pub mod rustlang;
}

// Use subcommands
// FIXME: Define modules for commands in `src/subcoms/<COMMAND>/rustlang/<COMMAND>/<COMMAND>();`
pub mod subcoms { 
  pub mod resolve {
      pub mod rustlang {
        pub mod resolve;
      }
  }
  pub mod remove {
      pub mod rustlang {
        pub mod remove;
      }
  }
  pub mod list {
      pub mod rustlang {
        pub mod list;
      }
  }
  pub mod deploy {
      pub mod rustlang {
        pub mod deploy;
      }
  }
  pub mod hijack {
      pub mod rustlang {
        pub mod hijack;
      }
  }
}