FROM alpine:3.7

COPY bin/helmexporter64       /helmexporter64

RUN apk add --update ca-certificates curl && \
    chmod +x /helmexporter64 

RUN addgroup -S helm-exporter && adduser -S -G helm-exporter helm-exporter
USER helm-exporter

ENTRYPOINT ["/helmexporter64"]
