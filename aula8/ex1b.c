#include <mpi.h>
#include <stdio.h>

int main( int argc, char *argv[]) {
        int size, rank, msg;
        MPI_Status status;
        MPI_Init(&argc, &argv);
        MPI_Comm_size( MPI_COMM_WORLD, &size); //da me o numero total de processos
	MPI_Comm_rank( MPI_COMM_WORLD, &rank ); // gets this process rank
	
        /* Process 0 sends and Process 1 receives */
        if (rank == 0) {
                msg = 123456;
                MPI_Send( &msg, 1, MPI_INT, rank +1, 0, MPI_COMM_WORLD);
        } // (buf, count, datatype, dest, tag, comm)
	else if(rank < size -1) {
                MPI_Recv( &msg, 1, MPI_INT, rank - 1, 0, MPI_COMM_WORLD, &status );
                MPI_Send( &msg, 1, MPI_INT, rank + 1, 0, MPI_COMM_WORLD);
                printf( "Received %d\n", msg);
        }
	else if(rank == size - 1) {
                MPI_Recv( &msg, 1, MPI_INT, rank - 1, 0, MPI_COMM_WORLD, &status );
                printf( "Received %d\n", msg);
}
MPI_Finalize();
return 0;
}










