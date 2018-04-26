Data Transfer Guide
===================

This section covers the different ways that you can transfer data 
on to and off Tesseract.

scp command
-----------

The ``scp`` command creates a copy of a file, or if given the ``-r``
flag a directory, on a remote machine. Below shows an example of the
command to transfer a single file to Tesseract:

::

    scp [options] source_file user@tesseract-login1.dirac.ed.ac.uk:[destination]

In the above example, the ``[destination]`` is optional, as when left
out scp will simply copy the source into the users home directory.

rsync command
-------------

The ``rsync`` command creates a copy of a file, or if given the ``-r``
flag a directory, at the given destination, similar to scp above.
However, given the -a option rsync can also make exact copies (including
permissions), this is referred to as 'mirroring'. In this case the
``rsync`` command is executed with ssh to create the copy of a remote
machine. To transfer files to Tesseract the command should have the form:

::

    rsync [options] -e ssh source user@tesseract-login1.dirac.ed.ac.uk:[destination]

In the above example, the ``[destination]`` is optional, as when left
out rsync will simply copy the source into the users home directory.

Performance considerations
--------------------------

Tesseract is capable of generating data at a rate far greater than the rate
at which this can be downloaded. In practice, it is expected that only a
portion of data generated on Tesseract will be required to be transfered
back to users' local storage - the rest will be, for example,
intermediate or checkpoint files required for subsequent runs. However,
it is still essential that all users try to transfer data to and from
Tesseract as efficiently as possible. The most obvious ways to do this are:

#. Only transfer those files that are required for subsequent analysis,
   visualisation and/or archiving. Do you really need to download those
   intermediate result or checkpointing files? Probably not.
#. Combine lots of small files into a single tar file, to reduce the
   overheads associated in initiating data transfers.
#. Compress data before sending it, e.g. using gzip or bzip2.
#. Consider doing any pre- or post-processing calculations on Tesseract.
   Long running pre- or post- processing calculations should be run via
   the batch queue system, rather than on the login nodes. Such pre- or
   post-processing codes could be serial or OpenMP parallel applications
   running on a single node, though if the amount of data to be
   processed is large, an MPI application able to use multiple nodes may
   be preferable.

.. note::
   The performance of data transfers between Tesseract and your
   local institution may differ depending upon whether the transfer command
   is run on Tesseract or on your local system.
