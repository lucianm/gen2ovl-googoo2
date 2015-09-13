#!/bin/bash
# Generate the various interface files that normally requires java.
# This makes building the release versions much nicer.

set -eux

PV=$1
PN=kodi
MY_PV=${PV/_p/_r}
MY_PV=${PV/_rc/rc}
MY_P="${PN}-${MY_PV}"
CODENAME=$2

P="${PN}-${MY_PV}"
MY_S_SUBDIR="xbmc-${MY_PV}-${CODENAME}"
S="/var/tmp/portage/media-tv/${PN}-${PV}/work/${MY_S_SUBDIR}"

FILESDIR=$(pwd)

cd ${S}
make -C . -j -f codegenerator.mk

cd ..

tar="${MY_P}-generated-addons.tar.xz"
tar cf - \
	${MY_S_SUBDIR}/xbmc/interfaces/python/generated/*.cpp \
	${MY_S_SUBDIR}/xbmc/interfaces/json-rpc/ServiceDescription.h \
	| xz > "${tar}"
du -b "${tar}"
mv -f ${tar} ${FILESDIR}

cd ${FILESDIR}
for patchfile in no-arm-flags nomythtv texturepacker; do
	ln -f -s kodi-9999-${patchfile}.patch kodi-${PV}-${patchfile}.patch
done
