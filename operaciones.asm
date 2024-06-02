section .text
    global recibir_Operacion

recibir_Operacion:
    ; Guardar registros
    push rbp
    mov rbp, rsp
    push rbx

    ; Recibir parámetros
    mov ebx, edi         ; Operando1 en ebx
    mov eax, esi         ; Operador en al
    mov ecx, edx         ; Operando2 en ecx

    ; Comparar el operador y saltar a la operación correspondiente
    cmp al, '+'
    je sum
    cmp al, '-'
    je res
    cmp al, '*'
    je mul
    cmp al, '/'
    je div

    ; Si no es un operador válido, devolver 0 y salir
    mov eax, 0
    jmp fin

sum:
    add ebx, ecx         ; Sumar Operando1 y Operando2
    mov eax, ebx         ; Guardar resultado en eax
    jmp fin

res:
    sub ebx, ecx         ; Restar Operando2 de Operando1
    mov eax, ebx         ; Guardar resultado en eax
    jmp fin

mul:
    imul ebx, ecx        ; Multiplicar Operando1 por Operando2
    mov eax, ebx         ; Guardar resultado en eax
    jmp fin

div:
    ; Evitar división por cero
    cmp ecx, 0
    je error
    mov eax, ebx         ; Mover Operando1 a eax (divisor)
    xor edx, edx         ; Limpiar edx para la división
    div ecx              ; Dividir Operando1 entre Operando2
    ; El cociente está ahora en eax, el resto en edx
    jmp fin

error:
    mov eax, 0           ; En caso de error, devolver 0
    jmp fin

fin:
    ; Restaurar registros y retornar
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
