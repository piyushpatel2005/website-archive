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
