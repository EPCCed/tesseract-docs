#!/bin/bash --login

# PBS job options (name, compute nodes, job time)
#PBS -N Example_MixedMode_Job
#PBS -l select=16
#PBS -l walltime=6:0:0
#PBS -l place=scatter

# Replace [budget code] below with your project code (e.g. t01)
#PBS -A [budget code]

# Change to the directory that the job was submitted from
cd $PBS_O_WORKDIR

# Load any required modules
module load intel-tools-18

# Set the number of threads to 12
#   There are 12 OpenMP threads per MPI process
export OMP_NUM_THREADS=12

# Set placement to support hybrid jobs
export I_MPI_PIN_DOMAIN=omp

# Launch the parallel job
#   Using 32 MPI processes
#   2 MPI processes per node
#   12 OpenMP threads per MPI process
mpirun -n 16 -ppn 2 ./my_mixed_executable.x arg1 arg2 > my_stdout.txt 2> my_stderr.txt

