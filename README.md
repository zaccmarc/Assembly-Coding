# Sum program in Assembly

## Description
This project contains a simple program written in **Assembly** (x86-64, NASM) that performs the **sum of two numbers** and displays the result on the screen. The aim is to demonstrate basic concepts of data manipulation, system calls (**syscalls**) and interaction with the operating system.

## Code Structure
- **soma.asm**: Assembly source code.
- **README.md**: This documentation file.

## How to Compile and Run

### Requirements
- **NASM** (Netwide Assembler): Assembler for Assembly code.
- **LD** (Linker): Utility for linking object files.
- Linux 64-bit operating system: Environment for running the program.

### Step by Step

#### 1. Assemble the Assembly Code:
Open the terminal and navigate to the directory where the `soma.asm` file is located. Run the following command to assemble the assembly code into an object file:

```bash
nasm -f elf64 soma.asm -o soma.o
```

#### 2. Link the Object File:
After successful assembly, link the object file to create the executable:

```bash
ld -o soma soma.o
```

#### 3. Run the Program:
Run the newly created program:

```bash
./sum
```
#### Expected output:
```
Result: 40
```
---

## How it works
The program performs the following steps:

### 1. Loading the Numbers:
- Loads two numbers (**num1** and **num2**) defined in the `.data` section into the `rax` and `rbx` registers.

### 2. Sum:
- Sums the values in `rax` and `rbx`, storing the result in `rax`.

### 3. Storing the Result:
- Moves the result of the sum to a variable in memory called `result`.

### 4. Printing the Message:
- Uses the **write** syscall to print the message “Result: ” on the terminal.

### 5. converting the result to a string:
- Converts the binary number stored in `result` to a decimal string using the `int_to_str` function.

### 6. Printing the Converted Result:
- Uses the **write** syscall to print the resulting string.

### 7. Adding a New Line:
- Adds a new line for better formatting of the output.

### 8. Closing the Program:
- Uses the **exit** syscall to end the program.

---

## Technical Details

### Program sections
- **.data**: Contains static and initialized data, such as numbers to be summed, text messages and buffers for converting numbers.
- **.text**: Contains the program's executable code.
- **.bss**: Reserves space for uninitialized variables (not used directly in this example).

### Functions
- **_start**: Entry point of the program where the main operations are performed.
- **int_to_str**: Function that converts an integer into a decimal string.

### Syscalls
- **sys_write (1)**: Writes data to the specified file descriptor (**stdout**).
- **sys_exit (60)**: Ends program execution with an exit code.

---

## Debugging
To debug the program, use **GDB** (GNU Debugger):

#### 1. Install GDB:
```bash
sudo apt install gdb
```

#### 2. Start GDB with the Executable:
```bash
gdb ./soma
```

#### Useful GDB commands:
- **break _start**: Sets a breakpoint at the start of the program.
- **run**: Runs the program until the next breakpoint.
- **stepi**: Executes one Assembly statement at a time.
- **print /x $rax**: Prints the value of the `rax` register in hexadecimal.
- **quit**: Exits GDB.

---

## Additional Features

### NASM documentation:
- [NASM Official Documentation](https://nasm.us/doc/)

### Tutorials and Books:
- *Programming from the Ground Up* - Jonathan Bartlett
- The Art of Assembly Language - Randall Hyde

### Debugging tools:
- **GDB**: Debugging Assembly programs.
- **Valgrind**: Checks memory management.

---

## Final considerations
Developing programs in Assembly provides an in-depth understanding of how computers work at a fundamental level. This project serves as an introductory example, demonstrating how to perform basic operations, manipulate data in memory and interact with the operating system through system calls.

### Key Points:
- Hardware control: Assembly allows you to interact directly with registers, memory and I/O devices.
- Efficiency: Assembly programs can be extremely efficient, but require meticulous resource management.
- Complexity: Assembly programming is more complex and error-prone compared to high-level languages.
- Education**: Studying Assembly is excellent for learning about computer architecture and low-level concepts.
