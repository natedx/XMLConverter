#!/usr/bin/env bash
set -e

# À executer avec la dernière version de docker avec containerd activé : https://docs.docker.com/desktop/features/containerd/#enable-the-containerd-image-store

docker build --platform=linux/amd64,linux/arm64 --push -t n8dx/xmlconverter:latest ./scripts
