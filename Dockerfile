FROM docker.io/library/golang:1.14.3-alpine3.11 as builder
WORKDIR /go/src/github.com/cilium/hubble
RUN apk add --no-cache git make
COPY . .
RUN make clean && make hubble

FROM docker.io/library/alpine:3.11
RUN apk add --no-cache bash curl jq
COPY --from=builder /go/src/github.com/cilium/hubble/hubble /usr/bin
ENTRYPOINT ["/usr/bin/hubble"]
CMD ["help"]
