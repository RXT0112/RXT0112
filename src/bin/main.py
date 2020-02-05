import sys
from termcolor import cprint


def cli_arg():
    if len(sys.argv) == 1:
        cprint("No Arguments Were Passed. Type -h to view basic usage.", "red")
        exit()
    # sys.arg[1] is the file itself.
    elif sys.argv[1].lower() == "-h":
        cprint("""
File used as bankend to parse arguments and options into subcommands

SYNOPSIS: command OPTION [SUBCOMS]

OPTIONS:
        -G, --gui      Open Graphical User Interface
        
SUBCOMS (Subcommands):
	resolve        resolve package on the system
""", "green")

    else:
        cprint("Incorrect Argument! Type -h to view basic usage.", "red")


if __name__ == '__main__':
    try:
        cli_arg()
    except IndexError:
        pass
