# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

MODULE_AUTHOR=JMV
MODULE_VERSION=1.62
MODULE_SECTION=modules
inherit perl-module
SRC_URI="http://www.cpan.org/authors/id/J/JM/JMV/${P}.tar.gz"

DESCRIPTION="Net::ICB -- Object oriented interface to an fnet server"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	perl-module_src_prepare
}

SRC_TEST="do"
