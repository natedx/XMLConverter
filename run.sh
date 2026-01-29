#!/usr/bin/env bash
set -e
docker run --rm \
  -v "$(pwd)/scripts:/app" \
  -v "$(pwd)/data:/data" \
  -e DATA_DIR=/data \
  xmlconverter
