section .data
    num1        dq 15                   ; Primeiro número (15)
    num2        dq 25                   ; Segundo número (25)
    resultado   dq 0                    ; Espaço para armazenar o resultado

    msg_result  db "Resultado: ", 0      ; Mensagem para exibir antes do resultado
    msg_len     equ $ - msg_result      ; Comprimento da mensagem

    ; Definição para a conversão do número para string
    buffer      times 20 db 0            ; Buffer para armazenar a string do número

section .text
    global _start

_start:
    ; Carregar num1 e num2 nos registradores
    mov rax, [num1]                       ; rax = num1
    mov rbx, [num2]                       ; rbx = num2

    ; Somar os dois números
    add rax, rbx                          ; rax = rax + rbx

    ; Armazenar o resultado na memória
    mov [resultado], rax

    ; Preparar para imprimir a mensagem "Resultado: "
    mov rax, 1                            ; syscall: sys_write
    mov rdi, 1                            ; file descriptor: stdout
    mov rsi, msg_result                   ; endereço da mensagem
    mov rdx, msg_len                      ; comprimento da mensagem
    syscall                               ; chamada de sistema

    ; Converter o número para string
    mov rax, [resultado]                  ; carregar o resultado novamente
    mov rsi, buffer                       ; buffer para a string
    call int_to_str                       ; converter inteiro para string

    ; Preparar para imprimir o resultado convertido
    mov rax, 1                            ; syscall: sys_write
    mov rdi, 1                            ; file descriptor: stdout
    mov rsi, buffer                       ; endereço do buffer com a string
    mov rdx, rbx                          ; rbx contém o comprimento da string após a conversão
    syscall                               ; chamada de sistema

    ; Adicionar uma nova linha
    mov rax, 1                            ; syscall: sys_write
    mov rdi, 1                            ; file descriptor: stdout
    mov rsi, newline                      ; endereço da nova linha
    mov rdx, 1                            ; comprimento da nova linha
    syscall                               ; chamada de sistema

    ; Sair do programa
    mov rax, 60                           ; syscall: sys_exit
    xor rdi, rdi                          ; código de saída: 0
    syscall                               ; chamada de sistema

;---------------------------------------------------
; Função: int_to_str
; Descrição: Converte um número inteiro (em rax) para uma string decimal.
; Entrada:
;   - rax: número a ser convertido
;   - rsi: endereço do buffer para armazenar a string
; Saída:
;   - rsi: endereço do buffer com a string
;   - rbx: comprimento da string
;---------------------------------------------------
int_to_str:
    mov rcx, 0                            ; contador de dígitos
    mov rdx, 0                            ; limpar rdx para a divisão
    mov rbx, 10                           ; divisor para extrair dígitos

convert_loop:
    xor rdx, rdx                          ; limpar rdx antes da divisão
    div rbx                               ; dividir rax por 10, quociente em rax, resto em rdx
    add rdx, '0'                          ; converter resto para caractere ASCII
    mov [rsi + rcx], dl                   ; armazenar o dígito no buffer
    inc rcx                               ; incrementar contador
    cmp rax, 0
    jne convert_loop                      ; continuar se o quociente não for zero

    ; Inverter a string para a ordem correta
    mov rdi, rsi                          ; endereço inicial
    mov rsi, rsi                          ; endereço inicial
    mov rdx, rcx                          ; comprimento da string

    ; Subtrair 1 para obter o índice correto
    dec rdx
    mov rbx, rcx                          ; salvar comprimento original

    ; Início do loop de inversão
reverse_loop:
    cmp rcx, rdx
    jge reverse_done                      ; sair se todos os caracteres forem invertidos

    ; Trocar caracteres
    mov al, [rdi]                         ; carregar caractere da esquerda
    mov bl, [rsi + rdx]                   ; carregar caractere da direita
    mov [rdi], bl                         ; trocar para a esquerda
    mov [rsi + rdx], al                   ; trocar para a direita

    inc rdi                               ; mover para a próxima posição da esquerda
    dec rdx                               ; mover para a próxima posição da direita
    jmp reverse_loop                      ; repetir

reverse_done:
    ; Atualizar rbx com o comprimento da string
    mov rbx, rcx                          ; rbx = número de dígitos
    ret                                   ; retornar da função

section .data
    newline db 10                         ; caractere de nova linha
