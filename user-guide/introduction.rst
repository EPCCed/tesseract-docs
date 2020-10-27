Introduction
============

This guide is designed to be a reference for users of the
high-performance computing (HPC) facility: Tesseract. It provides all the
information needed to access the system, transfer data, manage your
resources (disk and compute time), submit jobs, compile programs and
manage your environment.

Acknowledging Tesseract
-----------------------

You should use the following phrase to acknowledge Tesseract in all
research outputs that have used the facility:

*This work used the DiRAC Extreme Scaling HPC Service (https://www.dirac.ac.uk).*

You should also tag outputs with the keyword *DiRAC* whenever possible.

Hardware
--------

The current Extreme Scaling compute provision (Tesseract) consists of 1468 standard compute nodes and 8 GPU compute nodes
connected together by a single Intel OPA fabric.

There are 2 login nodes that share a common software environment and file system with the compute nodes.

Standard Compute Nodes
^^^^^^^^^^^^^^^^^^^^^^

Tesseract standard compute nodes each contain two 2.1 GHz, 12-core Intel Xeon Silver 4116 (Skylake) series processors. Each of the cores in these
processors support 2 hardware threads (Hyperthreads), which are disabled by default.

There are 1468 standard compute nodes on Tesseract giving a total of 35,232 cores.

The compute nodes on Tesseract have 96 GB of memory shared between the two processors. The memory is arranged in a non-uniform access (NUMA)
form: each 12-core processor is a single NUMA region with local memory of 48 GB. Access to the local memory by cores within a NUMA region has
a lower latency than accessing memory on the other NUMA region.

There are three levels of cache, configured as follows:

* L1 Cache 32 KB Instr., 32 KB Data (per core)
* L2 Cache 1 MB (per core)
* L3 Cache 16.5 MB (shared)

GPU Compute Nodes
^^^^^^^^^^^^^^^^^

Tesseract GPU compute nodes each contain two 2.1 GHz, 12-core Intel Xeon Silver 4116 (Skylake) series processors. Each of the cores in these
processors support 2 hardware threads (Hyperthreads), which are disabled by default. The nodes also each contain four NVIDIA Tesla
V100-PCIE-16GB (Volta) GPU accelerators connected to the host processors and each other via [NVLink](https://www.nvidia.com/en-gb/data-center/nvlink/).

There are 8 GPU compute nodes on Tesseract giving a total of 192 cores and 64 GPU accelerators.

The compute nodes on Tesseract have 96 GB of memory shared between the two processors. The memory is arranged in a non-uniform access (NUMA)
form: each 12-core processor is a single NUMA region with local memory of 48 GB. Access to the local memory by cores within a NUMA region has
a lower latency than accessing memory on the other NUMA region. 

There are three levels of cache, configured as follows:

* L1 Cache 32 KB Instr., 32 KB Data (per core)
* L2 Cache 1 MB (per core)
* L3 Cache 16.5 MB (shared)

OPA Interconnect
^^^^^^^^^^^^^^^^

The system has a single Intel OPA fabric and every compute node and login node has a single OPA interface. The Lustre file system servers have
two connections to the OPA fabric and all Lustre file system IO traverses the OPA fabric.

File systems and Data Infrastructure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

There is currently a single Lustre parallel file system available on Tesseract: /tessfs1 is a Lustre parallel file system desgined to give high
read/write bandwidth for parallel I/O operations.

The Lustre file system has a total of 3 PB available. The login and compute nodes mount the storage as /tessfs1, and all home and work directories
are available on all nodes.

The compute nodes are diskless. Each node boots from a cluster management noded called the Rack Leader and NFS mounts the root file system from
this management node.

.. note::

   Data on the Lustre file system is automatically backed up to a separate tape library.

Parallel I/O
^^^^^^^^^^^^

For a description of the terms associated with Lustre parallel file systems please see the description on Wikipedia:

* `Lustre File Systems Description <https://en.wikipedia.org/wiki/Lustre_(file_system)>`__

The default striping on the Lustre filesystem is 1 stripe, and the default stripe size is 1 MiB.

