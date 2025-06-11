#!/bin/bash

# Usage :
# $ ./publish_image.sh <fluent-bit-version> <image-tag>

# Set default arguments
ARG1=${1:-}
ARG2=${2:-}
ARG3=${3:-$2-$1}

if [ -z "$ARG1" ]; then
    echo "$0: missing Fluent-bit version"
    echo "N.B.: This image uses Bitnami precompiled fluent-bit"
    echo "version format is: <fluent-bit-version>-linux-<arch>-<distrib>"
    echo "(e.g. : 1.3.6-0-linux-amd64-debian-9)"
    echo "Usage: $ ./publish_image.sh <fluent-bit-version> <varnish-version> <image-tag>"
    exit -1
fi

if [ -z "$ARG2" ]; then
    echo "$0: missing Varnish base image version"
    echo "Please, refer to https://hub.docker.com/_/varnish?tab=tags"
    echo "Usage: $ ./publish_image.sh <fluent-bit-version> <varnish-version> <image-tag>"
    exit -1
fi

# wget -q -nc -P . https://downloads.bitnami.com/files/stacksmith/fluent-bit-${ARG1}.tar.gz
curl -L https://downloads.bitnami.com/files/stacksmith/fluent-bit-${ARG1}-0-linux-amd64-debian-12.tar.gz -o fluent-bit-${ARG1}.tar.gz

docker build -t admantic/varnish-fluentbit:${ARG3} --build-arg FLUENT_BIT_VERSION=${ARG1} --build-arg VARNISH_VERSION=${ARG2} .
docker push admantic/varnish-fluentbit:${ARG3}