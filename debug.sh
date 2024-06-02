nasm -f elf64 -g -F dwarf -o operaciones.o operaciones.asm;
gcc -c main.c -o main.o;
gcc -g -o program main.o operaciones.o
gdb ./program;
