# kubernetes-vagrant-setup
A vagrant script to setup a **[Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes)** (0.11.0)
cluster on 
**[CoreOS](https://coreos.com)** [(alpha/598.0.0)](https://coreos.com/releases/). Thanks to [Pires](https://github.com/pires) for the original [implementation](https://github.com/pires/kubernetes-vagrant-coreos-cluster).

## Pre-requisites

 * **[Vagrant 1.7.2+](https://www.vagrantup.com)**
 * **[Virtualbox 4.3.20+](https://www.virtualbox.org)**
 * **kubectl**

## How to Run

### Install kubectl

Execute the following script to install kubectl. This is the Kubernetes CLI which is needed for interacting with the Kubernetes cluser:

```
./kubLocalSetup install
```

Execute the below command to export Kubernetes API URL to the shell. You could add this to your bash profie if you need it to be persisted:

```
export KUBERNETES_MASTER=http://172.17.8.101:8080
```

### Set-up Kubernetes Cluster

First start the master node:

```
vagrant up master
```

Wait until it has finished downloading Kybernetes binaries and provisioned a Docker registry. This may take several minutes depending on the speed of your internet connection. Login to master node and list docker images:

```
vagrant ssh master
docker images
```

Once the registry docker image is completely downloaded execute the following command to see whether the docker registry has started:

```
docker ps
```

Afterwards, bring up the minion:

```
vagrant up
```

If more than one minion is needed, run the below command with the required number of instances:

```
NUM_INSTANCES=2 vagrant up
```

## Licensing

[Apache License, Version 2.0](http://opensource.org/licenses/Apache-2.0).
