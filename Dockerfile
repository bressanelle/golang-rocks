FROM alpine:latest as config-docker

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

WORKDIR $GOPATH/src
COPY ./gorocks.go .

RUN apk add --no-cache go \
    && mkdir -p ${GOPATH}/src ${GOPATH}/bin \
    && go build -o /app/application . \
    && apk del go --purge

ENTRYPOINT [ "/app/application" ]