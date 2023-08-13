#!/usr/bin/env bash

BASE_DIR=$(dirname "$0")
HUGO_VERSION="0.117.0"
echo "wget https://github.com/gohugoio/hugo/releases/download/v0.117.0/hugo_extended_${HUGO_VERSION}_linux-amd64.deb -O ${BASE_DIR}/../hugo_extended.deb"
wget https://github.com/gohugoio/hugo/releases/download/v0.117.0/hugo_extended_${HUGO_VERSION}_linux-amd64.deb -O ${BASE_DIR}/../hugo_extended.deb
echo "dpkg -i ${BASE_DIR}/../hugo_extended_*.deb"
dpkg -i ${BASE_DIR}/../hugo_extended.deb
hugo version
rm -f ${BASE_DIR}/../hugo_extended.deb
cd $BASE_DIR
hugo server --port 8080
