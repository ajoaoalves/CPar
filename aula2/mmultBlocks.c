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
    int block_size=64;

    for(int i_block=0; i_block<size; i_block += block_size) {
        for(int j_block=0; j_block<size; j_block += block_size) {
            for(int k_block=0; k_block<size; k_block += block_size) {
                
          	for (int i = i_block; i < i_block + block_size && i < size; i++) {
            	    for (int j = j_block; j < j_block + block_size && j < size; j++) {
                        for (int k = k_block; k < k_block + block_size && k < size; k++) {
				
				C[i*size+j] += A[i*size+k] * B[k*size+j];



            }
	}
    }
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


