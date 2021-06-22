Running Jobs on Tesseract
=========================

The Tesseract facility uses PBSPro to schedule jobs.

Writing a submission script is typically the most convenient way to
submit your job to the job submission system. Example submission scripts
(with explanations) for the most common job types are provided below.

Interactive jobs are also available and can be particularly useful for
developing and debugging applications. More details are available below.

If you have any questions on how to run jobs on Tesseract do not hesitate
to contact the DiRAC Helpdesk at `dirac-support@epcc.ed.ac.uk <mailto:dirac-support@epcc.ed.ac.uk>`_.

Using PBSPro
------------

You typically interact with PBS by (1) specifying PBS directives in job
submission scripts (see examples below) and (2) issuing PBS commands
from the login nodes.

There are three key commands used to interact with the PBS on the
command line:

-  ``qsub``
-  ``qstat``
-  ``qdel``

Check the PBS ``man`` page for more advanced commands:

::

    man pbs

The qsub command
~~~~~~~~~~~~~~~~

The qsub command submits a job to PBS:

::

    qsub job_script.pbs

This will submit your job script "job\_script.pbs" to the job-queues.
See the sections below for details on how to write job scripts.

The qstat command
~~~~~~~~~~~~~~~~~

Use the command qstat to view the job queue. For example:

::

    qstat

will list all jobs on Tesseract.

You can view just your jobs by using:

::

    qstat -u $USER

The ``-a`` option to qstat provides the output in a more useful
format.

To see more information about a queued job, use:

::

    qstat -f $JOBID

This option may be useful when your job fails to enter a running state.
The output contains a PBS ``comment`` field which may explain why the job
failed to run.


The qdel command
~~~~~~~~~~~~~~~~

Use this command to delete a job from Tesseract's job queue. For example:

::

    qdel $JOBID

will remove the job with ID ``$JOBID`` from the queue.

Queue Limits
------------

Queues on Tesseract are designed to enable users to use the system flexibly while 
retaining fair access for all.

The queues on Tesseract are linked to the physical layout of the hardware on the 
interconnect to help ensure that jobs have access to nodes with the optimal
layout on the interconnet topology. In practice, this means that jobs are limited
to specific numbers of nodes and will be rejected unless those numbers of nodes
are selected using PBS as described below. The node numbers currently supported
on Tesseract are:

- 16 nodes (384 cores)
- 32 nodes (768 cores)
- 64 nodes (1536 cores)
- 128 nodes (3072 cores)
- 256 nodes (6144 cores)
- 512 nodes (12288 cores)
- 1024 nodes (24576 cores) - available by request only, contact `dirac-support@epcc.ed.ac.uk <mailto:dirac-support@epcc.ed.ac.uk>`_

The exception to this layout are the 8 GPU compute nodes where jobs can range
from 1 to 8 nodes.

- The maximum runtime for jobs in the standard CPU queues on Tesseract is currently 48 hours
- The maximum runtime for jobs in the standard GPU queues on Tesseract is currently 24 hours

Low priority queues
-------------------

Each of the queues on Tesseract has a low priority counterpart. Jobs that run in the low 
priority queues are not charged against the user's budget but have a much lower priority
than charged jobs so will only run if there are no eligbile charged jobs waiting for 
resources.

Output from PBS jobs
--------------------

PBS produces standard output and standard error for each batch job can
be found in files ``<jobname>.o<Job ID>`` and ``<jobname>.e<Job ID>``
respectively. These files appear in the job's working directory once
your job has completed or its maximum allocated time to run (i.e. wall
time, see later sections) has ran out.

Running Parallel Jobs
---------------------

This section describes how to write job submission scripts specifically
for different kinds of parallel jobs on Tesseract.

All parallel job submission scripts require (as a minimum) you to
specify three things:

-  The number of nodes you require via the
   ``-l select=[Nodes]`` option. Each node has 24
   cores (2x 12-core processors). For example, to select 16 nodes
   (384 cores in total) you would use
   ``-l select=16``. Remember that only certain node counts are permitted
   (see the Queue Limits section above for more details).
-  The walltime. This can be specified in two ways: as a hard ``walltime``
   which sets the maximum walltime for the job or as a "shrink-to-fit"
   job where a ``min_walltime`` and a ``max_walltime`` are set and the
   scheduler chooses a walltime between these extremes to start the job
   as soon as possible.
   + The maximum length of time (i.e. walltime) you want the job to run
     for via the ``-l walltime=[hh:mm:ss]`` option. To ensure the
     minimum wait time for your job, you should specify a walltime as
     short as possible for your job (i.e. if your job is going to run for
     3 hours, do not specify 12 hours). On average, the longer the
     walltime you specify, the longer you will queue for.
   + Shrink-to-fit jobs specify a ``min_walltime`` and ``max_walltime``
     and the scheduler picks a walltime between these valuse that starts
     the job as soon as possible. Once a job starts, you can find the 
     chosen walltime using the ``qstat -f <jobid>`` command.
-  The placement option '-l place=scatter:excl' to ensure that parallel
   processes/threads are scheduled to the full set of compute nodes
   assigned to the job.
-  The project code that you want to charge the job to via the
   ``-A [project code]`` option

In addition to these mandatory specifications, there are many other
options you can provide to PBS. The following options may be useful:

- The name of the job can be set with the ``-N <name>`` option.
  The name will be used in various places. In particular
  it will be used in the queue listing and to generate the name of your
  output and/or error file(s). Note there is a limit on the size of the
  name.
- If you wish to use the GPU compute nodes you should specify the ``QGPU``
  queue with the ``-q QGPU`` option.

.. note::
   All compute nodes on Tesseract are run in exclusive mode. This means that only
   one job at a time can run on any compute node.

Shrink-to-fit jobs
------------------

Shrink-to-fit jobs specify a ``min_walltime`` and ``max_walltime``
and the scheduler picks a walltime between these valuse that starts
the job as soon as possible. Once a job starts, you can find the 
chosen walltime using the ``qstat -f <jobid>`` command.

Running MPI parallel jobs
-------------------------

When you running parallel jobs requiring MPI you will use an MPI launch
command to start your executable in parallel.

Intel MPI
~~~~~~~~~

Intel MPI is accessed at runtime by loading the ``intel-mpi-18``.

::

   module load intel-mpi-18

but it is usually added through the ``intel-tools-18`` module which
sets up the Intel compilers and asscociated libraries.

Intel MPI: parallel job launcher ``mpirun``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Intel MPI parallel job launcher on Tesseract is ``mpirun``.

.. note::
   This parallel job launcher is only available once you have
   loaded the ``intel-mpi-18`` module (usually via the 
   ``intel-tools-18`` module).

A sample MPI launch line using ``mpirun`` looks like:

::

    mpirun -n 384 -ppn 24 ./my_mpi_executable.x arg1 arg2

This will start the parallel executable ``my_mpi_executable.x`` with
arguments "arg1" and "arg2". The job will be started using 384 MPI
processes, with 24 MPI processes placed on each compute node 
(this would use all the physical cores on each node). This would
require 16 nodes to be requested in the PBS options.

The most important ``mpirun`` flags are:

 ``-n [total number of MPI processes]``
    Specifies the total number of distributed memory parallel processes
    (not including shared-memory threads). For pure MPI jobs that use all
    physical cores this will usually be a multiple of 24. The default on
    Tesseract is 1.
 ``-ppn [parallel processes per node]``
    Specifies the number of distributed memory parallel processes per
    node. There is a choice of 1-24 for physical cores on Tesseract compute
    nodes (1-48 if you are using Hyper-Threading)
    For pure MPI jobs, the most economic choice is usually to run with
    "fully-packed" nodes on all physical cores if possible, i.e.
    ``-ppn 24`` . Running "unpacked" or "underpopulated" (i.e. not using
    all the physical cores on a node) is useful if you need large
    amounts of memory per parallel process or you are using more than
    one shared-memory thread per parallel process.

Documentation on using Intel MPI (including ``mpirun``) can be found 
online at:

* `Intel MPI Documentation <https://software.intel.com/en-us/articles/intel-mpi-library-documentation>`__

Intel MPI: running hybrid MPI/OpenMP applications
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you are running hybrid MPI/OpenMP code using Intel MPI you need to 
set the ``I_MPI_PIN_DOMAIN`` environment variable to ``omp`` so that
MPI tasks are pinned with enough space for OpenMP threads.

For example, in your job submission script you would use:

::

   export I_MPI_PIN_DOMAIN=omp

You can then also use the ``KMP_AFFINITY`` enviroment variable 
to control placement of OpenMP threads. For more information, see:

* `Intel OpenMP Thread Affinity Control <https://software.intel.com/en-us/articles/openmp-thread-affinity-control>`__

Intel MPI: Process Placement
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, MPI processes are placed on nodes in a round-robin format. For example, if you 
are using 4 nodes, 16 MPI processes in total and have 4 MPI processes per node, you would use the command:

::

  mpirun -n 16 -ppn 4 /path/to/my/exe

the processes would be placed in the following way:

::

   MPI process 0: placed on Node 1
   MPI process 1: placed on Node 2
   MPI process 2: placed on Node 3
   MPI process 3: placed on Node 4
   MPI process 4: placed on Node 1
   MPI process 5: placed on Node 2
   MPI process 6: placed on Node 3
   MPI process 7: placed on Node 4
   MPI process 8: placed on Node 1
   ...
   MPI process 15: placed on Node 4

The alternative way to place MPI processes would be to fill one node with processes before moving onto
the next node (this is often known as *SMP placement*). This can be achieved within a PBS job on 
Tesseract by using the ``-f`` flag to pass the node list file explicity. For example:

::

  mpirun -n 16 -ppn 4 -f $PBS_NODEFILE /path/to/my/exe

The processes would be placed in the following way:

::

   MPI process 0: placed on Node 1
   MPI process 1: placed on Node 1
   MPI process 2: placed on Node 1
   MPI process 3: placed on Node 1
   MPI process 4: placed on Node 2
   MPI process 5: placed on Node 2
   MPI process 6: placed on Node 2
   MPI process 7: placed on Node 2
   MPI process 8: placed on Node 3
   ...
   MPI process 15: placed on Node 4

Intel MPI: MPI-IO setup
^^^^^^^^^^^^^^^^^^^^^^^

If you wish to use MPI-IO with Intel MPI you must set a couple of 
additional environment variables in your job submission script to
tell the MPI library to use the Lustre file system interface.
Specifically, you should add the lines:

::

   export I_MPI_EXTRA_FILESYSTEM=on
   export I_MPI_EXTRA_FILESYSTEM_LIST=lustre

after you have loaded the ``intel-tools-18`` module.

If you fail to set these environment variables you may see errors such as:

::

   This requires fcntl(2) to be implemented. As of 8/25/2011 it is not. Generic MPICH
   Message: File locking failed in
   ADIOI_Set_lock(fd 0,cmd F_SETLKW/7,type F_WRLCK/1,whence 0) with return value
   FFFFFFFF and errno 26.
   - If the file system is NFS, you need to use NFS version 3, ensure that the lockd
    daemon is running on all the machines, and mount the directory with the 'noac'
    option (no attribute caching).
   - If the file system is LUSTRE, ensure that the directory is mounted with the 'flock'
    option.
   ADIOI_Set_lock:: Function not implemented
   ADIOI_Set_lock:offset 0, length 10
   application called MPI_Abort(MPI_COMM_WORLD, 1) - process 3


Example parallel MPI job submission scripts
-------------------------------------------

Example job submssion scripts are included in full below. They are also
available via the following links:

* Intel MPI Job: :download:`example_mpi_impi.bash <example_mpi_impi.bash>`
* Intel MPI Hybrid MPI/OpenMP Job: :download:`example_hybrid_impi.bash <example_hybrid_impi.bash>` 
* Intel MPI Array MPI Job: :download:`example_array_impi.bash <example_array_impi.bash>` 

Example: Intel MPI job submission script for MPI parallel job
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A simple MPI job submission script to submit a job using 4 compute
nodes (maximum of 144 physical cores) for 20 minutes would look like:

::

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

This will run your executable "my\_mpi\_executable.x" in parallel on 384
MPI processes using 16 nodes (24 cores per node, i.e. not using hyper-threading). PBS will
allocate 16 nodes to your job and mpirun will place 24 MPI processes on each node
(one per physical core).

See above for a more detailed discussion of the different PBS options

Example: Intel MPI job submission script for MPI+OpenMP (mixed mode) parallel job
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mixed mode codes that use both MPI (or another distributed memory
parallel model) and OpenMP should take care to ensure that the shared
memory portion of the process/thread placement does not span more than
one node. This means that the number of shared memory threads should be
a factor of 12.

In the example below, we are using 16 nodes for 6 hours. There are 32 MPI
processes in total and 12 OpenMP threads per MPI process. Note the use
of the ``I_MPI_PIN_DOMAIN`` environment variable to specify that MPI process
placement should leave space for threads.

::

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
   mpirun -n 32 -ppn 2 ./my_mixed_executable.x arg1 arg2 > my_stdout.txt 2> my_stderr.txt

Interactive Jobs
----------------

When you are developing or debugging code you often want to run many
short jobs with a small amount of editing the code between runs. This
can be achieved by using the login nodes to run MPI but you may want
to test on the compute nodes (e.g. you may want to test running on 
multiple nodes across the high performance interconnect). One of the
best ways to achieve this on Tesseract is to use interactive jobs.

An interactive job allows you to issue ``mpirun`` commands directly
from the command line without using a job submission script, and to
see the output from your program directly in the terminal.

To submit a request for an interactive job reserving 16 nodes
(384 physical cores) for 20 minutes you would
issue the following qsub command from the command line:

::

    qsub -IVl select=16:ncpus=24,walltime=0:20:0 -A [project code]

..note ::
  Unlike non-interactive jobs, you must specify the number of cores 
  you want to use per node by adding `:ncpus=24` to the select statement.

When you submit this job your terminal will display something like:

::

    qsub: waiting for job 436.tesseract-services1 to start

It may take some time for your interactive job to start. Once it
runs you will enter a standard interactive terminal session.
Whilst the interactive session lasts you will be able to run parallel
jobs on the compute nodes by issuing the ``mpirun``  command
directly at your command prompt (rememberyou will need to load the
``intel-tools-18`` module before running)  using the
same syntax as you would inside a job script. The maximum number
of cores you can use is limited by the value of select you specify
when you submit a request for the interactive job.

If you know you will be doing a lot of intensive debugging you may
find it useful to request an interactive session lasting the expected
length of your working session, say a full day.

Your session will end when you hit the requested walltime. If you
wish to finish before this you should use the ``exit`` command.

