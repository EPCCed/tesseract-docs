Using the Tesseract GPU Nodes
=============================

Tesseract has eight compute nodes equipped with GPGPU accelerators. This section of the user
guide explains how to compile code and submit jobs to the GPU nodes.

.. note::

        The GPU accelerators on Tesseract are only available in TCC (Tesla Compute Cluster)
        mode and so do not support graphics rendering tasks, only computational tasks.


Compiling software for the GPU nodes
------------------------------------

CUDA
~~~~

`CUDA <https://developer.nvidia.com/cuda-zone>`_ is a parallel computing platform and
programming model developed by NVIDIA for general computing on graphical processing units (GPUs).

To use the CUDA toolkit on Tesseract, you should load the `cuda` module:

::

   module load cuda

Once you have loaded the ``cuda`` module, you can access the CUDA compiler with the ``nvcc`` command.

As well as the CUDA compiler, you will also need a compiler module to support compilation of the
host (CPU) code. The CUDA toolkit supports GCC. You should load your
chosen compiler module before you compile.

.. note:: The ``nvcc`` compiler currently supports versions of GCC up to 7.x and does not support Intel compilers.

Using CUDA with GCC
^^^^^^^^^^^^^^^^^^^

By default, ``nvcc`` will use the system version of GCC. We recommend that you load a more
recent version of GCC than the system default to support the CUDA compiler, e.g.

::

   module load gcc

You can now use ``nvcc`` to compile your source code, e.g.:

::

   nvcc -o cuda_test.x cuda_test.cu


Submitting jobs to the GPU nodes
--------------------------------

One additional option is needed in GPU job submission scripts over those in standard jobs:

 * ``-q QGPU`` This option is required to submit the job to the ``gpu`` queue on Tesseract

.. note:: GPU compute nodes are only available in exclusive mode. This means your minimum 
request ia 1 GPU compute node with 24 CPU cores and 4 V100 GPU accelerators.

Job submission script using multiple GPUs on a single node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: Remember that there are a maximum of 4 GPU accelerators per node and a maximum of 24 CPU cores per node.

A job script that requires 1 GPU compute node (4 GPU accelerators and 24 CPU cores) for 20 minutes
could look like:

::

   #!/bin/bash
   #
   #PBS -N cuda_test
   #PBS -q QGPU
   #PBS -l select=1
   #PBS -l walltime=0:20:0
   # Budget: change 't01' to your budget code
   #PBS -A t01

   # Load the required modules
   module load cuda
   module load gcc

   cd $PBS_O_WORKDIR

   ./cuda_test.x

The line ``#PBS -l select=1`` requests 1 node and the line ``#PBS -q QGPU`` requests GPU compute nodes.
