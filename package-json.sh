#!/bin/bash

# @param path
pkgJsonRead() {
	cat "$(default "$1" ".")/package.json" 2>&1;
}

# @param raw — a result of `pkgJsonRead`
# @param prop
pkgJsonReadProp() {
	stringGetMatch "\"$1\"[^:]*:[^\"]*\"([^\"]*)" "$(default "$2" "$PKG_JSON_RAW")";
}

PKG_JSON_RAW=$(pkgJsonRead);
PKG_JSON_NAME=$(pkgJsonReadProp "name");
PKG_JSON_VERSION=$(pkgJsonReadProp "version");
PKG_JSON_DESCRIPTION=$(pkgJsonReadProp "description");
PKG_JSON_AUTHOR=$(pkgJsonReadProp "author");
PKG_JSON_MAIN=$(pkgJsonReadProp "main");
PKG_JSON_GIT_URL=$(pkgJsonReadProp "url");
