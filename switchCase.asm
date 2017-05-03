%macro switch 1       ; Cria macro switch
  %push switch        ; Cria contexto switch
  %assign var %1      ; Salva em uma "variável da macro" do contexto (var) o parâmetro passado (%1)
  %assign caseCont 0  ; Cria contador de cases
%endmacro

%macro case 1         ; Cria macro case
  %ifctx switch       ; Se estiver no contexto switch
    %repl case        ; Renomeia contexto para case
    %assign caseCont caseCont+1 ; Incrementa contador de cases
    cmp var %1
    jne %$case%+caseCont ;Se var for diferente do parâmetro passado (%1), salta para próximo case
  %elifctx case       ; Se estiver no contexto case
    %$case%+caseCont: ; Cria label do case 
    %assign caseCont caseCont+1 ; Incrementa contador de cases
    cmp var %1
    jne %$case%+caseCont ;Se var for diferente do parâmetro passado, salta para próximo case
  %elifctx default    ; Se estiver no contexto default
    %error "Não coloque um default antes de um case"
  %else               ; Se não existir contexto switch ou case anteriormente
    %error "Esperado um switch ou case anteriormente"
  %end
%endmacro

%macro break
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

%macro default
  %ifctx switch
    %error "Esperado ao menos um case antes do default"
  %elifctx case
    %$case%+caseCont: ; Cria label do default 
    %repl default     ; Renomeia contexto para default
  %elifctx default
    %error "Coloque apenas um default"
  %else
    error "Default precisa estar dentro de um switch"
  %end
%endmacro

%macro switchEnd
  %ifctx switch
    error "Coloque case's e se quiser default dentro do switch"
  %elifctx case
    %$switchEnd:      ; Cria label switchEnd
    %pop;             ; remove contexto da macro
  %elifctx default
    %$switchEnd:      ; Cria label switchEnd
    %pop;             ; remove contexto da macro
  %else
    error "Esperado abertura de um switch antes de fechá-lo"
  %end
%endmacro


