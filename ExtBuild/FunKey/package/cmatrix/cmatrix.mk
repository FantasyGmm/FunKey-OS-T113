###############################################################################
#
# Cmatrix
#
###############################################################################

CMATRIX_VERSION = ac78ef9b78948d4da162795fb4043e874dfd1ee8
CMATRIX_SITE_METHOD = git
CMATRIX_SITE = https://github.com/abishekvashok/cmatrix.git
CMATRIX_SITE_LICENSE = GNU GPL v3
CMATRIX_SITE_LICENSE_FILES = COPYING

CMATRIX_DEPENDENCIES = ncurses

CMATRIX_CFLAGS = $(TARGET_CFLAGS)
CMATRIX_LDFLAGS = -lncursesw
CMATRIX_CFLAGS += -DHAVE_SETFONT

define CMATRIX_BUILD_CMDS
	(cd $(@D); \
	gunzip -c matrix.psf.gz > matrix.psf; \
	autoreconf -i; \
	./configure --host=arm-linux-gnueabihf CC=$(TARGET_CC) LD=$(TARGET_LD) --without-fonts; \
	make \
	CROSS_COMPILE=$(TARGET_CROSS) \
	CFLAGS='$(CMATRIX_CFLAGS)' \
	LDFLAGS='$(CMATRIX_LDFLAGS)' \
	)
endef

define CMATRIX_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/cmatrix $(TARGET_DIR)/usr/bin/cmatrix
	$(INSTALL) -D -m 0755 $(@D)/matrix.psf $(TARGET_DIR)/usr/share/fonts/matrix.psf
endef

$(eval $(generic-package))