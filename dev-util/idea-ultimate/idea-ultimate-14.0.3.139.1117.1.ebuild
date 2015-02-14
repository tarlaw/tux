# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils versionator

SLOT="$(get_major_version)"
RDEPEND=">=virtual/jdk-1.7"

MY_PN="idea"
MY_PV="$(get_version_component_range 4-6)"

RESTRICT="strip"
QA_TEXTRELS="opt/${P}/bin/libbreakgen.so"

DESCRIPTION="IntelliJ IDEA is an intelligent Java IDE (Ultimate Edition)"
HOMEPAGE="http://jetbrains.com/idea/"
SRC_URI="http://download-cf.jetbrains.com/${MY_PN}/${MY_PN}IU-$(get_version_component_range 1-3).tar.gz"
# LICENSE="Apache-2.0"
IUSE=""
KEYWORDS="~x86 ~amd64"
S="${WORKDIR}/${MY_PN}-IU-${MY_PV}"

src_install() {
	local dir="/opt/${P}"
	local exe="${PN}-${SLOT}"

	insinto "${dir}"
	doins -r *
	fperms 755 "${dir}/bin/${MY_PN}.sh" "${dir}/bin/fsnotifier" "${dir}/bin/fsnotifier64"

	newicon "bin/${MY_PN}.png" "${exe}.png"
	make_wrapper "${exe}" "/opt/${P}/bin/${MY_PN}.sh"
	make_desktop_entry ${exe} "IntelliJ IDEA $(get_version_component_range 1-3)	(Ultimate Edition)" "${exe}" "Development;IDE"
}
