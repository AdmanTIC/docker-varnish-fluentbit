# Varnish based image with fluent-bit embedded (pre-compiled by Bitnami)

## Usage

```console
# Publish the image to public AdmanTIC repo.
$ ./publish_image.sh <fluent-bit-version> <varnish-version> <image-tag>
```

# Notes

* Before using the `publish_image` script, please, sign in on Docker hub using `docker login`
* `fluent-bit-version` follows Bitnami pre-compiled format. Unfortunately Bitnami does not maintain (on purpose) a public history of previous version. Nevertheless, typically, the version format is : `<fluent-bit-version>-linux-<arch>-<distrib>` (e.g. `1.3.6-0-linux-amd64-debian-9`)
* `varnish-version` refers to image on which the current image is based on. Please, check the available versions on the official repository (https://hub.docker.com/_/varnish?tab=tags)