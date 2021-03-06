Intel MKL: BLAS, LAPACK, ScaLAPACK
==================================

The Intel MKL libraries contain a variety of optimised numerical libraries 
including BLAS, LAPACK, and ScaLAPACK.

Intel Compilers
---------------

BLAS and LAPACK
~~~~~~~~~~~~~~~

To use MKL libraries with the Intel compilers you first need to load
the Intel tools module:

::

   module load intel-tools-18

To include MKL you specify the ``-mkl`` option on your compile and link lines.
For example, to compile a single source file, Fortran program with MKL you could use:

::

   ifort -c -mkl -o lapack_prb.o lapack_prb.f90
   ifort -mkl -o lapack_prb.x lapack_prb.o

The ``-mkl`` flag without any options builds against the threaded version of MKL.
If you wish to build against the serial version of MKL, you would use
``-mkl=sequential``.

ScaLAPACK
~~~~~~~~~

The distributed memory linear algebra routines in ScaLAPACK require MPI in addition
to the compilers and MKL libraries.

::

   module load intel-tools-18

Once you have the modules loaded you need to specify ``-mkl=cluster`` to build against
the MPI parallel version of MKL (including BLACS and ScaLAPACK). Remember to use the MPI versions of
the compilers:

::

   mpiifort -c -mkl=cluster -o linsolve.o linsolve.f90
   mpiifort -mkl=cluster -o linsolve.x linsolve.o

GNU Compiler
------------

BLAS and LAPACK
~~~~~~~~~~~~~~~

To use MKL libraries with the GNU compiler you first need to load the
Intel tools module:

::

   module load intel-tools-18

To include MKL you need to explicitly link against the MKL libraries.
For example, to compile a single source file, Fortran program with MKL you could use:

::

   gfortran -c -o lapack_prb.o lapack_prb.f90
   gfortran -o lapack_prb.x lapack_prb.o -L$MKLROOT/lib/intel64 -lmkl_gf_lp64 -lmkl_core -lmkl_sequential

This will build against the serial version of MKL, to build against the threaded version use:

::

   gfortran -c -o lapack_prb.o lapack_prb.f90
   gfortran -fopenmp -o lapack_prb.x lapack_prb.o -L$MKLROOT/lib/intel64 -lmkl_gf_lp64 -lmkl_core -lmkl_gnu_thread

ScaLAPACK
~~~~~~~~~

The distributed memory linear algebra routines in ScaLAPACK require MPI in addition
to the compilers and MKL libraries.

::

   module load intel-tools-18

Once you have the modules loaded you need to link against two additional libraries to include ScaLAPACK. 
Remember to use the MPI versions of the compilers for GCC:

::

   mpif90 -c -o linsolve.o linsolve.f90
   mpif90 -o linsolve.x linsolve.o -L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -ldl

ILP vs LP libraries
~~~~~~~~~~~~~~~~~~~

If you look in the *$MKLROOT/lib/intel64* directory then you will see ILP and LP libraries, in the above we were linking against the LP libraries and you can choose either. ILP use a 64 bit integer type, whereas LP use a 32 bit integer type. For very large arrays then ILP is the best choice (as it can index far more data), but there are some limitations. For more information `see the Intel documentation here <https://software.intel.com/en-us/node/528682>`__.

