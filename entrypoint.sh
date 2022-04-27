#!/bin/bash

set -u

function inputsToDockerArgs() {
  inputs=$1
  prefix=$2
  args=""
  while IFS= read -r input ; do
    key="$prefix$(cut -d ':' -f 1 <<< "$input" | tr '[:lower:]' '[:upper:]')"
    valueWithExtraSpace=$(cut -d ':' -f 2 <<< "$input")
    value="${valueWithExtraSpace:1}"
    args+=" --env $key=$value";
  done <<< "$inputs"

  echo $args
}

withYml=$(yq r - with <<< $INPUT_INPUTS)
withArgs=$(inputsToDockerArgs "$withYml" 'INPUT_')

envYml=$(yq r - env <<< $INPUT_INPUTS)
envArgs=$(inputsToDockerArgs "$envYml" '')


docker login ghcr.io -u "$INPUT_DOCKER_USERNAME" -p "$INPUT_DOCKER_PASSWORD"
echo "docker run --network host $withArgs $envArgs $INPUT_PACKAGE"

docker run --network host $withArgs $envArgs $INPUT_PACKAGE
