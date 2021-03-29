#!/bin/bash

set -feuxo pipefail

cd clusters/moo-cluster

kubectl create secret generic \
	--from-literal=GITHUB_TOKEN=$GITHUB_TOKEN \
	--from-literal=GITHUB_USER=$GITHUB_USER \
	--dry-run=client -oyaml \
	github-token-auth > github-token-auth.yaml

sops -e --output-type=yaml github-token-auth.yaml > encrypted-github-token-auth.yaml
