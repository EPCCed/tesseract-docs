DiRAC Extreme Scaling (Tesseract)
=================================

The DiRAC Extreme Scaling service is an HPC service hosted and run by 
`The University of Edinburgh <http://www.ed.ac.uk>`_ and `EPCC <http://www.epcc.ed.ac.uk>`_.
It is part of the `STFC <http://www.stfc.ac.uk>`_  `DiRAC National HPC Service <http://www.dirac.ac.uk>`_.

DiRAC Extreme Scaling (also known as Tesseract) is available to industry, commerce and academic researchers. For information on how
to get access to the system please see the `DiRAC website <http://www.dirac.ac.uk>`_.

The Tesseract compute service is based around an HPE SGI 8600 system with 1476 compute nodes. There are 1468 standard compute
nodes, each with two 2.1 GHz, 12-core Intel Xeon (Skylake) Silver 4116 processors and 96 GB of memory. In addition, there are
8 GPU compute nodes each with two 2.1 GHz, 12-core Intel Xeon (Skylake) Silver 4116 processors; 96 GB of memory; and 4 NVidia V100 (Volta) GPU
accelerators connected over PCIe. All compute nodes are connected together by a single Intel Omni-Path Architechture fabric
and all nodes access the 3 PB Lustre file system.

This documentation covers:

* Tesseract User Guide: general information on how to use Tesseract
* Software Libraries: notes on compiling against specific libraries on Tesseract. Most
  libraries work *as expected* so no additional notes are required however a small number require specific
  documentation

Information on using the SAFE web interface for managing accounts and reporting on your usage on
Tesseract (and DiRAC as a whole) can be found on the `DiRAC SAFE Documentation <http://dirac-safe.readthedocs.io>`__

This documentation draws on the `Cirrus Tier2 National HPC Service Documentation <http://cirrus.readthedocs.io>`__
and the documentation for the `ARCHER National Supercomputing Service <http://www.archer.ac.uk>`__.

.. toctree::
   :maxdepth: 2
   :caption: Tesseract User Guide

   user-guide/introduction
   user-guide/connecting
   user-guide/transfer
   user-guide/resource_management
   user-guide/development
   user-guide/batch
   user-guide/gpu
   user-guide/reading

.. toctree::
   :maxdepth: 2
   :caption: Software Libraries

   software-libraries/intel_mkl

.. toctree::
   :maxdepth: 2
   :caption: Policies

   policy/tandc
   policy/privacy

