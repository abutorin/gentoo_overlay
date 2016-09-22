# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$


EAPI="5"

inherit rpm versionator

DESCRIPTION="1C ERP system common files"
HOMEPAGE="http://v8.1c.ru/"

MY_PV="$(replace_version_separator 3 '-' )"
NP="1C_Enterprise83-common"

SLOT=$(get_version_component_range 1-4)
LICENSE="1CEnterprise_en"
KEYWORDS="amd64 x86"
RESTRICT="fetch strip"

SRC_URI="x86? ( ${NP}-${MY_PV}.i386.rpm
         nls? ( ${NP}-nls-${MY_PV}.i386.rpm ) ) 
         amd64? ( ${NP}-${MY_PV}.x86_64.rpm
           nls? ( ${NP}-nls-${MY_PV}.x86_64.rpm ) )"

IUSE="-nls"

#RDEPEND="app-office/1C-Enterprise-common-${PVR}"
		   
S="${WORKDIR}"

if use x86 ; then
    DISTLINK="https://releases.1c.ru/version_files?nick=Platform83&ver=${PVR}/rpm.tar.gz"
    ARCH_SUF="i386"
elif use amd64 ; then
    DISTLINK="https://releases.1c.ru/version_files?nick=Platform83&ver=${PVR}/rpm64.tar.gz"
    ARCH_SUF="x86_64"
fi

pkg_nofetch() {
    einfo "1. Please download from:" 
    einfo "${DISTLINK}"
    einfo "2. Extract:"
    einfo " ${NP}-${MY_PV}.${ARCH_SUF}.rpm"
    use nls && einfo " ${NP}-nls-${MY_PV}.${ARCH_SUF}.rpm"
    einfo " To ${DISTDIR}"
}

src_install() {
	dodir /opt/1C/${ARCH_SUF}/${PV}
	mv "${WORKDIR}"/opt/1C/v8.3/${ARCH_SUF}/* "${D}"/opt/1C/${ARCH_SUF}/${PV}
}
