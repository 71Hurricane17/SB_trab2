#include <stdio.h>

int ifmacro(int a);
int whilemacro(int a);

int main(int argc, char const *argv[]){

	int a = 1;
	int b = 2;
	int c = 3;
	
	int retornofinal = ifmacro(a<b) && ifmacro(a<c);
	printf("%d\n",retornofinal);

	int y = whilemacro(1);

	printf("%d\n",y);

	return 0;
}