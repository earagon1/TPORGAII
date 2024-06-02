section .text
    global recibir_Operacion

recibir_Operacion:
    ; Guardar registros
    push rbp
    mov rbp, rsp
    push rbx

    ; Recibir parámetros
    mov ebx, edi         ; Operando1 en ebx
    mov al, sil          ; Operador en al (sil es el byte menos significativo de esi)
    mov ecx, edx         ; Operando2 en ecx

    ; Comparar el operador y saltar a la operación correspondiente
    ; Se puede usar los numeros de la tabla ascii o el caracter  
    cmp al, 43           ; Comparar con el valor ASCII de '+'
    je sum
    cmp al, 45           ; Comparar con el valor ASCII de '-'
    je res
    cmp al, 42           ; Comparar con el valor ASCII de '*'
    je mul
    cmp al, 47           ; Comparar con el valor ASCII de '/'
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
    ;Falta arreglar lo de la division por 0
    cmp ecx, 0
    je error
    mov eax, ebx         ; Mover Operando1 a eax (dividendo)
    xor edx, edx         ; Limpiar edx para la división
    div ecx              ; Dividir Operando1 entre Operando2
    ; El cociente está ahora en eax, el residuo en edx
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