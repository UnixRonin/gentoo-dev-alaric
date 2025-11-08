# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit multilib git-r3 qmake-utils

DESCRIPTION="A simple migration tool for GnuPG profiles"
HOMEPAGE="https://rjhansen.github.io/sherpa/"
EGIT_REPO_URI="https://github.com/rjhansen/sherpa.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib[minizip]
        >=app-crypt/gpgme-1.6.0
        >=dev-qt/qtcore-5.0.0"

RDEPEND="${DEPEND}"

src_configure() {
        qmake -qt=qt5
}

src_compile() {
	emake || die
}

src_install() {
	dobin sherpa || die "dobin failed"
}
