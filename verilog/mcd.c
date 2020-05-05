#include <stdio.h>
#include <stdlib.h>

int main(){
    int M, P, R;
    printf("INGRESE DOS NUMEROS ENTEROS: \n");
        scanf("%i%i", &M, &N);
    do {
        R = M%N;
        if (R!=0){
            M =P;
            P=R;
        }

    }while(R!=0);
    printf("Tu Maximo Comun Divisor es: %i\n", N);
    return 0;
}

