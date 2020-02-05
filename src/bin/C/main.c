#include <stdio.h>

int main(int argc, char ** argv[]) {



	if(argc < 2)
	{
		printf("\nArgument(s) required, use -h for display help\n");
	}
	else if(strcmp(argv[1], "-h") == 0)
	{
		printf("\n Fixme: Add optionsi\n");
	}
	else
	{
		printf("\nuwu");
	}


	return 0;
}
