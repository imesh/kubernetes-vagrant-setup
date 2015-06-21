# kubernetes-vagrant-setup
A vagrant script for setting up a **[Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes)** (0.18.0)
cluster on 
**[CoreOS](https://coreos.com)** [(alpha/717.0.0)](https://coreos.com/releases/). This repository was forked from  [Pires](https://github.com/pires)'s [github repository](https://github.com/pires/kubernetes-vagrant-coreos-cluster) and changed according to Apache Stratos requirements. All the credit goes to [Pires](https://github.com/pires) for implementing this awesome Vagrant module.

## Pre-requisites

 * **[Vagrant 1.7.2+](https://www.vagrantup.com)**
 * **[Virtualbox 4.3.20+](https://www.virtualbox.org)**
 * **[Wget] (http://www.gnu.org/software/wget)**

## How to Run

### Set-up Kubernetes Cluster

Disable DHCP server in VirtualBox:
```
VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
```

Execute the following vagrant command to start the Kubernetes cluster, this will start one master node and one minion:

```
vagrant up 
```

If more than one minion is needed, run the below command with the required number of instances:

```
NUM_INSTANCES=2 vagrant up
```

Wait until the minion(s) get connected to the cluster. Once the state of the minions are changed to Ready, the Kubernetes cluster is ready for use. Execute following Kubernetes CLI commands and verify their status:

```
kubectl get minions

Due to some reason get minions command is not working in this Kubernetes version.
```

```
kubectl get services

NAME            LABELS                                                              SELECTOR           IP(S)         PORT(S)
kube-dns        k8s-app=kube-dns,kubernetes.io/cluster-service=true,name=kube-dns   k8s-app=kube-dns   10.100.0.10   53/UDP
                                                                                                                     53/TCP
kubernetes      component=apiserver,provider=kubernetes                             <none>             10.100.0.2    443/TCP
kubernetes-ro   component=apiserver,provider=kubernetes                             <none>             10.100.0.1    80/TCP
```

## Clean-up

Execute the following command to remove the virtual machines created for the Kubernetes cluster.
```
vagrant destroy
```

If you've set `NUM_INSTANCES` or any other variable when deploying, please make sure you set it in `vagrant destroy` call above, like:

```
NUM_INSTANCES=2 vagrant destroy
```

## Licensing

[Apache License, Version 2.0](http://opensource.org/licenses/Apache-2.0).
