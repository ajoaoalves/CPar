#include<stdio.h>
#include<stdlib.h>

#ifndef size
#define size 512
#endif

double *A, *B, *C;

void alloc() {
    A = (double *) malloc(size*size*sizeof(double));
    B = (double *) malloc(size*size*sizeof(double));
    C = (double *) malloc(size*size*sizeof(double));
}

void init() {
    for(int i=0; i<size; i++) {
        for(int j=0; j<size; j++) {
            A[i*size+j] = rand();
            B[i*size+j] = rand();
            C[i*size+j] = 0;
        }
    }
}

void mmult() {
    for(int i=0; i<size; i++) {
        for(int j=0; j<size; j++) {
            for(int k=0; k<size; k++) {
                C[i*size+j] += A[i*size+k] * B[j*size+k];
            }
	}
    }
}

int main() {
    alloc();
    init();
    mmult();

    printf("%f\n", C[size/2+5]);
}

