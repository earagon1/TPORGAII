#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declaraciones de las funciones en ensamblador
extern int recibir_Operacion(int Operando1, char Operador, int Operando2);

void LeerPregunta(char* pregunta) {
    printf("Ingrese una operación aritmética (ej. 10 + 10) o 'exit' para salir: ");
    fgets(pregunta, 100, stdin);
    pregunta[strcspn(pregunta, "\n")] = 0; // Remover el salto de línea
}

int CalcularOperacion(int Operando1, char Operador, int Operando2) {
    return recibir_Operacion(Operando1, Operador, Operando2);
}

int main() {
    char pregunta[100];

    while (1) {
        LeerPregunta(pregunta);

        // Si el usuario ingresa "exit", salir del bucle
        if (strcmp(pregunta, "exit") == 0) {
            printf("Saliendo del programa.\n");
            break;
        }

        // Separar la pregunta en operandos y operador usando strtok
        char* token = strtok(pregunta, " ");
        if (token == NULL) {
            printf("Lo siento, mis respuestas son limitadas.\n");
            continue;
        }
        int Operando1 = atoi(token);

        token = strtok(NULL, " ");
        if (token == NULL || strlen(token) != 1) {
            printf("Lo siento, mis respuestas son limitadas.\n");
            continue;
        }
        char Operador = token[0];

        token = strtok(NULL, " ");
        if (token == NULL) {
            printf("Lo siento, mis respuestas son limitadas.\n");
            continue;
        }
        int Operando2 = atoi(token);

        // Calcular la operación
        int resultado = CalcularOperacion(Operando1, Operador, Operando2);
        printf("El resultado es: %d\n", resultado);
    }

    return 0;
}
