; GUSTAVO MONTENEGRO MAIA CHAVES - 20200015824

.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib


.data?
    ; Variavel de deslocamento
    deslocamento db ?
    ; Variavel de escolha do menu
    escolha db ?
    


.data

    ; Variaveis para arquivos
    fileLenght dd 0
    readCount DWORD 0
    totalBytesRead DWORD ?
    writeCount dd 0
    fileHandleRead dd 0
    fileHandleWrite dd 0
    bufferSize equ 512
    fileBuffer BYTE 512 DUP(?)

    ; Variaveis de Entrada
    escolha_usuario db 50 dup(0)
    arquivo_entrada db 50 dup(0)
    arquivo_saida db 50 dup(0)
    deslocamento_string db 50 dup(0)

    ; Strings de exibicao menu
    str_output_menu_1 db "BEM-VINDO AO CECURITY (Ceasar Security)", 0AH, 0H
    str_output_menu_2 db "[1] CRIPTOGRAFIA", 0AH, 0H
    str_output_menu_3 db "[2] DESCRIPTOGRAFIA", 0AH, 0H
    str_output_menu_4 db "[0] SAIR", 0AH, 0H
    str_output_menu_5 db "Informe a sua escolha: ", 0H

    ; Strings de exibicao leitura endereco arquivos
    str_output_escolha_1 db "Informe o nome do arquivo de entrada: ", 0H
    str_output_escolha_2 db "Informe o nome do arquivo de saida: ", 0H
    str_output_escolha_3 db "Informe o deslocamento usado: ", 0H

    ; String de finalizacao
    str_output_final db "Arquivo escrito", 0AH, 0H

    ; Variaveis de print e input
    OutputHandle dd 0 ; Handle de saida
    write_count dd 0 ; Armazena caracteres escritos
    inputHandle dd 0 ; Handle de entrada
    console_count dd 0 ; Aramazena caracters lidos/escritos na console
    tamanho_string dd 0 ; Tamanho de string

.code
start:

; Mostra Tela Inicial
menu:

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_menu_1, sizeof str_output_menu_1, addr write_count, NULL
  
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_menu_2, sizeof str_output_menu_2, addr write_count, NULL
  
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_menu_3, sizeof str_output_menu_3, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_menu_4, sizeof str_output_menu_4, addr write_count, NULL

    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_menu_5, sizeof str_output_menu_5, addr write_count, NULL

    ; Recebe entrada do usuario
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov OutputHandle, eax

    invoke ReadConsole, inputHandle, addr escolha_usuario, sizeof escolha_usuario, addr console_count, NULL

; Compara entrada do usuario e diverge com base na escolha
tratamento_escolha:

    ; Remove caracteres que nao sao digitos da entrada de escolha 
    ; Logica contida na aula de entrada e saida do professor
    mov esi, offset escolha_usuario
    proximo:
        mov al, [esi]
        inc esi
        cmp al, 48
        jl terminar
        cmp al, 58
        jl proximo
    terminar:
        dec esi
        xor al, al
        mov [esi], al

    ; Converte representacao ascii em binaria
    invoke atodw, addr escolha_usuario
    mov byte ptr escolha, al
    
    ; Usuario escolheu criptografia
    cmp escolha, 1
    je le_endereco_arquivos

    ; Usuario escolheu descriptografia
    cmp escolha, 2
    je le_endereco_arquivos

    ; Usuario escolheu saida
    cmp escolha, 0
    je finaliza_processo

    ; Usuario escolheu numero invalido
    ; Retorna para o inicio
    jmp menu



; Recebe nome do arquivo de entrada, saida e deslocamento usado
le_endereco_arquivos:

    ; Imprime requisicao do endereco de entrada do arquivo
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_escolha_1, sizeof str_output_escolha_1, addr write_count, NULL

    ; Leitura do endereco de entrada do arquivo
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov OutputHandle, eax
    invoke ReadConsole, inputHandle, addr arquivo_entrada, sizeof arquivo_entrada, addr console_count, NULL

    ; tratamento do endereco da entrada do arquivo
    mov esi, offset arquivo_entrada ; Armazenar apontador da string em esi
    proximo_entrada:
        mov al, [esi] ; Mover caractere atual para al
        inc esi ; Apontar para o proximo caractere
        cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
        jne proximo_entrada
        dec esi ; Apontar para caractere anterior
        xor al, al ; ASCII 0
        mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

    ; Imprime requisicao do endereco de saida do arquivo
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_escolha_2, sizeof str_output_escolha_2, addr write_count, NULL

    ; Leitura do endereco de saida do arquivo
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov OutputHandle, eax
    invoke ReadConsole, inputHandle, addr arquivo_saida, sizeof arquivo_saida, addr console_count, NULL

    ; tratamento do endereco da saida do arquivo
    mov esi, offset arquivo_saida ; Armazenar apontador da string em esi
    proximo_saida:
        mov al, [esi] ; Mover caractere atual para al
        inc esi ; Apontar para o proximo caractere
        cmp al, 13 ; Verificar se eh o caractere ASCII CR - FINALIZAR
        jne proximo_saida
        dec esi ; Apontar para caractere anterior
        xor al, al ; ASCII 0
        mov [esi], al ; Inserir ASCII 0 no lugar do ASCII CR

    ; Imprime requisicao do deslocamento que sera usado
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_escolha_3, sizeof str_output_escolha_3, addr write_count, NULL

    ; Leitura do deslocamento requisitado
    invoke GetStdHandle, STD_INPUT_HANDLE
    mov inputHandle, eax
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov OutputHandle, eax
    invoke ReadConsole, inputHandle, addr deslocamento_string, sizeof deslocamento_string, addr console_count, NULL

    ; Remove caracteres que nao sao digitos da entrada de deslocamento 
    ; Logica contida na aula de entrada e saida do professor
    mov esi, offset deslocamento_string
    proximo_des:
        mov al, [esi]
        inc esi
        cmp al, 48
        jl terminar_des
        cmp al, 58
        jl proximo_des
    terminar_des:
        dec esi
        xor al, al
        mov [esi], al

    ; Converte representacao ascii em binaria
    invoke atodw, addr deslocamento_string
    mov byte ptr deslocamento, al
    
    ; Realiza a cripgrafia/descriptografia da string
    jmp leitura_escrita_arquivo


; Processo de leitura do arquivo de entrada e escrita do de saida
leitura_escrita_arquivo:

    ; Abrir arquivo de entrada
    invoke CreateFile, addr arquivo_entrada, GENERIC_READ, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL
    mov fileHandleRead, eax

    ; Cria o arquivo de saida
    invoke CreateFile, addr arquivo_saida, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL
    mov fileHandleWrite, eax

    leitura_escrita_loop:
        invoke ReadFile, fileHandleRead, addr fileBuffer, bufferSize, addr readCount, NULL
        cmp readCount, 0
        je leitura_escrita_loop_fim
        jmp mudanca_criptografica
        

    leitura_escrita_loop_fim:
        ; Fecha o arquivo de entrada
        invoke CloseHandle, fileHandleRead
        ; Fecha o arquivo de saida
        invoke CloseHandle, fileHandleWrite
    jmp imprime_final


; Realiza a criptografia/descriptografia da string
mudanca_criptografica:

    ; esi armazena endereco do array
    mov esi, OFFSET fileBuffer

    ; Itera ate ler o final da string
    meu_laco_cripto:
        ; Zera al
        xor al, al
        ; Move caractere atual para al
        mov al, byte ptr [esi]

        ; Usuario escolheu criptografia (La em baixo)
        cmp escolha, 1
        je criptografia

        ; Usuario escolheu descriptografia (La em baixo)
        cmp escolha, 2
        je descriptografia

        continuacao:
            ; Move o caractere deslocado para o endereco original
            mov byte ptr [esi], al
            ; Vai para o proximo endereco
            inc esi
            ; Compara o endereco atual com o final de um string
            cmp byte ptr [esi], 0H
            ; Se nao for o final repete os passos
            jne meu_laco_cripto

    ; Escreve o arquivo de saida
    invoke WriteFile, fileHandleWrite, addr fileBuffer, readCount, addr writeCount, NULL

    ; Volta para leitura do arquivo
    jmp leitura_escrita_loop


; Realiza o deslocamento positivo do caractere
criptografia:
    add al, deslocamento
    jmp continuacao

; Realiza a descriptografia da string
descriptografia:
    sub al, deslocamento
    jmp continuacao


imprime_final:

    ; Imprime a ultima string
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov OutputHandle, eax
    invoke WriteConsole, OutputHandle, addr str_output_final, sizeof str_output_final, addr write_count, NULL    
    invoke ExitProcess, 0
 

finaliza_processo:   
    invoke ExitProcess, 0
       
end start