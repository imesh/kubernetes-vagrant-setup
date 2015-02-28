# kubernetes-vagrant-setup
A vagrant script to setup a **[Kubernetes](https://github.com/GoogleCloudPlatform/kubernetes)** (0.11.0)
cluster on 
**[CoreOS](https://coreos.com)** [(alpha/598.0.0)](https://coreos.com/releases/). Thanks to [Pires](https://github.com/pires) for the original [implementation](https://github.com/pires/kubernetes-vagrant-coreos-cluster).

## Pre-requisites

 * **[Vagrant](https://www.vagrantup.com)**
 * **[Virtualbox](https://www.virtualbox.org)**
 * **kubectl** (Kubernetes CLI)

## How to Run

### Install kubectl

```
./kubLocalSetup install
$(./kubLocalSetup shellinit)
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
