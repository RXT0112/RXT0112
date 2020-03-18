FIXME: `main` is a place-holder -> Looking for a good name for backend resolver for zernit's backend i.e [paludis](https://paludis.exherbo.org/) using `cave`

---

# Core binary
This directory is used for core binary meaning that this binary is executed first and should resolve to required commands i.e if end-user executes `main help` expecting usage instructions then this binary should resolve the argument and execute `$repodir/src/subcoms/help` in it's appropriate place on the system once compiled (if applies) unless the language has more efficient method to handle this scenario through library alike rustlang's clap that generates the help message based on arguments provided.

## ABSTRACT
Resolve arguments to subcommands and provide backend for libraries/modules if requried

### Practical examples
end-user inputs `main help` through cli -> Display help message

end-user inputs `main resolve app-compat/wine` -> Resolve wine on end-user's system if compatible system and toolchain is used
