#include <stdio.h>
#include <string.h>

// FIXME: Does not build on clang
// FIXME-TEST: Adapt valgrind

int main(int argc, char **argv) {
	if(argc < 2) {
		// FIXME: Source better help message from po depending on language used
		printf("%s\n", "Argument(s) required, use -h for display help");
		return 2;
	} else if(strcmp(argv[1], "-h") == 0) {
		printf("FIXME: %s\n", "Add optionsi");
		return 1;
	}	else {
		printf("FATAL: %s\n", "Unexpected happend while processing arguments");
		return 256;
	}
}
