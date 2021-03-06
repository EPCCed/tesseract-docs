Application Development Environment
===================================

The application development environment on Tesseract is primarily
controlled through the *modules* environment. By loading and switching
modules you control the compilers, libraries and software available.

This means that for compiling on Tesseract you typically set the compiler
you wish to use using the appropriate modules, then load all the
required library modules (e.g. numerical libraries, IO format libraries).

Additionally, if you are compiling parallel applications using MPI 
(or SHMEM, etc.) then you will need to load the MPI environment
and use the appropriate compiler wrapper scripts.

By default, all users on Tesseract start with no modules loaded.

Basic usage of the ``module`` command on Tesseract is covered below. For
full documentation please see:

-  `Linux manual page on modules <http://linux.die.net/man/1/module>`__

Using the modules environment
-----------------------------

Information on the available modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Finding out which modules (and hence which compilers, libraries and
software) are available on the system is performed using the
``module avail`` command:

::

    [user@tesseract-login1 ~]$ module avail
    ...

This will list all the names and versions of the modules available on
the service. Not all of them may work in your account though due to,
for example, licencing restrictions. You will notice that for many
modules we have more than one version, each of which is identified by a
version number. One of these versions is the default. As the
service develops the default version will change.

You can list all the modules of a particular type by providing an
argument to the ``module avail`` command. For example, to list all
available versions of the Intel libraries, compilers and tools:

::

    [user@tesseract-login1 ~]$ module avail intel

    ------------------------------ /tessfs1/sw/modulefiles -------------------------------
    intel-cc-18/18.1.163    intel-fc-18/18.1.163    intel-tools-18
    intel-cmkl-18/18.1.163  intel-mpi-18/18.1.163   intel-vtune-18/18.1.163
 

If you want more info on any of the modules, you can use the
``module help`` command:

::

   [user@tesseract-login1 ~]$ module help intel-cmkl-18/18.1.163 

   ----------- Module Specific Help for 'intel-cmkl-18/18.1.163' ---------------------------

   Sets up the paths for Intel Cluster Math Kernal Library 18.1.163

The simple ``module list`` command will give the names of the modules
and their versions you have presently loaded in your envionment:

::

   [user@tesseract-login1 ~]$ module list
   Currently Loaded Modulefiles:
     1) intel-cc-18/18.1.163      4) intel-mpi-18/18.1.163
     2) intel-fc-18/18.1.163      5) intel-vtune-18/18.1.163
     3) intel-cmkl-18/18.1.163    6) intel-tools-18

Loading, unloading and swapping modules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To load a module to use ``module add`` or ``module load``. For example,
to load the Intel Fortran compilers into the development environment:

::

    module load intel-fc-18

This will load the default version of the intel fortran compilers. If
you need a specfic version of the module, you can add more information:

::

    module load intel-fc-18/18.1.163

will load version 18.1.163 for you, regardless of the default. If you
want to clean up, ``module remove`` will remove a loaded module:

::

    module remove intel-fc-18

(or ``module rm intel-fc-18`` or
``module unload intel-fc-18``) will unload what ever version of
intel-fc-17 (even if it is not the default) you might have
loaded. There are many situations in which you might want to change the
presently loaded version to a different one, such as trying the latest
version which is not yet the default or using a legacy version to keep
compatibility with old data. This can be achieved most easily by using 
``module swap oldmodule newmodule``. 

Available Compiler Suites
-------------------------

.. note::
   As Tesseract uses dynamic linking by default you will generally also need
   to load any modules you used to compile your code in your job submission
   script when you run your code.

Intel Compiler Suite
~~~~~~~~~~~~~~~~~~~~

The Intel compiler suite is accessed by loading the ``intel-tools-*`` module. For example:

::

    module load intel-tools-18

Once you have loaded the module, the compilers are available as:

* ``ifort`` - Fortran
* ``icc`` - C
* ``icpc`` - C++

GCC Compiler Suite
~~~~~~~~~~~~~~~~~~

The GCC 4.8.5 compiler suite is available by default without loading any modules.

The compilers are available as:

* ``gfortran`` - Fortran
* ``gcc`` - C
* ``g++`` - C++

Compiling MPI codes
-------------------

Tesseract currently supports the Intel MPI library.

You should also consult the chapter on running jobs through the batch system
for examples of how to run jobs compiled against MPI.

.. note::
   By default, all compilers produce dynamic executables on
   Tesseract. This means that you must load the same modules at runtime (usually
   in your job submission script) as you have loaded at compile time.

Using Intel MPI
~~~~~~~~~~~~~~~

To compile MPI code with Intel MPI, using any compiler, you must first load the
"intel-mpi-18" module:

::

   module load intel-mpi-18

(If you loaded the ``intel-tools-18`` module then this automatically loads the Intel
MPI module for you.)

This makes the compiler wrapper scripts available to you. The name of the  wrapper
script depends on the compiler suite you are using. In summary:

+----------+----------+--------+
| Language | Intel    | GCC    |
+==========+==========+========+
| Fortran  | mpiifort | mpif90 |
+----------+----------+--------+
| C++      | mpiicpc  | mpicxx |
+----------+----------+--------+
| C        | mpiicc   | mpicc  |
+----------+----------+--------+

Further details on using the different compiler suites with Intel MPI are available
in the following sections.

Using Intel Compilers and Intel MPI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You should make the Intel compilers and MPI environment available by loading the 
``intel-tools-18`` module:

::

    module load intel-tools-18

MPI compilers are then available as

* ``mpiifort`` - Fortran with MPI
* ``mpiicc`` - C with MPI
* ``mpiicpc`` - C++ with MPI

.. note::
   Intel compilers with Intel MPI use non-standard compiler wrapper script names.
   If you use the standard names you will end up using the GCC compilers.

Using GCC Compilers and Intel MPI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Once you have loaded the ``intel-tools-18`` module, MPI compilers are then available as

* ``mpif90`` - Fortran with MPI
* ``mpicc`` - C with MPI
* ``mpicxx`` - C++ with MPI


Compiler Information and Options
--------------------------------

Help is available for the different compiler suites

GCC
    Fortran ``gfortran --help`` ,
    C/C++ ``gcc --help``
Intel
    Fortran ``man ifort`` ,
    C/C++ ``man icc``

Useful compiler options
~~~~~~~~~~~~~~~~~~~~~~~

.. note::
   For best performance on Tesseract we currently advise that you should use the
   Intel compilers wherever possible as the version of GCC available on the system is
   very old. We aim to install a more up to date version of GCC soon.

Whilst difference codes will benefit from compiler optimisations in
different ways, for reasonable performance on Tesseract, at least
initially, we suggest the following compiler options:

Intel
    ``-O2``
GNU
    ``-O2 -ftree-vectorize -funroll-loops -ffast-math``

When you have a application that you are happy is working correctly and has
reasonable performance you may wish to investigate some more aggressive
compiler optimisations. Below is a list of some further optimisations
that you can try on your application (Note: these optimisations may
result in incorrect output for programs that depend on an exact
implementation of IEEE or ISO rules/specifications for math functions):

Intel
    ``-fast``
GNU
    ``-Ofast -funroll-loops``

Vectorisation, which is one of the important compiler optimisations for
Tesseract, is enabled by default as follows:

Intel
    At ``-O2`` and above
GNU
    At ``-O3`` and above or when using ``-ftree-vectorize``

To promote integer and real variables from four to eight byte precision
for Fortran codes the following compiler flags can be used:

Intel
    ``-real-size 64 -integer-size 64 -xAVX``
    (Sometimes the Intel compiler incorrectly generates AVX2
    instructions if the ``-real-size 64`` or ``-r8`` options are set.
    Using the ``-xAVX`` option prevents this.)
GNU
    ``-freal-4-real-8 -finteger-4-integer-8``

Using static linking/libraries
-------------------------------

By default, executables on Tesseract are built using shared/dynamic libraries 
(that is, libraries which are loaded at run-time as and when
needed by the application) when using the wrapper scripts. 

An application compiled this way to use shared/dynamic libraries will
use the default version of the library installed on the system (just
like any other Linux executable), even if the system modules were set
differently at compile time. This means that the application may
potentially be using slightly different object code each time the
application runs as the defaults may change. This is usually the desired
behaviour for many applications as any fixes or improvements to the
default linked libraries are used without having to recompile the
application, however some users may feel this is not the desired
behaviour for their applications.

Alternatively, applications can be compiled to use static
libraries (i.e. all of the object code of referenced libraries are contained in the
executable file).  This has the advantage
that once an executable is created, whenever it is run in the future, it
will always use the same object code (within the limit of changing runtime 
environemnt). However, executables compiled with static libraries have
the potential disadvantage that when multiple instances are running
simultaneously multiple copies of the libraries used are held in memory.
This can lead to large amounts of memory being used to hold the
executable and not application data.

To create an application that uses static libraries you must
pass an extra flag during compilation, ``-Bstatic``.

Use the UNIX command ``ldd exe_file`` to check whether you are using an
executable that depends on shared libraries. This utility will also
report the shared libraries this executable will use if it has been
dynamically linked.
