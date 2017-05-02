#include <stdio.h>

int ifmacro(int a);
int dowhilemacro(int a);
int formacro(int a,int b,int c);

int main(int argc, char const *argv[]){

	int a = 1;
	int b = 2;
	int c = 3;
	
	int retornofinal = ifmacro(a<b) && ifmacro(a<c);
	printf("A<B && A<C: %d\n",retornofinal);

	int y = dowhilemacro(0);

	printf("Entrou no do-while: %d vezes.\n",y);

	int retornofor = formacro(0,3,1);
	printf("Entrou no for: %d vezes\n",retornofor);

	return 0;
}