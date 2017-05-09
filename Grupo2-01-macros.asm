; Questão I - Macros NASM
;	Estudantes: Arthur Jaber Costato - 13/0039993
;				Gabriel Fritz Sluzala - 13/0111236
;				Lucas Gomes Almeida - 12/0152860
;				Murilo Cerqueira Medeiros - 12/0130637
;				Thiago Penha Torreão - 10/0125441			
;
;	Este programa realiza a simulação de comandos em C através de macros.

%macro if 1 ; Macro if recebe 1 argumento de condition code
	%push if ; Push no contexto
	j%-1 %$ifnot ; Se condition code não for satisfeito, vai para o ifnot
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

%macro whiledo 1 ;While-do com 1 parametro
	%push whiledo ; Colocar o contexto do While-do
	%$begin:
	j%-1 %$fimwhile ; Se a condicao não for atendida, finalizar o while
%endmacro

%macro endwhiledo 0
	jmp %$begin
	%$fimwhile:
	%pop ; Retirar o whiledo do contexto
%endmacro

%macro dowhile 0 ; Do-while sem parametros
	%push dowhile ; Colocar o contexto do do-while
	%$begin: ; Iniciar o conteúdo do do-while
%endmacro

%macro enddowhile 1 ; Finalizar o do-while
	j%-1 %$begin ; Se for diferente de zero, voltar para o inicio do laco
	%pop ; Se condition code não for satisfeito, retirar o contexto
%endmacro

%macro for 1 ; For com um parâmetro
	%push for ; Colocar o contexto do for
	j%-1 %$fimfor ; Se a condição não for atendida, ir para o fim do laço
	%$begin: ; Se a condição for atendida, iniciar o laço
%endmacro

%macro endfor 0
	jnz %$begin ; Ir para o início do laço
	%$fimfor: ; Finalizar o for
	%pop ; Retirar o contexto do for
%endmacro

%macro switch 1       ; Cria macro switch
  %push switch        ; Cria contexto switch
  %assign %$var %1    ; Salva em uma "variável da macro" do contexto (var) o parâmetro passado (%1)
  %assign %$caseCont 0; Cria contador de cases
  [SECTION .data]     ; Altera para a seção de .data
    %$caseIn db 0     ; Cria uma flag caseIn recebendo 0
    ; %$var dw 0        ; Cria uma variável var recebendo 0
  __SECT__            ; Retorna para a seção corrente
%endmacro

%macro case 1         ; Cria macro case
  %ifctx switch       ; Se estiver no contexto switch
    %repl case        ; Renomeia contexto para case
    %assign %$caseCont %$caseCont+1 ; Incrementa contador de cases
    cmp %$caseIn 0    ; Se tiver entrado em um case e não ter dado um break
    jne %$caseIn%$caseCont 
    cmp %$var %1
    jne %$case%$caseCont ;Se var for diferente do parâmetro passado (%1), salta para próximo case
    mov %$caseIn 1    ; Entrou em um case, então seta flag caseIn para 1
  %elifctx case       ; Se estiver no contexto case
    %$case%$caseCont: ; Cria label do case 
    %assign %$caseCont %$caseCont+1 ; Incrementa contador de cases
    cmp %$caseIn 0    ; Se tiver entrado em um case e não ter dado um break
    jne %$caseIn%$caseCont 
    cmp %$var %1
    jne %$case%$caseCont ;Se var for diferente do parâmetro passado, salta para próximo case
    mov %$caseIn 1    ; Entrou em um case, então seta flag caseIn para 1
  %elifctx default    ; Se estiver no contexto default
    %error "Não coloque um default antes de um case"
  %else               ; Se não existir contexto switch ou case anteriormente
    %error "Esperado um switch ou case anteriormente"
  %end
  %$caseIn%$caseCont:
%endmacro

%macro break 0
  %ifctx case
    jmp %$switchEnd   ; Salta para fim do switch
  %elifctx default
    jmp %$switchEnd   ; Salta para fim do switch
  %elifctx switch
    %error "Não coloque break antes de um case"
  %else
    %error "Esperado um case ou default antes do break"
  %end
%endmacro

%macro default 0
  %ifctx switch
    %error "Esperado ao menos um case antes do default"
  %elifctx case
    %$case%$caseCont: ; Cria label do default 
    %repl default     ; Renomeia contexto para default
  %elifctx default
    %error "Coloque apenas um default"
  %else
    error "Default precisa estar dentro de um switch"
  %end
%endmacro

%macro switchEnd 0
  %ifctx switch
    %error "Coloque cases e se quiser default dentro do switch"
  %elifctx case
    %$switchEnd:      ; Cria label switchEnd
    %pop;             ; remove contexto da macro
  %elifctx default
    %$switchEnd:      ; Cria label switchEnd
    %pop;             ; remove contexto da macro
  %else
    %error "Esperado abertura de um switch antes de fechá-lo"
  %end
%endmacro


global _ifmacro
global _whiledomacro
global _dowhilemacro
global _formacro
global _switchmacro

	section .data

	section .text

_ifmacro:
	mov eax, [esp+4] ; Colocar o primeiro numero em eax
	mov ebx,[esp+8] ; Colocar o segundo numero em ebx
	mov ecx,[esp+12] ; Colocar o terceiro numero em ecx

	cmp eax,ebx ; Comparar os 2 primeiros parametros
	if ae ; Se EAX for maior ou igual
		cmp eax,ecx
		if ae ; Se EAX for maior ou igual
			; EAX já está em EAX, então não faz nada
		else ; Se EAX eh maior que EBX e menor que ECX, ECX é o maior
			mov eax,ecx ; ECX é o maior
		endif
	else
		cmp ebx,ecx
		if ae
			mov eax,ebx ; EBX é o maior
		else
			mov eax,ecx ; ECX é o maior
		endif
	endif

	ret

_whiledomacro:
	mov eax,0 ; Colocar a contagem em eax, para retornar
	mov ebx,[esp+4] ; Colocar o numero de vezes em ebx
	test ebx,ebx ; Verificar se o numero de vezes eh zero, para setar a flag ZF e a condição do laco ser falsa
	whiledo nz
		inc eax ; Incrementar a contagem
		dec ebx ; Decrementar o número de vezes
	endwhiledo
	ret

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
	; Colocar os parâmetros em eax, ebx e ecx
	mov eax,[esp+4]
	mov ebx,[esp+8]
	mov ecx,[esp+12]

	; Comparar o valor inicial com o valor que ele deve atingir
	cmp eax,ebx
	for nz
		; Verificar se é um incremento ou decremento
		cmp ecx,0
		jz decrementar
		jnz incrementar
		; Incrementar o valor
		incrementar: inc eax
		jmp continuar
		; Decrementar o valor
		decrementar: dec eax
		continuar:
		; Comparar o valor com o valor que ele deve atingir
		cmp eax,ebx
	endfor
	ret

; _switchmacro:
; 	mov ebx,[esp+4]
; 	switch ebx
; 		case 1
; 			mov eax,1
; 		break
; 		case 2
; 			mov eax,1
; 		break
; 		default
; 			mov eax,0
; 		break
; 	switchEnd
; 	ret

