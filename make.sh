#!/bin/sh

CWD=$(cd $(dirname $0);pwd)
MAKE=$0
IMAGE=tauffredou/clock

usage(){
cat<<-EOUSAGE
make.sh [Action]
Actions:
  builder       create builder image
  build         create binary using builder image
  image         create final image
  run           run the final image
  build-chain   builder,build,image
  rm            remove running containers
  rm-image      remove final image
  rm-builder    remove builder image
  clean         rm,rm-image,rm-builder

EOUSAGE
}

case $1 in
  builder)
    docker build -f build.Dockerfile -t $IMAGE-builder .
  ;;
  build)
    docker run -v $CWD:/go/src/github.com/tauffredou/clock -v $CWD/bin:/output $IMAGE-builder
    echo "Built in $CWD/bin"
  ;;
  image)
    docker build -t $IMAGE .
    echo
    echo run clock with: docker run $IMAGE
    echo
  ;;
  run)
    docker run $IMAGE
  ;;
  build-chain)
    $MAKE builder && $MAKE build && $MAKE image
  ;;
  rm)
    docker ps -a | grep " $IMAGE" | awk '{print $1}' | xargs docker rm
  ;;
  rm-image)
    docker rmi $IMAGE
  ;;
  rm-builder)
    docker rmi $IMAGE-builder
  ;;
  clean)
    $MAKE rm && $MAKE rm-image && $MAKE rm-builder
  ;;
  *)
    usage
  ;;
esac
