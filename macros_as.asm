%macro if 1
	%push if
	j%-1 %$ifnot
%endmacro

%macro else 0
	%ifctx if
		%repl else
		jmp %$ifend
	   %$ifnot:
	%else
		%error "Era esperado um if antes de else"
	%endif
%endmacro

%macro endif 0
	%ifctx if
	   %$ifnot:
		%pop
	%elifctx else
	   %$ifend:
		%pop
	%else
		%error "Era esperado um if antes de endif"
	%endif
%endmacro

%macro while 0
	%push while
	%$begin:
%endmacro

%macro endwhile 1
	j%-1 %$begin
	%pop
%endmacro

global _ifmacro
global _whilemacro

	section .data

	section .text

_ifmacro:
	mov eax, [esp+4]
	cmp eax,0
	if z
		ret
	else
		ret
	endif

_whilemacro:
	mov ebx,[esp+4]
	mov eax,0
	while
		dec ebx
		inc eax
		cmp ebx,0
	endwhile z
	ret



; global start

; 	section .text
	
; start:
; 	mov eax,23
; 	mov ebx,25
; 	mov ecx,20
; 	cmp eax,ebx
; 	if ae
; 		cmp ebx,ecx
; 		if ae
; 			mov eax,ecx
; 		else
; 			mov eax,ebx
; 		endif
; 	else
; 		cmp eax,ecx
; 		if ae
; 			mov eax,ecx
; 		endif
; 	endif




