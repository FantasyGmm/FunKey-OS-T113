################################################################################
#
# gnuboy
#
################################################################################

GNUBOY_VERSION = v1.2.3-funkey-s
GNUBOY_SITE_METHOD = git
GNUBOY_SITE = https://github.com/DrUm78/gnuboy.git
GNUBOY_LICENSE = GPL-2.0
GNUBOY_LICENSE_FILES = COPYING

GNUBOY_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

GNUBOY_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard -ffast-math -funsafe-math-optimizations

GNUBOY_CFLAGS += -ggdb -O3

GNUBOY_CONF_OPTS += CFLAGS="$(GNUBOY_CFLAGS)"
GNUBOY_CONF_OPTS += --prefix=$(TARGET_DIR)/usr/local --bindir=$(TARGET_DIR)/usr/games
GNUBOY_CONF_OPTS += --without-fb \
		    --without-svgalib \
		    --without-x \
		    --with-sdl

GNUBOY_CONF_ENV += SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl-config"

define GNUBOY_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	mksquashfs $(GNUBOY_PKGDIR)/opk/gb_gbc $(TARGET_DIR)/usr/local/share/OPKs/Emulators/gb_gbc_gnuboy_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
GNUBOY_POST_INSTALL_TARGET_HOOKS += GNUBOY_CREATE_OPK

$(eval $(autotools-package))
