FROM golang:1.13
ADD . /go/src/github.com/furikuri/h2c-example
WORKDIR /go/src/github.com/furikuri/h2c-example
RUN go get ./
RUN go build

FROM alpine:3.10
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
WORKDIR /root/
COPY --from=0 /go/bin/h2c-example .
EXPOSE 8080
ENTRYPOINT ["/root/h2c-example"]