# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy pypy3 )
DISTUTILS_SINGLE_IMPL=Yes
inherit eutils git-r3 distutils-r1 udev

DESCRIPTION="CLI configuration utility for SteelSeries Rival mice"
HOMEPAGE="https://github.com/flozz/rivalcfg"
EGIT_REPO_URI="https://github.com/flozz/rivalcfg.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-python/setuptools"

RDEPEND="${DEPEND}
         virtual/udev
	 sys-fs/udev-init-scripts
"

python_prepare() {
        sed -i -e "s:/etc/udev:${S}/image/lib/udev:" "${S}"/setup.py
        epatch "${FILESDIR}"/setup.py.noudev.patch
        distutils-r1_python_prepare
}

python_install() {
        mkdir -p ${S}/image/lib/udev/rules.d
	distutils-r1_python_install
}

pkg_preinst() {
        insinto "$(get_udevdir)"/rules.d
        doins "${S}/image/lib/udev/rules.d/99-steelseries-rival.rules"
}

pkg_postinst() {
	udev_reload
}
