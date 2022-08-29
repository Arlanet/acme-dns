FROM golang:alpine

RUN apk upgrade --no-cache
RUN apk add --no-cache gcc mingw-w64-gcc musl-dev git

ENV GOOUTPUT=/output
ENV GOARGS=""
ENV GOBUILDARGS=""

WORKDIR /src

ENTRYPOINT sh -c "$GOARGS go build $GOBUILDARGS -o $GOOUTPUT"