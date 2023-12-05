################################################################################
#
# clock sdl app
#
################################################################################

CLOCK_VERSION = v1.0-funkey-s
CLOCK_SITE_METHOD = git
CLOCK_SITE = https://github.com/DrUm78/clock_sdl_app.git
CLOCK_LICENSE = GPL-2.1+
CLOCK_LICENSE_FILES = LICENSE

CLOCK_DEPENDENCIES = sdl sdl_image

define CLOCK_BUILD_CMDS
	(cd $(@D); \
	sed -i -e 's|/opt/FunKey-sdk/usr/bin/arm-funkey-linux-musleabihf-gcc|$(HOST_DIR)/bin/$(BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX)-gcc|g' Makefile.funkey; \
	make -f Makefile.funkey \
	)
endef

define CLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/clock $(TARGET_DIR)/usr/bin/
endef

define CLOCK_CREATE_OPK
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/usr/local/share/OPKs/Settings
	mksquashfs $(CLOCK_PKGDIR)/opk $(TARGET_DIR)/usr/local/share/OPKs/Settings/clock_funkey-s.opk -all-root -noappend -no-exports -no-xattrs
endef
CLOCK_POST_INSTALL_TARGET_HOOKS += CLOCK_CREATE_OPK

$(eval $(generic-package))
