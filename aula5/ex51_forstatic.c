
#include <omp.h>
#include <stdio.h>

int main() {
    printf("master thread\n");
#pragma omp parallel num_threads(4)
#pragma omp for schedule(static,10)
    for(int i=0;i<100;i++) {
        int id = omp_get_thread_num();
        printf("T%d:i%d ", id, i);
   }
    printf("master thread\n");
}





