vagrant-kubernetes-setup
========================

Inspired from https://github.com/Gurpartap/vagrant-kubernetes-setup/ and changed in a manner where we could spin docker instances even in the Kubernetes Master node.

Pre-requisites
==============

1. VirtualBox Installation
2. Vagrant Installation

Deployment 
==========

TODO


How to run?
===========

Run following command in a terminal. This will destroy existing VMs, if you re-run it. 

$ ./up.sh

2-VM Setup
==========

Kubernetes master node is capable of acting as a master/minion. In this mode, you can run the setup using only 2 Virtual machines which is convenient in many cases.

Please use following Vagrant file, if you would like to create the 2-VM setup.

https://github.com/nirmal070125/vagrant-kubernetes-setup/blob/master/2-vm-setup/Vagrantfile
# kubernetes-vagrant-setup
