# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xtrabackup-bin/xtrabackup-bin-2.2.5.ebuild,v 1.3 2015/02/25 15:45:24 ago Exp $

EAPI=5

inherit eutils

DESCRIPTION="Fast binary backup software for MySQL and MySQL-based databases"
HOMEPAGE="http://www.percona.com/software/percona-xtrabackup"
SRC_URI="http://www.percona.com/downloads/XtraBackup/Percona-XtraBackup-${PV}/source/tarball/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="tests"

DEPEND=""
RDEPEND="dev-libs/libaio
	|| ( dev-libs/libgcrypt:0/11 dev-libs/libgcrypt:11/11 )
	dev-libs/libgpg-error
	dev-perl/DBD-mysql
	sys-libs/zlib"

src_configure() {
	if use tests ; then
		cmake -DBUILD_CONFIG=xtrabackup_release -DINSTALL_LAYOUT=RPM
	else
		cmake -DBUILD_CONFIG=xtrabackup_release -DINSTALL_LAYOUT=RPM -DINSTALL_MYSQLTESTDIR=0
        fi
}

