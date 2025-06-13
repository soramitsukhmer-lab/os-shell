ARG S6_OVERLAY_VERSION=v3.2.1.0
FROM harbor.sorakh.io/hub/socheatsok78/s6-overlay:${S6_OVERLAY_VERSION} AS s6-overlay

FROM harbor.sorakh.io/hub/alpine:latest AS gh
ARG TARGETARCH
ARG GH_VERSION=2.74.1
ADD https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${TARGETARCH}.tar.gz /tmp/gh.tar.gz
WORKDIR /tmp/gh
RUN tar -xzf /tmp/gh.tar.gz -C /tmp/gh --strip-components=1

FROM harbor.sorakh.io/hub/alpine:latest
RUN apk add --no-cache bash curl git ca-certificates
COPY --from=gh --link /tmp/gh /usr/local/
COPY --link --from=s6-overlay / /
ENTRYPOINT [ "/init" ]
CMD [ "/bin/bash" ]
