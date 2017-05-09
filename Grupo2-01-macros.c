/** Questão I - Macros NASM
*	Estudantes: Arthur Jaber Costato - 13/0039993
*				Gabriel Fritz Sluzala - 13/0111236
*				Lucas Gomes Almeida - 12/0152860
*				Murilo Cerqueira Medeiros - 12/0130637
*				Thiago Penha Torreão - 10/0125441		

*	Este programa realiza a chamada de funções em NASM que simulam a execução de comandos do C.
*	Os parâmetros estão descritos em cada função.
*
**/

#include <stdio.h>

/**
*	Função para simular a execução do comando if.
*	Parâmetro:	a - Primeiro número que será comparado. 
*				b - Segundo número que será comparado. 
*				c - Terceiro número que será comparado. 
*	Retorno: A função retorna o maior número.
**/
int ifmacro(int a,int b,int c);

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

/**
*	Função para simular a execução do comando switch.
*	Parâmetro:	a - Número inteiro representando o valor que será analisado.
*	Retorno: A função retorna 1, se o número tiver o valor de 1 ou 2, e 0, caso contrário.
**/
// int switchmacro(int a);

int main(int argc, char const *argv[]){
	
	int a = 1;
	int b = 2;
	int c = 3;
	
	int retornoif = ifmacro(a,b,c);
	printf("O maior número é %d.\n",retornoif);

	int retornodowhile = dowhilemacro(0);
	printf("Entrou no do-while: %d vezes.\n",retornodowhile);

	int retornofor = formacro(0,3,1);
	printf("Entrou no for: %d vezes\n",retornofor);

	int retornowhiledo = whiledomacro(5);
	printf("Entrou no while-do %d vezes.\n",retornowhiledo);

	// int retornoswitch = switchmacro(1);
	// printf("O retorno do switch foi %d.\n",retornoswitch);

	return 0;
}