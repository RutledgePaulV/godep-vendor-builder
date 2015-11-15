FROM golang:1.5.1
ENV GO15VENDOREXPERIMENT 1
RUN go-wrapper download github.com/tools/godep
RUN cd /go/src/github.com/tools/godep && go-wrapper install
RUN ln -s /go/bin/godep /usr/local/bin/godep
WORKDIR /go/src/app
ENV BINARY app
CMD [ "/bin/bash" , "-c", "godep get -v && go build -v -o ${PROJECT}"]
