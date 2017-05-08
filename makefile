all: mac macros
mac:
	nasm -f macho Grupo2-01-macros.asm
macros:
	gcc -Wall -m32 -o macros Grupo2-01-macros.o Grupo2-01-macros.c

lfsr:
	nasm -f elf64 -l lfsr.lst lfsr.asm
	gcc -m64 -o lfsr lfsr.o

clean:
	rm *.o
	rm macros
	rm lfsr