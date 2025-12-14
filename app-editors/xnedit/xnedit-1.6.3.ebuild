# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs

DESCRIPTION="Modernized fork of NEdit, with unicode support and AA text rendering"
HOMEPAGE="https://sourceforge.net/projects/xnedit"
SRC_URI="https://downloads.sourceforge.net/${PN}/${P}.tar.gz"
RESTRICT="mirror"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha amd64 ~mips ppc ~riscv sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc"

RDEPEND=">=x11-libs/motif-2.3:0
	x11-libs/libXt
	x11-libs/libX11"
DEPEND="${RDEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	dev-lang/perl"

S="${WORKDIR}/${P}"

PATCHES=(
	  "${FILESDIR}/${P}-doc.patch"
)

src_compile() {
	case "${CHOST}" in
		*-darwin*)
			emake CC="$(tc-getCC)" AR="$(tc-getAR)" macosx
			;;
		*-linux*)
			emake CC="$(tc-getCC)" AR="$(tc-getAR)" linux
			;;
	esac
	if use doc; then
		emake VERSION="XNEdit ${PV}" -C doc all
	fi
}

src_install() {
	dobin source/xnedit
	dobin source/xnc

	make_desktop_entry "${PN}"
	doicon "${WORKDIR}/${PN}/resources/desktop/${PN}.png"

	if use doc; then
		newman doc/xnedit.man xnedit.1
		newman doc/xnc.man xnc.1
	fi
}
