# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
inherit multilib git-r3 qmake-utils

DESCRIPTION="Interactive image manipulation program supporting a wide variety of formats"
HOMEPAGE="https://github.com/jasper-software/xv"
EGIT_REPO_URI="https://github.com/jasper-software/xv.git"

LICENSE="xv"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="
	x11-libs/libXt
	media-libs/libjpeg-turbo
	media-libs/tiff
	>=media-libs/libpng-1.2
	sys-libs/zlib
"

RDEPEND="${DEPEND}"

src_configure() {
    cmake -H. -Btmp_cmake -DCMAKE_INSTALL_PREFIX=${D}/usr
}

src_compile() {
	cmake --build tmp_cmake || die
}

src_install() {
    cmake --build tmp_cmake --target install || die "Install failed"
}
