# Copyright 2000-2015 Phil Stracchino
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5


DESCRIPTION="A SQL-backed Perl/Tk music jukebox"
HOMEPAGE="http://co.ordinate.org/perljammer/"
SRC_URI="http://co.ordinate.org/perljammer/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
RESTRICT="mirror"


RDEPEND="
	|| ( >=dev-lang/perl-5.6.0[ithreads]
         >=dev-lang/perl-5.38.2[perl_features_ithreads]
    )
	>=dev-perl/Tk-804
	dev-perl/DBI
	dev-perl/MP3-Info
	dev-perl/MP3-Tag
    dev-perl/Ogg-Vorbis-Header
	dev-perl/Tk-MListbox
	virtual/mysql
	"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P/PV}"

src_configure () {
	true;
}

src_compile () {
	true;
}

src_install () {
	dobin perljammer remotejammer
	dobin id3fix id3read id3write id3sort oggread oggwrite
	dobin mp3insert pjam-dbtool pjam-import pjam-insert pjam-remote
	dodoc schema
	doman *.1
	dodir /usr/share/perljammer
	insinto /usr/share/perljammer
	doins *.xpm
	dodir /usr/share/perljammer/skins
	insinto /usr/share/perljammer/skins
	doins skins/*
}
