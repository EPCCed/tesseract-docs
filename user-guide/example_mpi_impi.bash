#!/bin/bash --login

# PBS job options (name, compute nodes, job time)
#PBS -N Example_MPI_Job
# Select 16 full nodes
#PBS -l select=16
#PBS -l walltime=00:20:00
#PBS -l place=scatter

# Replace [budget code] below with your project code (e.g. t01)
#PBS -A [budget code]             

# Change to the directory that the job was submitted from
cd $PBS_O_WORKDIR
  
# Load any required modules
module load intel-tools-18

# Set the number of threads to 1
#   This prevents any threaded system libraries from automatically 
#   using threading.
export OMP_NUM_THREADS=1

# Launch the parallel job
#   Using 384 MPI processes and 24 MPI processes per node
mpirun -n 384 -ppn 24 ./my_mpi_executable.x arg1 arg2 > my_stdout.txt 2> my_stderr.txt
