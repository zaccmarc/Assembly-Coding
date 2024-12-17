Programa de Soma em Assembly
Descrição
Este projeto contém um programa simples escrito em Assembly (x86-64, NASM) que realiza a soma de dois números e exibe o resultado na tela. O objetivo é demonstrar conceitos básicos de manipulação de dados, chamadas de sistema (syscalls) e interação com o sistema operacional.

Estrutura do Código
soma.asm: Código fonte em Assembly.
README.md: Este arquivo de documentação.
Como Compilar e Executar
Requisitos
NASM (Netwide Assembler): Montador para código Assembly.
LD (Linker): Utilitário para linkar arquivos objeto.
Sistema Operacional Linux 64 bits: Ambiente para executar o programa.
Passo a Passo
Montar o Código Assembly:

Abra o terminal e navegue até o diretório onde o arquivo soma.asm está localizado. Execute o seguinte comando para montar o código Assembly em um arquivo objeto:

bash
Copy code
nasm -f elf64 soma.asm -o soma.o
Linkar o Arquivo Objeto:

Após a montagem bem-sucedida, linke o arquivo objeto para criar o executável:

bash
Copy code
ld -o soma soma.o
Executar o Programa:

Execute o programa recém-criado:

bash
Copy code
./soma
Saída Esperada:

makefile
Copy code
Resultado: 40
Funcionamento
O programa realiza as seguintes etapas:

Carregamento dos Números:

Carrega dois números (num1 e num2) definidos na seção .data para os registradores rax e rbx.
Soma:

Soma os valores em rax e rbx, armazenando o resultado em rax.
Armazenamento do Resultado:

Move o resultado da soma para uma variável na memória chamada resultado.
Impressão da Mensagem:

Utiliza a syscall write para imprimir a mensagem "Resultado: " no terminal.
Conversão do Resultado para String:

Converte o número binário armazenado em resultado para uma string decimal usando a função int_to_str.
Impressão do Resultado Convertido:

Utiliza a syscall write para imprimir a string resultante.
Adição de Nova Linha:

Adiciona uma nova linha para melhor formatação da saída.
Encerramento do Programa:

Utiliza a syscall exit para finalizar o programa.
Detalhes Técnicos
Seções do Programa
.data: Contém dados estáticos e inicializados, como números a serem somados, mensagens de texto e buffers para conversão de números.
.text: Contém o código executável do programa.
.bss: Reserva espaço para variáveis não inicializadas (não utilizado diretamente neste exemplo).
Funções
_start: Ponto de entrada do programa onde as operações principais são realizadas.
int_to_str: Função que converte um número inteiro em uma string decimal.
Chamadas de Sistema (Syscalls)
sys_write (1): Escreve dados no descritor de arquivo especificado (stdout).
sys_exit (60): Finaliza a execução do programa com um código de saída.
Componentes do Computador Utilizados
CPU (Unidade Central de Processamento): Executa as instruções Assembly e realiza operações aritméticas na ALU (Arithmetic Logic Unit).
Memória RAM: Armazena o código, dados e resultados temporários durante a execução do programa.
Sistema Operacional: Gerencia as chamadas de sistema e a interação com dispositivos de E/S.
Dispositivos de Entrada/Saída (E/S): Terminal para exibir a saída do programa.
Funcionamento Detalhado por de Baixo dos Panos
1. Carregamento e Organização do Programa
Quando você executa o programa, o sistema operacional (SO) carrega o executável na memória RAM e prepara o ambiente para a execução. O programa é organizado em diferentes seções:

.data: Armazena dados estáticos como números a serem somados e mensagens de texto.
.text: Contém o código executável do programa.
2. Execução das Instruções
Vamos analisar cada instrução e como ela interage com os componentes do computador:

2.1. Carregamento dos Números
asm
Copy code
mov rax, [num1]   ; rax = num1
mov rbx, [num2]   ; rbx = num2
Ação: Carrega os valores armazenados em num1 e num2 para os registradores rax e rbx, respectivamente.
Por de Baixo dos Panos:
CPU: Lê a instrução mov e move os dados da memória para os registradores.
RAM: Retorna os valores (15 e 25) para a CPU.
2.2. Soma dos Números
asm
Copy code
add rax, rbx      ; rax = rax + rbx
Ação: Soma os valores em rax e rbx, armazenando o resultado em rax.
Por de Baixo dos Panos:
ALU: Realiza a operação aritmética de adição.
Resultado: rax agora contém 40.
2.3. Armazenamento do Resultado
asm
Copy code
mov [resultado], rax
Ação: Move o valor de rax (40) para a variável resultado na memória.
Por de Baixo dos Panos:
CPU: Move o dado de um registrador para a memória.
RAM: Atualiza o valor de resultado para 40.
2.4. Impressão da Mensagem "Resultado: "
asm
Copy code
mov rax, 1                            ; syscall: sys_write
mov rdi, 1                            ; file descriptor: stdout
mov rsi, msg_result                   ; endereço da mensagem
mov rdx, msg_len                      ; comprimento da mensagem
syscall                               ; chamada de sistema
Objetivo: Usar a syscall write para imprimir "Resultado: " no terminal.
Por de Baixo dos Panos:
Configuração dos Registradores:
rax = 1: Número da syscall para write.
rdi = 1: Descritor de arquivo para stdout.
rsi = msg_result: Endereço da mensagem "Resultado: ".
rdx = msg_len: Tamanho da mensagem.
Execução da syscall:
Interrupção do Sistema: Transição do modo usuário para modo kernel.
Kernel: Processa a syscall e escreve a mensagem no terminal.
Retorno ao Modo Usuário: Controle retorna ao programa.
2.5. Conversão do Resultado para String
asm
Copy code
mov rax, [resultado]                  ; carregar o resultado novamente
mov rsi, buffer                       ; buffer para a string
call int_to_str                       ; converter inteiro para string
Objetivo: Converter o número 40 armazenado em resultado para a string "40" para exibição.
Por de Baixo dos Panos:
Carregamento do Resultado: Move o valor de resultado para rax.
Preparação do Buffer: Define rsi para apontar para o buffer onde a string será armazenada.
Chamada da Função int_to_str: Salva o endereço de retorno na pilha e transfere o controle para a função.
Função int_to_str
asm
Copy code
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
Objetivo da Função:

Entrada:
rax: Número inteiro a ser convertido (40).
rsi: Endereço do buffer onde a string será armazenada.
Saída:
rsi: Buffer contendo a string do número ("40").
rbx: Comprimento da string (2).
Processo:

Extração dos Dígitos:

Divide o número por 10, obtendo o quociente e o resto.
Converte o resto para seu equivalente ASCII ('0' a '9').
Armazena o caractere no buffer.
Continua até que o quociente seja zero.
Exemplo:
40 ÷ 10 = 4 (quociente), resto = 0 → '0'
4 ÷ 10 = 0 (quociente), resto = 4 → '4'
Buffer após convert_loop: "04" (em ordem reversa).
Inversão da String:

Inverte a ordem dos caracteres no buffer para obter "40".
Utiliza dois ponteiros (rdi e rdx) para trocar os caracteres de início e fim, movendo-se para o centro.
Resultado Final: "40" no buffer.
Retorno:

ret: Retorna ao ponto onde a função foi chamada, com rbx contendo o comprimento da string (2).
2.6. Impressão do Resultado Convertido
asm
Copy code
mov rax, 1                            ; syscall: sys_write
mov rdi, 1                            ; file descriptor: stdout
mov rsi, buffer                       ; endereço do buffer com a string
mov rdx, rbx                          ; rbx contém o comprimento da string após a conversão
syscall                               ; chamada de sistema
Objetivo: Imprimir a string "40" na saída padrão.
Por de Baixo dos Panos:
Configuração dos Registradores:
rax = 1: Número da syscall para write.
rdi = 1: Descritor de arquivo para stdout.
rsi = buffer: Endereço da string "40".
rdx = rbx: Comprimento da string (2).
Execução da syscall:
Interrupção do Sistema: Transição do modo usuário para modo kernel.
Kernel: Processa a syscall e escreve a string no terminal.
Retorno ao Modo Usuário: Controle retorna ao programa.
2.7. Adição de Nova Linha
asm
Copy code
mov rax, 1                            ; syscall: sys_write
mov rdi, 1                            ; file descriptor: stdout
mov rsi, newline                      ; endereço da nova linha
mov rdx, 1                            ; comprimento da nova linha
syscall                               ; chamada de sistema
Objetivo: Adicionar uma quebra de linha após o resultado para melhorar a formatação da saída.
Por de Baixo dos Panos:
Similar às chamadas anteriores, mas escreve o caractere de nova linha (\n, ASCII 10).
2.8. Encerramento do Programa
asm
Copy code
mov rax, 60                           ; syscall: sys_exit
xor rdi, rdi                          ; código de saída: 0
syscall                               ; chamada de sistema
Objetivo: Terminar a execução do programa de forma ordenada.
Por de Baixo dos Panos:
Configuração dos Registradores:
rax = 60: Número da syscall para exit.
rdi = 0: Código de saída (0 indica sucesso).
Execução da syscall:
Interrupção do Sistema: Solicita ao SO que termine o processo.
Kernel: Finaliza o programa, liberando recursos.
Componentes do Computador Utilizados
1. CPU (Unidade Central de Processamento)
Execução de Instruções: A CPU busca, decodifica e executa cada instrução Assembly sequencialmente.
Registradores: Utiliza registradores (rax, rbx, rcx, etc.) para armazenar dados temporários e resultados intermediários durante a execução do programa.
ALU (Arithmetic Logic Unit): Realiza operações aritméticas e lógicas, como a soma de números.
2. Memória RAM
Armazenamento de Código e Dados: O código Assembly e os dados definidos nas seções .data e .bss são carregados na RAM durante a execução.
Acesso Rápido: Permite que a CPU leia e escreva dados rapidamente durante a execução do programa.
3. Sistema Operacional (SO)
Gerenciamento de Processos: Carrega o executável na RAM, gerencia a execução do processo e aloca recursos como tempo de CPU e memória.
Chamadas de Sistema (syscall): Interface entre o programa e o kernel, permitindo que o programa solicite serviços como leitura/escrita em arquivos e interação com dispositivos de E/S.
Interrupções e Exceções: Gerencia interrupções de hardware e exceções de software, garantindo a estabilidade e segurança do sistema.
4. Dispositivos de Entrada/Saída (E/S)
Terminal (stdout): A saída do programa é enviada para o terminal via descritor de arquivo stdout (1).
Drivers de Dispositivos: O SO utiliza drivers para comunicar-se com dispositivos de E/S, traduzindo as chamadas de sistema em operações de hardware.
Depuração
Para depurar o programa, utilize o GDB (GNU Debugger):

Instalar o GDB:

bash
Copy code
sudo apt install gdb
Iniciar o GDB com o Executável:

bash
Copy code
gdb ./soma
Comandos Úteis do GDB:

break _start: Define um ponto de interrupção no início do programa.
run: Executa o programa até o próximo ponto de interrupção.
stepi: Executa uma instrução Assembly por vez.
print /x $rax: Imprime o valor do registrador rax em hexadecimal.
quit: Sai do GDB.
Recursos Adicionais
Documentação do NASM:

NASM Official Documentation
Tutoriais e Livros:

"Programming from the Ground Up" de Jonathan Bartlett: Excelente para iniciantes.
"The Art of Assembly Language" de Randall Hyde: Referência mais avançada.
"The Definitive Guide to ARM® Cortex®-M3 and Cortex®-M4 Processors" de Joseph Yiu: Embora focado em ARM, oferece insights sobre Assembly.
Ferramentas de Depuração:

GDB (GNU Debugger): Para depurar programas Assembly.
Valgrind: Para verificar gerenciamento de memória.
Cursos Online:

Coursera, edX, Udemy: Muitas plataformas oferecem cursos de Assembly e arquitetura de computadores.
Considerações Finais
Desenvolver programas em Assembly proporciona um entendimento profundo de como os computadores funcionam a nível fundamental. Este projeto serve como um exemplo introdutório, demonstrando como realizar operações básicas, manipular dados na memória e interagir com o sistema operacional através de chamadas de sistema.

Pontos Chave:
Controle do Hardware: Assembly permite interagir diretamente com registradores, memória e dispositivos de E/S.
Eficiência: Programas em Assembly podem ser extremamente eficientes, mas requerem um gerenciamento meticuloso dos recursos.
Complexidade: A programação em Assembly é mais complexa e propensa a erros comparada a linguagens de alto nível.
Educação: Estudar Assembly é excelente para aprender sobre a arquitetura de computadores e conceitos de baixo nível.
Continue praticando e explorando os diversos aspectos da programação em Assembly para aprimorar suas habilidades e aprofundar seu entendimento sobre o funcionamento interno dos computadores!

Autor
Nome: [Seu Nome]
Contato: [Seu Email ou GitHub]