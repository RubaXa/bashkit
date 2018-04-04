#!/bin/bash

PKG_JSON_RAW=`cat package.json 2>&1`;

_pkgJsonReadProp() {
	stringGetMatch "\"$1\"[^:]*:[^\"]*\"([^\"]*)" "$PKG_JSON_RAW";
}

PKG_JSON_NAME=$(_pkgJsonReadProp "name");
PKG_JSON_VERSION=$(_pkgJsonReadProp "version");
PKG_JSON_DESCRIPTION=$(_pkgJsonReadProp "description");
PKG_JSON_AUTHOR=$(_pkgJsonReadProp "author");
PKG_JSON_MAIN=$(_pkgJsonReadProp "main");
PKG_JSON_GIT_URL=$(_pkgJsonReadProp "url");
