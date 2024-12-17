# Programa de Soma em Assembly

## Descrição
Este projeto contém um programa simples escrito em **Assembly** (x86-64, NASM) que realiza a **soma de dois números** e exibe o resultado na tela. O objetivo é demonstrar conceitos básicos de manipulação de dados, chamadas de sistema (**syscalls**) e interação com o sistema operacional.

## Estrutura do Código
- **soma.asm**: Código fonte em Assembly.
- **README.md**: Este arquivo de documentação.

## Como Compilar e Executar

### Requisitos
- **NASM** (Netwide Assembler): Montador para código Assembly.
- **LD** (Linker): Utilitário para linkar arquivos objeto.
- **Sistema Operacional Linux 64 bits**: Ambiente para executar o programa.

### Passo a Passo

#### 1. Montar o Código Assembly:
Abra o terminal e navegue até o diretório onde o arquivo `soma.asm` está localizado. Execute o seguinte comando para montar o código Assembly em um arquivo objeto:

```bash
nasm -f elf64 soma.asm -o soma.o
```

#### 2. Linkar o Arquivo Objeto:
Após a montagem bem-sucedida, linke o arquivo objeto para criar o executável:

```bash
ld -o soma soma.o
```

#### 3. Executar o Programa:
Execute o programa recém-criado:

```bash
./soma
```

#### Saída Esperada:
```
Resultado: 40
```

---

## Funcionamento
O programa realiza as seguintes etapas:

### 1. Carregamento dos Números:
- Carrega dois números (**num1** e **num2**) definidos na seção `.data` para os registradores `rax` e `rbx`.

### 2. Soma:
- Soma os valores em `rax` e `rbx`, armazenando o resultado em `rax`.

### 3. Armazenamento do Resultado:
- Move o resultado da soma para uma variável na memória chamada `resultado`.

### 4. Impressão da Mensagem:
- Utiliza a syscall **write** para imprimir a mensagem "Resultado: " no terminal.

### 5. Conversão do Resultado para String:
- Converte o número binário armazenado em `resultado` para uma string decimal usando a função `int_to_str`.

### 6. Impressão do Resultado Convertido:
- Utiliza a syscall **write** para imprimir a string resultante.

### 7. Adição de Nova Linha:
- Adiciona uma nova linha para melhor formatação da saída.

### 8. Encerramento do Programa:
- Utiliza a syscall **exit** para finalizar o programa.

---

## Detalhes Técnicos

### Seções do Programa
- **.data**: Contém dados estáticos e inicializados, como números a serem somados, mensagens de texto e buffers para conversão de números.
- **.text**: Contém o código executável do programa.
- **.bss**: Reserva espaço para variáveis não inicializadas (não utilizado diretamente neste exemplo).

### Funções
- **_start**: Ponto de entrada do programa onde as operações principais são realizadas.
- **int_to_str**: Função que converte um número inteiro em uma string decimal.

### Chamadas de Sistema (Syscalls)
- **sys_write (1)**: Escreve dados no descritor de arquivo especificado (**stdout**).
- **sys_exit (60)**: Finaliza a execução do programa com um código de saída.

---

## Depuração
Para depurar o programa, utilize o **GDB** (GNU Debugger):

#### 1. Instalar o GDB:
```bash
sudo apt install gdb
```

#### 2. Iniciar o GDB com o Executável:
```bash
gdb ./soma
```

#### Comandos Úteis do GDB:
- **break _start**: Define um ponto de interrupção no início do programa.
- **run**: Executa o programa até o próximo ponto de interrupção.
- **stepi**: Executa uma instrução Assembly por vez.
- **print /x $rax**: Imprime o valor do registrador `rax` em hexadecimal.
- **quit**: Sai do GDB.

---

## Recursos Adicionais

### Documentação do NASM:
- [NASM Official Documentation](https://nasm.us/doc/)

### Tutoriais e Livros:
- *Programming from the Ground Up* - Jonathan Bartlett
- *The Art of Assembly Language* - Randall Hyde

### Ferramentas de Depuração:
- **GDB**: Depuração de programas Assembly.
- **Valgrind**: Verifica o gerenciamento de memória.

---

## Considerações Finais
Desenvolver programas em Assembly proporciona um entendimento profundo de como os computadores funcionam a nível fundamental. Este projeto serve como um exemplo introdutório, demonstrando como realizar operações básicas, manipular dados na memória e interagir com o sistema operacional através de chamadas de sistema.

### Pontos Chave:
- **Controle do Hardware**: Assembly permite interagir diretamente com registradores, memória e dispositivos de E/S.
- **Eficiência**: Programas em Assembly podem ser extremamente eficientes, mas exigem um gerenciamento meticuloso dos recursos.
- **Complexidade**: A programação em Assembly é mais complexa e propensa a erros comparada a linguagens de alto nível.
- **Educação**: Estudar Assembly é excelente para aprender sobre a arquitetura de computadores e conceitos de baixo nível.
