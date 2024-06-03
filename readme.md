# TP Orgenizacion del computador II

## Integrantes
* Evelin Aragon - eve_aragon@hotmail.com
* Franco Disabato - francodisabatobook@gmail.com

## Profesores
* Carloz Jimenez
* Alessia Katerina Lescano Horbik 

## Codigo

El codigo se divide en 2 partes.
* Codigo en main.c --> interaccion con el usuario.
* Codigo en operaciones.asm --> calculo de operaciones matematicas.

Durante la compilacion se linkea el codigo de c con el de assembler.

## main.c

Declaramos la funcion de asm que llamaremos desde c.
La misma recibe 2 numeros y 1 operador. Los operadores pueden ser `+` `-` `*` `/`

```c
extern int recibir_Operacion(int Operando1, char Operador, int Operando2);
```
Luego declaramos 2 funciones que usaremos en el codigo.

LeerPregunta() se le pasan las variables que contendran los input del usaurio y devolvera un resultado.

CalcularOperacion() se declara para poder encapsular a la funcion de asembler y llamarla localmente.

```c
void LeerPregunta(int *a, char *op, int *b);

int CalcularOperacion(int Operando1, char Operador, int Operando2) {
    return recibir_Operacion(Operando1, Operador, Operando2);
}
```

LeerPregunta() es utilizado para pedir al usuario que ingrese una operacion matematica siguiendo
el formato ´10 + 10´ por ejemplo.
Se valida que lo ingresado tenga el formato de `%d %c %d`, el cual significa `digito` `caracter``digito`. 
Si no cumple este formato, se le informa al usaurio con un mensaje de error y se vuelve a pedir que
ingrese el input con formato correcto.

Tambien da la opcion de cerrar el programa ingresando la letra `q`

```c
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
        printf("Formato invalido. Por favor intente nuevamente. \n");
        LeerPregunta(a, op, b);
    }
}
```

La funcion principal main() se encarga de declarar los int y char que se usaran para capturar el input del usuario.
Luego entra en un loop en el cual le pide al usaurio ingresar datos. Con estos datos se realizan validaciones
de casos borde.
* Si el usuario quiere salir del programa se espera la letra `q`.
* Si el usaurio intenta dividir por cero se devuelve un mensaje de error.
* Si pasa todas las validaciones se calcula la operacion en asembler y se devuelve el resultado por pantalla.

```c
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
        int result = CalcularOperacion(a, op, b);
        printf("%d %c %d = %d\n", a, op, b, result);
 
    }

    return 0;
}
```