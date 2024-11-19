#include <stdio.h>

double f(double a) {
    return (4.0 / (1.0 + a * a));
}

int main() {
    double mypi = 0;
    int n = 1000000000; // number of points to compute
    float h = 1.0 / n;

    // Soma de Riemann para aproximar pi
    for (int i = 0; i < n; i++) {
        mypi = mypi + f(i * h);
    }

    // Multiplica pelo tamanho do intervalo para obter a aproximação final de pi
    mypi = mypi * h;

    // Imprime o valor de pi aproximado com 10 casas decimais
    printf("pi = %.10f\n", mypi);

    return 0;
}

