# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$


EAPI="5"

inherit rpm versionator

DESCRIPTION="1C ERP system"
HOMEPAGE="http://v8.1c.ru/"

MY_PV="$(replace_version_separator 3 '-' )"
NP="1C_Enterprise83"

if use amd64 ; then
	    ARCH_SUF="x86_64"
	elif use x86 ; then
	    ARCH_SUF="i386"
	else
	    die "unknown arch"
	fi

SRC_URI="thin_client? ( ${NP}-thin-client-${MY_PV}.${ARCH_SUF}.rpm
                nls2? ( ${NP}-thin-client-nls-${MY_PV}.${ARCH_SUF}.rpm ) )
        
         client?      ( ${NP}-client-${MY_PV}.${ARCH_SUF}.rpm 
                nls2? ( ${NP}-client-nls-${MY_PV}.${ARCH_SUF}.rpm ) )
                
	 server?      ( ${NP}-server-${MY_PV}.${ARCH_SUF}.rpm
                        ${NP}-common-${MY_PV}.${ARCH_SUF}.rpm
                nls2? ( ${NP}-server-nls-${MY_PV}.${ARCH_SUF}.rpm 
                        ${NP}-common-nls-${MY_PV}.${ARCH_SUF}.rpm ) )

         ws?          ( ${NP}-ws-${MY_PV}.${ARCH_SUF}.rpm
                nls2? ( ${NP}-ws-nls-${MY_PV}.${ARCH_SUF}.rpm ) )
                
	"

SLOT=$(get_version_component_range 1-4)
LICENSE="1CEnterprise_en"
KEYWORDS="amd64 x86"
RESTRICT="fetch strip"

IUSE="-nls -nls2 +thin_client client server ws"
REQUIRED_USE="nls?         ( || ( thin_client client server ws ) )
              thin_client? ( !client )
              thin_client? ( !server )
              thin_client? ( !ws )
              client?      ( server ) "



	
S="${WORKDIR}"
D="${ROOT}opt/1C/${PV}"

pkg_nofetch() {
    einfo "Please download"
    if use thin_client ; then
	einfo " ${NP}-thin-client-${MY_PV}.x86_64.rpm"
	use nls && einfo " ${NP}-thin-client-nls-${MY_PV}.x86_64.rpm"
    fi
    if use client ; then
	einfo " ${NP}-client-${MY_PV}.x86_64.rpm"
	use nls && einfo " ${NP}-client-nls-${MY_PV}.x86_64.rpm"
    fi
    if use server ; then
	einfo " ${NP}-server-${MY_PV}.x86_64.rpm"
	use nls && einfo " ${NP}-server-nls-${MY_PV}.x86_64.rpm"
    fi
    if use ws ; then
	if ! use server ; then
	    einfo " ${NP}-server-${MY_PV}.x86_64.rpm"
	    use nls && einfo " ${NP}-server-nls-${MY_PV}.x86_64.rpm"
	fi
    fi
    einfo "from https://releases.1c.ru/version_files?nick=Platform83&ver=8.3.8.1933 and place them in ${DISTDIR}"
}

src_install() {
	if use amd64 ; then
	    ARCH_DIR="x86_64"
	elif use x86 ; then
	    ARCH_DIR="i386"
	else
	    die "unknown arch"
	fi
	
	dodir /opt/1C/${ARCH_SUF}/${PV}
	
	mv "${WORKDIR}"/opt/1C/v8.3/${ARCH_SUF}/* "${D}"/opt/1C/${ARCH_SUF}/${PV}
}
