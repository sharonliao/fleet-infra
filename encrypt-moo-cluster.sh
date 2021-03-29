#!/bin/bash

set -feuxo pipefail

CLUSTER=./clusters/moo-cluster

gpg --import $CLUSTER/.sops.pub.asc
cd $CLUSTER

kubectl create secret generic \
	--from-literal=GITHUB_TOKEN=$GITHUB_TOKEN \
	--from-literal=GITHUB_USER=$GITHUB_USER \
	--dry-run=client -oyaml \
	github-token-auth > github-token-auth.yaml

sops -e --output-type=yaml github-token-auth.yaml > encrypted-github-token-auth.yaml
