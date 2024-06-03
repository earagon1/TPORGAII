#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declaraciones de las funciones en ensamblador
extern int recibir_Operacion(int Operando1, char Operador, int Operando2);

void LeerPregunta(int *a, char *op, int *b);

int CalcularOperacion(int Operando1, char Operador, int Operando2) {
    return recibir_Operacion(Operando1, Operador, Operando2);
}

int main() {
    int a, b;
    char op;

    while (1) {
        LeerPregunta(&a, &op, &b);

        //chequear si el usuario quiere salir
        if(op == 'q'){
            break;
        }
        if(op == '/' && b == 0){
            printf("Error: no se permite dividir por 0. \n");
            continue;
        }
        if(op == 'f'){
            printf("Formato invalido. Por favor intente nuevamente. \n");
            continue;
        }
        if(op != '+' && op != '-' && op != '*' && op != '/'){
            printf("Operacion invalida. Por favor utilice una de las siguientes: + - * / \n");
            continue;
        }
        int result = CalcularOperacion(a, op, b);
        printf("%d %c %d = %d\n", a, op, b, result);
 
    }

    return 0;
}

void LeerPregunta(int *a, char *op, int *b) {
    char buffer [50];
    printf("Ingrese una operación aritmética (ej. 10 + 10) o 'q' para salir: ");
    fgets(buffer, sizeof(buffer), stdin);

    if (strcmp(buffer, "q\n") == 0){
        *op = 'q';
        return;
    }
    //parse the input
    if(sscanf(buffer, "%d %c %d", a, op, b) != 3){
        *op = 'f';
        return;
    }
}
