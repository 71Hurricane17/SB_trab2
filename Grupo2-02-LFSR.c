/**							    LINEAR FEEDBACK SHIFT REGISTER (LFSR)
*	Estudantes: Arthur Jaber Costato (13/0039993)
*				Murilo Cerqueira Medeiros (12/0130637)
*				
*				
*				
*				
*
*	Este programa realizará o cálculo de números aleatórios utilizando o método de Fibonacci LFSR.
*	Este programa gerará 2^24 números de 24 bits por meio de um número (seed) escolhido arbitrariamente.
*	Esses números serão classificados em 4096 classes:
*	 - Classe 00: no intervalo [0 , 4095]
*	 - Classe 01: no intervalo [4096 , 8191]
*	 -  .  .  .  .  .  .  .  .  .  .  .  .  .
*	 - Classe 4096: no intervalo [16773120 , 16777215]
*	Espera-se que cada intervalo possua uma frequência de 4096 números.
*	Com isso, será calculado o valor de Chi Quadrado.
*
*	Definiu-se MACROS para inicializar vetores, para classificar números em uma das 64 Classes e para calcular o LFSR:
*		INIV: inicializa um vetor (vet) com um valor (val) até uma dada posição (limite);
*		CLASSIFICA: Classifica um número gerado (num) em uma das classes (var);
*		geraNumLFSR: Ao invés de criar uma função, criou-se uma macro para calcular o LFSR 
**/

#include <stdio.h>

// MACRO que inicializa um vetor
#define INIV(var,val,cont,limite)cont = 0;\
while(cont < limite){\
    var[cont] = val;\
    cont++;\
}

// MACRO que classifica o número
#define CLASSIFICA(var,num,cont) cont = num>>12;\
var[cont]++

// MACRO que gera número LFSR. A regra escolhida para o LFSR foi aplicar o XOR no 6º, 20º, 23º e 24º bits
#define geraNumLFSR(seed) (seed>>1)|(( ((seed>>5)^(seed>>19)^(seed>>22)^(seed>>23))&1 ) <<23)

/** Função Principal **/
int main(){
	unsigned int seed = 0b101101100110010000010101; // Seed escolhida arbitrariamente
	unsigned int num;

	int i, j;

	int freqClasse[4096];
	INIV(freqClasse,0,i,4096);

	num = geraNumLFSR(seed);
	CLASSIFICA(freqClasse,num,i);
	for(i = 0; i < 16777216; i++){
		num = geraNumLFSR(num);
		CLASSIFICA(freqClasse,num,j);
	}

	int freqEspClasse = 4096;

	int freqMax = 0;
	int posMax = -1;
	int freqMin = 16777216;
	int posMin = -1;
	double chiQuadrado;

	for(i = 0; i < 4096; i++){
		if(freqMax < freqClasse[i]){
			freqMax = freqClasse[i];
			posMax = i;
		}
		if(freqMin > freqClasse[i]){
			freqMin = freqClasse[i];
			posMin = i;
		}
		chiQuadrado += ((double)(freqClasse[i]-freqEspClasse)*(freqClasse[i]-freqEspClasse))/((double)freqEspClasse);
	}

	printf("Seed = %d\n",seed);
	printf("Frequencias esperadas para as classes = 4096\n");
	printf("Maxima frequencia (Classe %d) = %d\n",posMax,freqMax);
	printf("Minima frequencia (Classe %d) = %d\n",posMin,freqMin);
	printf("Chi Quadrado = %.2lf\n",chiQuadrado);

	getchar();

	for(i = 0; i < 4096; i++){
		printf("Frequencia da classe %d = %d\n",i,freqClasse[i]);
		if((i+1)%128 == 0)getchar();
	}

	return 0;
}
