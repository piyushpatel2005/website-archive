# Hugo website

## Prerequisites

- Git
- Hugo

## Status

- Triggered Automatically on 1st and 16th of the month.

[![Build & Deploy Site](https://github.com/piyushpatel2005/piyushpatel2005.github.io/actions/workflows/hugo.yml/badge.svg)](https://github.com/piyushpatel2005/piyushpatel2005.github.io/actions/workflows/hugo.yml)

## Steps

```shell
hugo new site ./
```

Add a theme and start writing using 

```shell
hugo new about/index.md
hugo new posts/some-post/index.md
```

## Set up Decap CMS

This is React based single page app and is accessible under `<host>/admin` URL.
1. Create new files `static/admin/index.html` and `static/admin/config.toml`.


## Set up for new Theme

- Create new site

```bash
hugo new site personal-site
cd personal-site
# Create hugo module
hugo mod init github.com/piyushpatel2005/personal-site
# Add theme as dependency
hugo mod get github.com/razonyang/hugo-theme-bootstrap
```

- Get example site

```bash
git clone https://github.com/razonyang/hugo-theme-bootstrap-skeleton /tmp/hbs-skeleton
mkdir config
cp -a /tmp/hbs-skeleton/config/* ./config
cp -r /tmp/hbs-skeleton/content/* ./content
cp -r /tmp/hbs-skeleton/archetypes/* ./archetypes
cp -r /tmp/hbs-skeleton/static/* ./static
cp -r /tmp/hbs-skeleton/assets/* ./assets
rm -rf /tmp/hbs-skeleton
```

- Get hugo dependencies

```bash
hugo mod npm pack
npm install
hugo serve
```