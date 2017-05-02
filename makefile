mac:
	nasm -f macho macros_as.asm
macros:
	gcc -Wall -m32 -o macros macros_as.o macros.c