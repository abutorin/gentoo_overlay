# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$


EAPI="5"

inherit rpm versionator

DESCRIPTION="1C:Enterprise thin client"
HOMEPAGE="http://v8.1c.ru/"

DIST_PV="$(replace_version_separator 3 '-' )"
NP="1C_Enterprise83-thin-client"

SLOT=${PV}
LICENSE="1CEnterprise_en"
KEYWORDS="amd64 x86"
RESTRICT="fetch strip"

#ARCH_SUF="x86? ( i386 ) 
#          amd64? ( x86_64 ) "
SRC_URI="x86? ( ${NP}-${DIST_PV}.i386.rpm
         nls? ( ${NP}-nls-${DIST_PV}.i386.rpm ) ) 
         amd64? ( ${NP}-${DIST_PV}.x86_64.rpm
           nls? ( ${NP}-nls-${DIST_PV}.x86_64.rpm ) )"

IUSE="-nls"

RDEPEND="!=app-office/1C-Enterprise-common-${PVR} 
        =net-libs/webkit-gtk-2.4.11-r200 
        >=media-gfx/imagemagick-6.6.9 
        >=media-libs/freetype-2.1.9
        >=media-libs/fontconfig-2.3.0
        >=gnome-extra/libgsf-1.10.1
        >=dev-libs/glib-2.12.4
        >=app-crypt/mit-krb5-1.4.2
        media-fonts/corefonts
        x11-themes/gtk-engines-adwaita"
        
S="${WORKDIR}"

pkg_nofetch() {
    DISTLINK=""
    if use x86 ; then
        DISTLINK="https://releases.1c.ru/version_files?nick=Platform83&ver=${PVR}"
	ARCH_SUF="i386"
    elif use amd64 ; then
        DISTLINK="https://releases.1c.ru/version_files?nick=Platform83&ver=${PVR}"
	ARCH_SUF="x86_64"
    fi

    einfo "1. Please download from:" 
    einfo "${DISTLINK}"
    einfo "2. Extract:"
    einfo " ${NP}-${DIST_PV}.${ARCH_SUF}.rpm"
    use nls && einfo " ${NP}-nls-${DIST_PV}.${ARCH_SUF}.rpm"
    einfo " To ${DISTDIR}"
}

src_install() {
    if use x86 ; then
	ARCH_SUF="i386"
    elif use amd64 ; then
	ARCH_SUF="x86_64"
    fi
    dodir /opt/1C/${ARCH_SUF}/${PV}
    mv "${WORKDIR}"/opt/1C/v8.3/${ARCH_SUF}/* "${D}"/opt/1C/${ARCH_SUF}/${PV}
    
    make_desktop_entry "/opt/1C/${ARCH_SUF}/${PV}/1cv8c" "1С(${PVR}) Тонкий клиент" 1cv8c-${PVR} "Office;Finance;" "Terminal=false\nStartupNotify=true"
}
