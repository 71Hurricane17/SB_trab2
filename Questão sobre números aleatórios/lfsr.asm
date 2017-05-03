global main
    extern printf ;função de C para imprimir na tela

    section .data
format: db '%ld', 10, 0 ;formato de impressão usada no printf
    
    section .text
main:
    push rbp        ; seta stack
    mov rax, 0xACE1 ; define seed value
    mov r15,rax ; passe seed value para outro registrador, que será usado no loop

random:
    ;move valor de r15 para outros registradores
    mov r14,r15
    mov r13,r15
    mov r12,r15
    mov r11,r15
    ;realiza operações definidas pelos tap values da função: x^24+x^23+x^21 + x^20 +1
    shr r14,0
    shr r13,1
    shr r12,3
    shr r11,4
    xor r14,r13
    xor r14,r12
    xor r14,r11
    and r14,1
    shr r15,1
    shl r14,23
    or r15,r14
    ;salva valores em rax e rcx, pois eles podem ser mudados em printf
    push rax
    push rcx
    mov rdi, format ;move ponteiro para format
    mov rsi, r15 ; move valor a ser impresso
    mov eax, 0
    call printf ; imprime valor
    pop rcx
    pop rax
    ;condição do loop
    cmp rax, r15
    jne random
end:
    pop rbp
    mov rax, 0
    ret

