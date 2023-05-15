# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Fast, flexible, modular system monitoring tool for Unix and the X Window System"
HOMEPAGE="https://www.gedanken.org.uk/software/procmeter3/"
SRC_URI="https://www.gedanken.org.uk/software/procmeter3/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk lcd log"
RESTRICT="mirror"

DEPEND="x11-libs/libXaw
	gtk?  (	x11-libs/libX11
		>=x11-libs/gtk+-2.0 )
	lcd?  (	app-misc/lcdproc )"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-Makefile.patch
	"${FILESDIR}"/${P}-statfs-overflow.patch
	"${FILESDIR}"/${P}-acpi-c.patch
	"${FILESDIR}"/${P}-off_t.patch
	"${FILESDIR}"/${P}-diskusage.patch
	"${FILESDIR}"/${P}-stat-disk-sysmacros.patch
	"${FILESDIR}"/${P}-libsensors-version-check.patch
	"${FILESDIR}"/${P}-module-disable-option.patch
)


src_prepare() {
	default

	cp "${FILESDIR}"/procmeterrc "${S}"/procmeterrc
}

src_compile() {
	local targets='procmeter3-xaw'
	use gtk && targets="${targets} procmeter3-gtk2"
	use log && targets="${targets} procmeter3-log"
	use lcd && targets="${targets} procmeter3-lcd"
	einfo "Selected build targets: $targets"

	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS}" \
		DESTDIR="${D}" \
		${targets} || die "emake failed"

	[ -f ${S}/procmeter3-xaw ]  || \
	[ -f ${S}/procmeter3-lcd ]  || \
	[ -f ${S}/procmeter3-log ]  || \
	[ -f ${S}/procmeter3-gtk2 ] || \
	die "emake failed to build any selected target."
}

src_install() {
	emake \
		DESTDIR="${D}" \
		install || die "emake install failed"
        
	[ -f "${D}"/usr/bin/procmeter3-gtk2 ] && ln -fs procmeter3-gtk2 "${D}"/usr/bin/gprocmeter3
	[ -f "${D}"/usr/bin/procmeter3-xaw ] && ln -fs procmeter3-xaw "${D}"/usr/bin/procmeter3
}
