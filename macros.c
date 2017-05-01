#include <stdio.h>

int ifmacro(int a);

int main(int argc, char const *argv[]){

	int a = 1;
	int b = 2;
	int c = 3;
	
	int retorno = ifmacro(ifmacro(a>b)>c);
	printf("%d\n",retorno);

	return 0;
}