# Copyright 2000-2015 Phil Stracchino
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8


DESCRIPTION="A multithreaded command-line/ncurses ICB client in Perl"
HOMEPAGE="http://co.ordinate.org/icbm/"
SRC_URI="http://co.ordinate.org/icbm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE="encryption"
RESTRICT="mirror"

RDEPEND="
	|| ( >=dev-lang/perl-5.6.0[ithreads]
         >=dev-lang/perl-5.38.2[perl_features_ithreads]
    )
	dev-perl/Curses
	dev-perl/TermReadKey
	encryption? (
		dev-perl/Crypt-DH-GMP
		dev-perl/Crypt-Blowfish
		dev-perl/Crypt-CBC
		dev-perl/Crypt-Primes
		dev-perl/Crypt-Random
		dev-perl/Math-Pari
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
	dodir /usr/share/icb/Net
	insinto /usr/share/icb/Net
    doins ICB.pm
}
