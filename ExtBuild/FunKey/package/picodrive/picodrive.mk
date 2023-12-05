################################################################################
#
# picodrive
#
################################################################################

PICODRIVE_VERSION = v1.4-funkey-s
PICODRIVE_SITE_METHOD = git
PICODRIVE_SITE = https://github.com/DrUm78/picodrive-funkey.git
PICODRIVE_LICENSE = MAME
PICODRIVE_LICENSE_FILES = COPYING

PICODRIVE_DEPENDENCIES = sdl sdl_image sdl_mixer sdl_ttf zlib

PICODRIVE_CFLAGS = $(TARGET_CFLAGS) $(subst $\",,$(BR2_TARGET_OPTIMIZATION)) -mfloat-abi=hard -ffast-math -funsafe-math-optimizations

PICODRIVE_CONF_OPTS += --platform=generic --sound-drivers=sdl
PICODRIVE_CFLAGS += -ggdb -O3

PICODRIVE_LIBS += -lSDL_image -lSDL_ttf

define PICODRIVE_CONFIGURE_CMDS
	(cd $(@D); \
	chmod +x configure; \
	sed -i -e 's/-mcpu/-mtune/g' configure; \
	CFLAGS='$(PICODRIVE_CFLAGS)' \
	CROSS_COMPILE=$(TARGET_CROSS) \
	LDFLAGS='-L$(TARGET_DIR)/usr/lib' \
	LDLIBS='$(PICODRIVE_LIBS)'\
	./configure $(PICODRIVE_CONF_OPTS) \
	)
endef

define PICODRIVE_BUILD_CMDS
	(cd $(@D); \
	make \
	)
endef

PICODRIVE_GIT_SUBMODULES = YES

define PICODRIVE_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/games
	$(INSTALL) -m 0755 $(@D)/PicoDrive $(TARGET_DIR)/usr/games/
endef

define PICODRIVE_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Emulators
	mksquashfs $(PICODRIVE_PKGDIR)/opk/megadrive $(TARGET_DIR)/usr/local/share/OPKs/Emulators/megadrive_picodrive_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
PICODRIVE_POST_INSTALL_TARGET_HOOKS += PICODRIVE_CREATE_OPK

$(eval $(generic-package))
