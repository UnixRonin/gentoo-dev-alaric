# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils multilib toolchain-funcs

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

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Apply procmeter3-Makefile.patch:
	#	- fix up the directory paths to Gentoo standards
	epatch "${FILESDIR}"/${P}-Makefile.patch

	# Apply procmeter3-3.6-statfs-overflow.patch:
	#	- make df.c report statfs overflows on >2TB filesystems
	epatch "${FILESDIR}"/${P}-statfs-overflow.patch

	# Apply procmeter3-3.6-acpi-c.patch:
	#	- fix off-by-one error in get_acpi_file()
	epatch "${FILESDIR}"/${P}-acpi-c.patch

	# Apply procmeter3-3.6-off_t.patch:
	#	- replace nonexistent loff_t type in longrun.c with off_t
	epatch "${FILESDIR}"/${P}-off_t.patch

	# Apply procmeter3-3.6-stat-disk-sysmacros.patch:
	#	- properly include <sys/sysmacros.h> for major() and minor() macros
	epatch "${FILESDIR}"/${P}-stat-disk-sysmacros.patch

	# Replace the awful config example supplied in the source tarball with a
	# better one so that we don't turn users off the tool at first sight

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

