#!/bin/sh

# Add local path to init scripts
sed -i '3iexport PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin' ${TARGET_DIR}/etc/init.d/rcK
sed -i '3iexport PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin' ${TARGET_DIR}/etc/init.d/rcS

# Remove log daemon init scripts since they are loaded from inittab
rm -f ${TARGET_DIR}/etc/init.d/S01syslogd ${TARGET_DIR}/etc/init.d/S02klogd

# Remove dhcp lib dir and link to /tmp
rm -rf ${TARGET_DIR}/var/lib/dhcp/
ln -s /tmp ${TARGET_DIR}/var/lib/dhcp

# Remove dhcpcd dir and link to /tmp
rm -rf ${TARGET_DIR}/var/db/dhcpcd/
ln -s /tmp ${TARGET_DIR}/var/db/dhcpcd

# Redirect drobear keys to /tmp
rm -rf ${TARGET_DIR}/etc/dropbear
ln -s /tmp ${TARGET_DIR}/etc/dropbear

# Change dropbear init sequence
mv ${TARGET_DIR}/etc/init.d/S50dropbear ${TARGET_DIR}/etc/init.d/S42dropbear

BOARD_COMMON_DIR=$BR2_EXTERNAL_FUNKEY_PATH/../buildroot/board/allwinner-generic/sun8i-t113

# For debug
echo "Target binary dir $BOARD_COMMON_DIR"

# Copy Platfrom Files to BINARY_DIR
cp $BOARD_COMMON_DIR/bin/* -rfvd  $BINARIES_DIR

# Copy common file to BINARY_DIR
cp $BOARD_COMMON_DIR/../sunxi-generic/bin/* -rfvd $BINARIES_DIR
rm $BINARIES_DIR/boot-resource.fex
rm $BINARIES_DIR/boot0_sdcard.fex
cp $BR2_EXTERNAL_FUNKEY_PATH/board/funkey_t113//bin/* -rfvd $BINARIES_DIR

cd $BINARIES_DIR
echo "item=dtb, $5" >> boot_package.cfg

$BINARIES_DIR/dragonsecboot -pack boot_package.cfg
$BINARIES_DIR/mkenvimage -r -p 0x00 -s 131072 -o env.fex $BR2_EXTERNAL_FUNKEY_PATH/board/funkey_t113/scripts/env.cfg
mkbootimg --kernel zImage  --ramdisk  ramdisk.img --board sun8iw20p1 --base  0x40200000 --kernel_offset  0x0 --ramdisk_offset  0x01000000 -o  boot.img