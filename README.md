 (NASM) is an assembler and dissembler for the Intel x86 architecture and is commonly used to create 16-bit, 32-bit (IA-32) and 64-bit (x86-64) programs. 
 It is available on multiple operating systems like Linux or Windows, for example.
 An assemble will turn your low-level coding, using mnemonics, into machine language that can be understood by the processor. 

create an executable for Linux from NASM source code. 

Step 1. Create a source file

You can use any text editor to create your source file for NASM such as Sublime (favourite Editor),Atom, KWrite, or XEmacs. 

When you save your file, give it the extension .asm 

Step 2. Assemble the source file

For this step, you will need NASM software installed on your machine. If you're running Debian or Ubuntu, simply type the command:

`sudo apt-get install nasm`

If you have another Linux distribution, you must use your distribution's package manager (eg Urpmi, Yum, Emerge) or download NASM from the official site.

Use the following command line to assemble your source file:

`nasm -f elf test.asm`

In the example, the saved .asm file is called test.asm

This will create a file named test.o in the current directory. Note: This file is not executable - it is still an object file.

Step 3. Creating the executable

Now that we have our object file named test.o we must create our executable. 

Two cases are presented here:

1-Your program begins with a procedure called "_start". This means that your program has its own point of entry without the use of the main function. However, you'll need to use the "l" to create your executable:

`ld test.o -o test`

2-Your program begins with a procedure called "main". You will need to use gcc to create your executable:

`gcc test.o -o test`

`Note:` This Repository work in First Case

Our executable is created, it is tested and is in the current directory.

Step 4. Program Execution

To run the program called "test", just type this command:

`. / test `
