all: mac macros
mac:
	nasm -f macho Grupo2-01-macros.asm
macros:
	gcc -Wall -m32 -o macros Grupo2-01-macros.o Grupo2-01-macros.c

clean:
	rm *.o
	rm macros