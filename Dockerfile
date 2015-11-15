FROM golang:1.5.1
ENV GO15VENDOREXPERIMENT 1
RUN go-wrapper download godep
ONBUILD COPY . /go/src/app
ONBUILD RUN rm -rf /go/src/app/vendor
ONBUILD RUN godep get -v
ONBUILD RUN go -v install