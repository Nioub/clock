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
  build-chain           builder,build,image

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
  all)
    $MAKE builder && $MAKE build && $MAKE image
  ;;
  *)
    usage
  ;;
esac
