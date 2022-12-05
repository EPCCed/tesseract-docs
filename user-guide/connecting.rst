Connecting to Tesseract
=======================

You can only connect to Tesseract from the [Tursa](https://epcced.github.io/dirac-docs/tursa-user-guide/) system. You should
follow the instructions on [connecting to Tursa](https://epcced.github.io/dirac-docs/tursa-user-guide/connecting/) to make sure you are 
logged into Tursa before completing the steps below.

To transfer data off Tesseract we recommend that you either push using scp 
to an external host that allows SSH access. If the system you want to transfer
to does not support SSH connections, first transfer the data to
Tursa before pulling the data from Tursa using scp.

Access credentials
------------------

To access Tesseract, you need to use two credentials: your password and an SSH
key pair protected by a passphrase. You can find more detailed instructions on
how to set up your credentials to access Tesseract from Tursa below.

SSH Key Pairs
~~~~~~~~~~~~~

You will need to generate an SSH key pair on Tursa protected by a passphrase to access
Tesseract.

From your account on Tursa, set up a key pair that contains
your e-mail address and enter a passphrase you will use to unlock the
key:

::

    [dc-user1@tursa-login1 ~]$ ssh-keygen -t rsa -C "your@email.com"
    Generating public/private rsa key pair.
    Enter file in which to save the key (/Home/user/.ssh/id_rsa): [Enter]
    Enter passphrase (empty for no passphrase): [Passphrase]
    Enter same passphrase again: [Passphrase]
    Your identification has been saved in /Home/user/.ssh/id_rsa.
    Your public key has been saved in /Home/user/.ssh/id_rsa.pub.
    The key fingerprint is:
    03:d4:c4:6d:58:0a:e2:4a:f8:73:9a:e8:e3:07:16:c8 your@email.com
    The key's randomart image is:
    +--[ RSA 2048]----+
    |    . ...+o++++. |
    | . . . =o..      |
    |+ . . .......o o |
    |oE .   .         |
    |o =     .   S    |
    |.    +.+     .   |
    |.  oo            |
    |.  .             |
    | ..              |
    +-----------------+

(remember to replace "your@email.com" with your e-mail address).

Upload public part of key pair to DiRAC SAFE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should now upload the public part of your SSH key pair to the DiRAC SAFE by following the instructions at:

 - `Upload your SSH key to SAFE <https://dirac-safe.readthedocs.io/en/latest/safe-guide-users.html#how-to-add-an-ssh-key-to-your-safe-account>`__
 
Once you have done this, your SSH key will be added to your Tesseract account.

Remember, you will need to use both an SSH key and password to log into Tesseract so you will
also need to collect your initial password before you can log into Tesseract. We cover this next.

Initial passwords
~~~~~~~~~~~~~~~~~

The SAFE web interface is used to provide your initial password for
logging onto Tesseract (see the `DiRAC SAFE Documentation <https://dirac-safe.readthedocs.io>`__
for more details on requesting accounts and picking up passwords).

**Note:** you may now change your password on the Tesseract machine itself
using the *passwd* command or when you are prompted the first time you login.
This change will not be reflected in the SAFE. If you forget your password,
you should use the SAFE to request a new one-shot password.

Logging in from Tursa
-----------

Access to Tesseract is only available by first logging into Tursa. You should
follow the [instructions on how to connect to Tursa]() in the fist instance.

Once you are logged into Tursa, you can then access Tesseract with:

```
ssh username@tesseract.dirac.ed.ac.uk
```

.. note::

  If your SSH key pair is not stored in the default location (usually
  ``~/.ssh/id_rsa``) on your local system, you may need to specify the
  path to the private part of the key wih the ``-i`` option to ``ssh``.
  For example, if your key is in a file called ``keys/id_rsa_tesseract``
  you would use the command
  ``ssh -i keys/id_rsa_tesseract username@tesseract.dirac.ed.ac.uk``
  to log in.

.. note::

  When you first log into Tesseract, you will be prompted to change your
  initial password. This is a three step process:
  
  1. When promoted to enter your ldap password: Re-enter the password you retrieved from SAFE
  2. When prompted to enter your new password: type in a new password
  3. When prompted to re-enter the new password: re-enter the new password
  
  Your password has now been changed

