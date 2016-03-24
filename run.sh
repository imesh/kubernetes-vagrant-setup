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
#echo "Starting http server at http://localhost:8000"
#pushd bin/kubernetes/
#python http-server.py > /dev/null 2>&1 &
#popd

#echo "Starting vagrant setup..."
eval "$* vagrant up"

echo "Deploying kubernetes UI..."
kubectl create -f plugins/kube-ui/ --namespace=kube-system

echo "Deploying kubernetes dashboard..."
kubectl create -f plugins/kubernetes-dashboard/ --namespace=kube-system

#echo "Stopping http server..."
#pkill http-server.py || true
duration=$SECONDS
echo "Kubernetes cluster started in $(($duration / 60)) minutes and $(($duration % 60)) seconds"
