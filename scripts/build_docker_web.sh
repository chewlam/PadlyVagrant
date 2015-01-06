#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd ${DIR}/../web > /dev/null 2>&1
docker build -t padly/web --rm .
popd > /dev/null 2>&1
