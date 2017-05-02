%macro if 1 ; Macro if recebe 1 argumento
	%push if ; Push no contexto
	j%-1 %$ifnot ; Se for zero, vai para o ifnot
%endmacro

%macro else 0 ; Macro else, nao recebe argumentos
	%ifctx if ; Se estiver no contexto if
		%repl else ; Substituir para o contexto else
		jmp %$ifend ; Ir para o final do if
	   %$ifnot: ; Label do ifnot
	%else ; Se não for o contexto if, retornar erro
		%error "Era esperado um if antes de else"
	%endif
%endmacro

%macro endif 0 ; Macro para finalizar o if
	%ifctx if ; Se estiver no contexto if
	   %$ifnot: ; Labelifnot
		%pop ; Retirar o if do contexto
	%elifctx else ; Se o contexto for else
	   %$ifend: ; Finalizar o if com a label ifend
		%pop ; Pop no contexto do else
	%else ; Se nao for o contexto esperado, retornar erro
		%error "Era esperado um if antes de endif"
	%endif
%endmacro

%macro dowhile 0 ; Do-while sem parametros
	%push dowhile ; Colocar o contexto do-while
	%$begin: ; Iniciar o conteúdo do do-while
%endmacro

%macro enddowhile 1 ; Finalizar o do-while
	j%-1 %$begin ; Se for diferente de zero, voltar para o inicio do laco
	%pop ; Se for zero, retirar o contexto
%endmacro

%macro for 1
	%push for
	j%-1 %$fimfor
	%$begin:
%endmacro

%macro endfor 0
	jnz %$begin
	%$fimfor:
	%pop
%endmacro

global _ifmacro
global _dowhilemacro
global _formacro

	section .data

	section .text

_ifmacro:
	mov eax, [esp+4] ; Colocar o parametro em eax
	cmp eax,0 ; Comparar o parametro com zero
	if z
		ret ; Retornar se for zero
	else
		ret ; Retornar se não for zero
	endif

_dowhilemacro:
	mov ebx,[esp+4] ; Colocar o parametro em ebx
	mov eax,0 ; Colocar a contagem em eax, para retornar
	dowhile
		dec ebx ; Decrementar o numero de vezes
		cmp ebx,0 ; Comparar o numero de vezes com zero
		inc eax ; Incrementar a contagem
	enddowhile g ; Terminar o laco se for menor ou igual a zero
	ret

_formacro:
	mov eax,[esp+4]
	mov ebx,[esp+8]
	mov ecx,[esp+12]

	cmp eax,ebx
	for nz
		cmp ecx,0
		jz decrementar
		jnz incrementar
		incrementar: inc eax
		jmp continuar
		decrementar: dec eax
		continuar:
		cmp eax,ebx
	endfor
	ret

