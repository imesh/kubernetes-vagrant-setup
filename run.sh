#!/bin/bash
# ----------------------------------------------------------------
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the License is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied.  See the License for the
#  specific language governing permissions and limitations
#  under the License.
# ----------------------------------------------------------------
# Execute this script to start a new kubernetes cluster
# ----------------------------------------------------------------
set -e

SECONDS=0
docker_image_dir="bin/kubernetes/v1.2.0/docker/images/"

function echoError () {
    echo $'\e[1;31m'"${1}"$'\e[0m'
}

function echoSuccess () {
    echo $'\e[1;32m'"${1}"$'\e[0m'
}

function echoBold () {
    echo $'\e[1m'"${1}"$'\e[0m'
}

function docker_pull() {
  image_tag=$1
  echoBold "==> docker pull ${image_tag}"
  docker pull ${image_tag}
}

function docker_save() {
  image_tag=$1
  file_name=$2
  echoBold "==> docker save ${image_tag} > ${file_name}"
  docker save ${image_tag} > ${file_name}
}

if [ "$(ls ${docker_image_dir})" ]; then
  echoBold "Docker image files found in ${docker_image_dir}"
else
  echoBold "Docker image files not found in ${docker_image_dir}"
  echoBold "Trying to pull docker images, this is a one time operation..."

  if ! [ -x "$(command -v docker)" ]; then
    echoError "Docker is not installed"
    exit 1
  fi

  if [ -x "$(command -v docker-machine)" ]; then
    if ! [ "$(docker-machine ls | grep Running)" ]; then
      echoError "Docker machine is not running"
      exit 1
    fi
  fi

  docker_pull quay.io/devops/docker-registry:latest
  docker_pull gcr.io/google_containers/etcd:2.0.9
  docker_pull gcr.io/google_containers/kube-registry-proxy:0.3
  docker_pull gcr.io/google_containers/pause:2.0
  docker_pull quay.io/coreos/flannel:0.5.5
  docker_pull gcr.io/google_containers/skydns:2015-10-13-8c72f8c
  docker_pull gcr.io/google_containers/kube-ui:v3
  docker_pull gcr.io/google_containers/exechealthz:1.0
  docker_pull gcr.io/google_containers/kube2sky:1.11
  docker_pull gcr.io/google_containers/kubernetes-dashboard-amd64:v1.0.0
  echoSuccess "Docker images pulled successfully!"

  pushd ${docker_image_dir} > /dev/null
  echoBold "Saving docker images to disk..."
  docker_save quay.io/devops/docker-registry:latest docker-registry.latest.tar.gz
  docker_save gcr.io/google_containers/etcd:2.0.9 etcd.2.0.9.tar.gz
  docker_save gcr.io/google_containers/kube-registry-proxy:0.3 kube-registry-proxy.0.3.tar.gz
  docker_save gcr.io/google_containers/pause:2.0 pause.2.0.tar.gz
  docker_save quay.io/coreos/flannel:0.5.5 flannel.0.5.5.tar.gz
  docker_save gcr.io/google_containers/skydns:2015-10-13-8c72f8c skydns.2015.10.tar.gz
  docker_save gcr.io/google_containers/kube-ui:v3 kube-ui.v3.tar.gz
  docker_save gcr.io/google_containers/exechealthz:1.0 exechealthz.1.0.tar.gz
  docker_save gcr.io/google_containers/kube2sky:1.11 kube2sky.1.11.tar.gz
  docker_save gcr.io/google_containers/kubernetes-dashboard-amd64:v1.0.0 kubernetes-dashboard.1.0.0.tar.gz
  echoSuccess "Docker images saved to disk successfully!"
  popd > /dev/null
fi

echoBold "Starting vagrant setup..."
eval "$* vagrant up"

echoBold "Deploying kubernetes UI..."
kubectl create -f plugins/kube-ui/ --namespace=kube-system

echoBold "Deploying kubernetes dashboard..."
kubectl create -f plugins/kubernetes-dashboard/ --namespace=kube-system

duration=$SECONDS
kubectl cluster-info
echoSuccess "Kubernetes cluster started in $(($duration / 60)) minutes and $(($duration % 60)) seconds"
