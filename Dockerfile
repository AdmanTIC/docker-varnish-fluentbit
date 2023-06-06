ARG VARNISH_VERSION="6.0.6"

FROM varnish:${VARNISH_VERSION}
ARG FLUENT_BIT_VERSION="1.3.6-0-linux-amd64-debian-9"

RUN apt-get update \
    && apt-get -y install   libsasl2-2 \
                            libsasl2-dev

COPY fluent-bit-${FLUENT_BIT_VERSION}.tar.gz /tmp/bitnami/pkg/cache/

RUN tar -zxf /tmp/bitnami/pkg/cache/fluent-bit-${FLUENT_BIT_VERSION}.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' \
    && rm -rf /tmp/bitnami/pkg/cache/fluent-bit-${FLUENT_BIT_VERSION}.tar.gz

ENV BITNAMI_APP_NAME="fluent-bit" \
    BITNAMI_IMAGE_VERSION=${FLUENT_BIT_VERSION} \
    PATH="/opt/bitnami/fluent-bit/bin:$PATH"

EXPOSE 2020