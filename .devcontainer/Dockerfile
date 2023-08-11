# FROM ubuntu
# FROM mcr.microsoft.com/devcontainers/universal:2

# VARIANT can be either 'hugo' for the standard version or 'hugo_extended' for the extended version.
# ARG VARIANT=hugo_extended
# VERSION can be either 'latest' or a specific version number
# ARG VERSION=latest

# RUN apt update -y && \
#     apt upgrade -y && \
#     apt install wget curl git -y && \
#     case ${VERSION} in \
#     latest) \
#     export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') ;;\
#     esac && \
#     echo ${VERSION} && \
#     wget -O ${VERSION}.deb https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-amd64.deb && \
#     dpkg -i ${VERSION}.deb && rm ${VERSION}.deb

# FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-3.12
# Required for hugo_extended
# RUN apk add --update --no-cache libc6-compat
# COPY --from=0 hugo /usr/bin
# EXPOSE 1313
# WORKDIR /src
# CMD ["/usr/bin/hugo server"]



# Use the golang:1.13 base image for building Hugo
FROM golang:1.13 AS builder

# VARIANT can be either 'hugo' for the standard version or 'hugo_extended' for the extended version.
ARG VARIANT=hugo_extended
# VERSION can be either 'latest' or a specific version number
ARG VERSION=0.115.1

RUN sed -i 's/debian.map.fastlydns.net/deb.debian.org/' /etc/apt/sources.list && \
    apt-get update && apt-get install -y ca-certificates openssl git curl nodejs npm && \
    rm -rf /var/lib/apt/lists/* && \
    case ${VERSION} in \
    latest) \
    export VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | grep "tag_name" | awk '{print substr($2, 3, length($2)-4)}') ;;\
    esac && \
    echo ${VERSION} && \
    wget -O ${VERSION}.tar.gz https://github.com/gohugoio/hugo/releases/download/v${VERSION}/${VARIANT}_${VERSION}_Linux-64bit.tar.gz && \
    tar xf ${VERSION}.tar.gz && \
    mv hugo* /usr/bin/hugo && \
    go get github.com/yaegashi/muslstack && \
    muslstack -s 0x800000 /usr/bin/hugo


# Use a separate stage for the final image
FROM mcr.microsoft.com/vscode/devcontainers/base

# Install Go, Nodejs and npm in the final image (required for the Hugo binary to work)
# Then install PostCSS, postcss-cli, and autoprefixer globally using npm.
RUN apt-get update && apt-get install -y golang nodejs npm && npm install -g postcss postcss-cli autoprefixer && rm -rf /var/lib/apt/lists/*

# Copy the Hugo binary from the builder stage to the final image
COPY --from=builder /usr/bin/hugo /usr/bin

# Set other configurations or commands specific to your devcontainer

EXPOSE 1313
