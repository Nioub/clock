FROM golang:1.5

RUN go get github.com/Sirupsen/logrus
VOLUME $GOPATH/src/github.com/tauffredou/docker-builder-pattern
VOLUME /output

WORKDIR $GOPATH/src/github.com/tauffredou/clock
CMD GOOS=linux GOARCH=amd64 go build -o /output/clock
