#!/bin/sh

CWD=$(cd $(dirname $0);pwd)
IMAGE=tauffredou/clock
docker build -f build.Dockerfile -t $IMAGE-builder .

docker run -v $CWD:/go/src/github.com/tauffredou/clock -v $CWD/bin:/output $IMAGE-builder

docker build -t $IMAGE .

echo
echo run clock with
echo docker run $IMAGE
echo
