# Kubernetes Vagrant Setup

A vagrant script for setting up a **[Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes)** (v1.2.0)
cluster on
**[CoreOS](https://coreos.com)** [(alpha/991.0.0)](https://coreos.com/releases/). This repository was forked from  [Pires](https://github.com/pires)'s [github repository](https://github.com/pires/kubernetes-vagrant-coreos-cluster) and improved the startup time by directly copying Kubernetes binary and docker files into the virtual machines without downloading them from the internet each time. [Kubernetes binary](bin/kubernetes/v1.2.0/linux/amd64/) has been added to the git repository and [docker files](bin/kubernetes/v1.2.0/docker/images/) are designed to be downloaded in the first run.

All the credit goes to [Pires](https://github.com/pires) for implementing this awesome Vagrant module.

## Pre-requisites

 * **[Vagrant 1.7.2+](https://www.vagrantup.com)**
 * **[Virtualbox 4.3.20+](https://www.virtualbox.org)**

## How to Run

### Set-up Kubernetes Cluster

Disable DHCP server in VirtualBox:
```
VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
```

Execute the following bash script to start a new Kubernetes cluster, this will start one master node and one minion:

```
run.sh
```

If more than one minion is needed, run the below command with the required number of instances:

```
run.sh NODES=2
```

If you need to specify minion's Memory and CPU, use following command:

```
run.sh NODES=2 NODE_MEM=4096 NODE_CPUS=2
```

Wait until the nodes get connected to the cluster. Once the state of the nodes are changed to Ready, the Kubernetes cluster is ready for use. Execute following Kubernetes CLI commands and verify their status:

```
kubectl get nodes

NAME           LABELS                                STATUS
172.17.8.102   kubernetes.io/hostname=172.17.8.102   Ready
```

Access the Kubernetes dashboard using the following URL [http://172.17.8.101:8080/ui](http://172.17.8.101:8080/ui).

## Clean-up

Execute the following command to remove the virtual machines created for the Kubernetes cluster.
```
vagrant destroy
```

If you've set `NODES` or any other variable when deploying, please make sure you set it in `vagrant destroy` call above, like:

```
NODES=2 vagrant destroy
```

## Licensing

[Apache License, Version 2.0](http://opensource.org/licenses/Apache-2.0).
