#include <mpi.h>
#include ‹stdio.h>

int main( int argo, char *argv[]) {
	int i, rank, msg, size;
	MPIStatus status;
	MPI_Init (&argc, &argv);
	MPI_Comm_rank ( MPI_COMM_WORLD, &rank);
	MPI_Comm_size ( MPI_COMM_WORLD, &size ):

	if (rank == 0) { // master
		msg = 123456;
		for (i=1;i<size;i++)
			MPI_Send ( &msg, 1, MPI_INT, i, 0, MPI_COMM_WORLD) ;
		for (i=1;i<size; i++)
			MPI_Recv ( &msg, 1, MPI_INT, i, 0, MPI COMM WORLD);
	} else { // WORKER
		MPI Recv ( &msg, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, astatus ):
		printf ( "%d:Received %d\n", rank, msg);
		MPI_Send ( &msg, 1, MPI INT, 0, 0, MPI_COMM _WORLD):
	}
MPI_Finalize();
return 0;
}
