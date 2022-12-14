# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker xdg-utils gnome2-utils

DESCRIPTION="Multi-platform music-creation system for production, performance and DJing"
HOMEPAGE="http://bitwig.com"
SRC_URI="https://downloads.bitwig.com/stable/${PV}/${P}.deb"
LICENSE="Bitwig"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

IUSE="+jack"

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/bzip2
	dev-libs/expat
	gnome-extra/zenity
	jack? ( media-sound/jack2 )
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:0/16
	media-libs/mesa
	sys-libs/zlib
	media-video/ffmpeg
	virtual/opengl
	virtual/udev
	x11-libs/gtk+:3
	x11-libs/cairo[X]
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbfile
	x11-libs/pixman
	x11-libs/xcb-util-wm
"

QA_PREBUILT="
	opt/bitwig-studio/bin/*
	opt/bitwig-studio/lib/engine/*
"

QA_PRESTRIPPED="
	opt/bitwig-studio/bitwig-studio
	opt/bitwig-studio/bin/BitwigStudioEngine
	opt/bitwig-studio/bin/bitwig-vamphost
	opt/bitwig-studio/bin/BitwigPluginHost64
	opt/bitwig-studio/bin32/BitwigPluginHost32
	opt/bitwig-studio/lib/bitwig-studio/.*
	opt/bitwig-studio/lib/vamp-plugins/.*
"

S=${WORKDIR}

src_install() {
	BITWIG_HOME="/opt/bitwig-studio"
	dodir ${BITWIG_HOME}
	insinto ${BITWIG_HOME}
	doins -r opt/bitwig-studio/*
	fperms +x ${BITWIG_HOME}/bitwig-studio
	fperms +x ${BITWIG_HOME}/bin/BitwigPluginHost64
	fperms +x ${BITWIG_HOME}/bin/BitwigStudio
	fperms +x ${BITWIG_HOME}/bin/BitwigStudioEngine
	fperms +x ${BITWIG_HOME}/bin/bitwig-vamphost
	fperms +x ${BITWIG_HOME}/bin/show-splash-gtk
	fperms +x ${BITWIG_HOME}/bin/show-file-dialog-gtk3
	fperms +x ${BITWIG_HOME}/bin32/BitwigPluginHost32
	dosym ${BITWIG_HOME}/bitwig-studio /usr/bin/bitwig-studio

	doicon -s scalable usr/share/icons/hicolor/scalable/apps/bitwig-studio.svg
	sed -i \
	-e 's/Icon=.*/Icon=bitwig-studio/' \
	-e 's/Categories=.*/Categories=AudioVideo;Audio;AudioVideoEditing/' \
	usr/share/applications/bitwig-studio.desktop || die 'sed on desktop file failed'
	domenu usr/share/applications/bitwig-studio.desktop
	doicon -s scalable -c mimetypes usr/share/icons/hicolor/scalable/mimetypes/*.svg
	insinto /usr/share/mime/packages
	doins usr/share/mime/packages/bitwig-studio.xml
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
