# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

MODULE_AUTHOR=RCS
MODULE_VERSION=1.11
MODULE_SECTION=modules

inherit perl-module

SRC_URI="http://cpan.metacpan.org/authors/id/R/RC/RCS/${P}.tar.gz"

DESCRIPTION="Tk::MListbox - Multicolumn Listbox"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/MListbox-${PVR}"


src_prepare() {
	perl-module_src_prepare
}

SRC_TEST="do"
