# Copyright 2000-2015 Phil Stracchino
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5


DESCRIPTION="A multithreaded command-line/ncurses ICB client in Perl"
HOMEPAGE="http://co.ordinate.org/icbm/"
SRC_URI="http://co.ordinate.org/icbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="encryption"


RDEPEND="
	>=dev-lang/perl-5.6.0[ithreads]
	dev-perl/Curses
	dev-perl/Net-ICB
	dev-perl/TermReadKey
	encryption? (
		dev-perl/Math-BigInt-GMP
		dev-perl/Crypt-Blowfish
		dev-perl/crypt-cbc
		dev-perl/crypt-dh
		dev-perl/crypt-primes
		dev-perl/crypt-random
		dev-perl/math-pari
	)"


DEPEND="${RDEPEND}"

src_configure () {
	true;
}

src_compile () {
	true;
}

src_install () {
	dobin icbm primegen
	dodoc README.ICBM README.ENCRYPTION TODO BUGS Changelog
	doman icbm.1
	dodir /usr/share/icb
	insinto /usr/share/icb
	doins icbserverdb primes
}
