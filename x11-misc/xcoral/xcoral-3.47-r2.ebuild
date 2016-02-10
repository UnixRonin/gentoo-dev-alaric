# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils multilib

DESCRIPTION="multiwindow mouse-based text editor for Unix and X Window System"
HOMEPAGE="http://xcoral.free.fr/"
SRC_URI="http://xcoral.free.fr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-hostname-in-title.patch
}

src_configure() {
	econf --with-x || die
}

XCORAL_SHAREDIR=/usr/share/xcoral

src_compile() {
	local makeopts="XCORALLIBDIR=\\\"${XCORAL_SHAREDIR}\\\""
	pushd "${S}/Smac"
	emake -j1 word.h y.tab.c || die
	emake all ${makeopts} || die
	popd
	emake ${makeopts} || die
}

src_install() {
	dobin xcoral
	dodoc README
	insinto ${XCORAL_SHAREDIR}
	doins SmacLib/*
}
