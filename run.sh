#!/usr/bin/env bash
set -e
docker run --rm -v "$(pwd)/data:/data" xmlconverter
