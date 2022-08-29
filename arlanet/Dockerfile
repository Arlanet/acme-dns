FROM alpine:latest

RUN apk --no-cache add ca-certificates && update-ca-certificates

WORKDIR /srv

COPY ./output/linux/acme-dns ./acme-dns

RUN chmod +x ./acme-dns

RUN mkdir -p /etc/acme-dns
RUN mkdir -p /var/lib/acme-dns

ENTRYPOINT "./acme-dns"