FROM ubuntu
# FROM mcr.microsoft.com/devcontainers/universal:2

# VARIANT can be either 'hugo' for the standard version or 'hugo_extended' for the extended version.
ARG VARIANT=hugo_extended
# VERSION can be either 'latest' or a specific version number
ARG VERSION=latest

RUN apt update -y && \
    apt upgrade -y && \
    apt install wget curl git -y && \
    case ${VERSION} in \
    latest) \
    export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') ;;\
    esac && \
    echo ${VERSION} && \
    wget -O ${VERSION}.deb https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-amd64.deb && \
    dpkg -i ${VERSION}.deb && rm ${VERSION}.deb

# FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-3.12
# Required for hugo_extended
# RUN apk add --update --no-cache libc6-compat
# COPY --from=0 hugo /usr/bin
# EXPOSE 1313
# WORKDIR /src
# CMD ["/usr/bin/hugo server"]
