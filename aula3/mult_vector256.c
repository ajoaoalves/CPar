#include <stdio.h>
#include <stdlib.h>

#ifndef size
#define size 512
#endif

double A[size*size] __attribute__((aligned(32)));
double B[size*size] __attribute__((aligned(32)));
double C[size*size] __attribute__((aligned(32)));

void init() {
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++) {
            A[i * size + j] = rand() / (double)RAND_MAX; // Use valores entre 0 e 1
            B[i * size + j] = rand() / (double)RAND_MAX;
            C[i * size + j] = 0.0;
        }
    }
}

void mmult() {
    for(int i = 0; i < size; i++) {
        for(int j = 0; j < size; j++) {
            for(int k = 0; k < size; k++) {
                C[i * size + j] += A[i * size + k] * B[k * size + j];
            }
        }
    }
}

int main() {
    init();
    mmult();
    printf("%f\n", C[size/2 + 5]);
    return 0;
}

