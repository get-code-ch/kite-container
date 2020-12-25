FROM golang:alpine as builder

RUN apk update && apk add git sed

WORKDIR /

RUN git clone --branch prototype  https://github.com/get-code-ch/kite-server.git

WORKDIR /kite-server

# Removing dev path in go.mod
RUN sed -i '/^replace/d' go.mod

#get dependancies
RUN go get -d -v

#build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build  -a -installsuffix cgo -ldflags="-w -s" -o /go/bin/kite-server

FROM alpine:latest
LABEL maintainer="Claude Debieux <claude@get-code.ch>"
LABEL name="kite-server"

RUN apk add --no-cache --update bash iputils tzdata
#RUN apk add --update bash iputils tzdata

## Setting localtime
RUN cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
RUN echo "Europe/Zurich" > /etc/timezone

WORKDIR /kite-server
COPY --from=builder /go/bin/kite-server /kite-server/kite-server

EXPOSE 9443
EXPOSE 9080

COPY setup.key /kite-server/ssl/
COPY setup.crt /kite-server/ssl/

VOLUME /kite-server/config
ENTRYPOINT ["/kite-server/kite-server"]