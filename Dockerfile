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

# Install modules
COPY lib/libvmod-digest-6.6.tar.gz /etc/varnish

RUN cd /etc/varnish \
    && mkdir libvmod-digest \
    && tar -zxf libvmod-digest-6.6.tar.gz -C libvmod-digest --strip-components 1 \
    && rm -rf /etc/varnish/libvmod-digest-6.6.tar.gz \
    && apt-get update \
    && apt-get -y install pkg-config \
    && apt-get -y install gcc automake pkgconf \
        libvarnishapi-dev \
        libmhash-dev \
        python3-docutils \
        libtool \
    && cd /etc/varnish/libvmod-digest \
    && export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig \
    && ./autogen.sh \
    && ./configure \
    && make \
    && dpkg -r --force-depends automake make

EXPOSE 2020