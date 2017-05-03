/** Questão I - Macros NASM
*	Estudantes: Arthur Jaber Costato (13/0039993)
*				Murilo Cerqueira Medeiros (12/0130637)
*				
*				
*				
*				
*
*	Este programa realiza a chamada de funções em NASM que simulam a execução de comandos do C.
*	Os parâmetros estão descritos em cada função.
*
**/

#include <stdio.h>

/**
*	Função para simular a execução do comando if.
*	Parâmetro: Número inteiro representando o valor que deve ser avaliado.
*	Retorno: A função retorna um valor diferente de zero (ou seja, true) se o parâmetro enviado for diferente de 0, e 0 (ou seja, false) se o parâmetro for igual a 0.
*
**/
int ifmacro(int a);

/**
*	Função para simular a execução do comando while.
*	Parâmetro: Número inteiro representando o número de vezes que o laço deve ser executado.
*	Retorno: A função retorna o número de vezes que o laço foi executado.
*
**/
int whiledomacro(int a);

/**
*	Função para simular a execução do comando do-while.
*	Parâmetro: Número inteiro representando o número de vezes que o laço deve ser executado.
*	Retorno: A função retorna o número de vezes que o laço foi executado.
*
**/
int dowhilemacro(int a);

/**
*	Função para simular a execução do comando for.
*	Parâmetro:	a - Número inteiro representando o valor inicial.
*				b - Número inteiro indicando o valor que o parâmetro "a" deve atingir.
*				c - Número inteiro, sendo que 1 indica que o valor "a" será incrementado, e 0 indica que o valor "a" será decrementado.
*	Retorno: A função retorna o número de vezes que o laço foi executado.
*
**/
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

	int retornowhile = whiledomacro(5);
	printf("Entrou no while-do %d vezes.\n",retornowhile);

	return 0;
}