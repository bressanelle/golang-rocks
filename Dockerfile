FROM alpine:latest as config-docker

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH

WORKDIR $GOPATH/src
COPY ./gorocks.go .

RUN apk add --no-cache go \
    && mkdir -p ${GOPATH}/src ${GOPATH}/bin \
    && go build -o /app/gorocks . \
    && apk del go --purge


FROM scratch
COPY --from=config-docker /app/gorocks /app/gorocks
ENTRYPOINT [ "/app/gorocks" ]
