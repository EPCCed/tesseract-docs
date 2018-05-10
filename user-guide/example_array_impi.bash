#!/bin/bash --login

# PBS job options
#PBS -N ArrayJob
#PBS -l select=16
#PBS -l walltime=4:0:0
#PBS -l place=scatter
#PBS -J 1-56

# Replace [budget code] below with your project code (e.g. t01)
#PBS -A [budget code]

cd ${PBS_O_WORKDIR}

# Load any required modules
module load intel-tools-18

# Run with array index as the first argument to the executable
mpirun -n 1536 -ppn 24 ./my_mpi_executable.x $PBS_ARRAY_INDEX

