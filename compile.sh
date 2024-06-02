nasm -f elf64 -o operaciones.o operaciones.asm;
gcc -c main.c -o main.o;
gcc -o program main.o operaciones.o
./program;
