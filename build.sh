#!/bin/bash
set -euo pipefail
VERSION=${1:-5.1.51}
docker build --build-arg VERSION=$VERSION -t tommi2day/mysql51:$VERSION .
