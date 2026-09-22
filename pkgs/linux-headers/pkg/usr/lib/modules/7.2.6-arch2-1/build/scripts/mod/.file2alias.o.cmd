savedcmd_scripts/mod/file2alias.o := gcc -Wp,-MMD,scripts/mod/.file2alias.o.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu11   -I ./scripts/include   -c -o scripts/mod/file2alias.o scripts/mod/file2alias.c

source_scripts/mod/file2alias.o := scripts/mod/file2alias.c

deps_scripts/mod/file2alias.o := \
  scripts/include/list.h \
  scripts/include/list_types.h \
  scripts/include/xalloc.h \
  scripts/mod/modpost.h \
  scripts/mod/../../include/linux/module_symbol.h \
  scripts/mod/elfconfig.h \
  scripts/mod/devicetable-offsets.h \
  scripts/mod/../../include/linux/mod_devicetable.h \
  scripts/mod/../../include/linux/device-id/acpi.h \
  scripts/mod/../../include/linux/device-id/amba.h \
  scripts/mod/../../include/linux/device-id/ap.h \
  scripts/mod/../../include/linux/device-id/apr.h \
  scripts/mod/../../include/linux/device-id/auxiliary.h \
  scripts/mod/../../include/linux/device-id/bcma.h \
  scripts/mod/../../include/linux/device-id/ccw.h \
  scripts/mod/../../include/linux/device-id/cdx.h \
  scripts/mod/../../include/linux/device-id/coreboot.h \
  scripts/mod/../../include/linux/device-id/css.h \
  scripts/mod/../../include/linux/device-id/dfl.h \
  scripts/mod/../../include/linux/device-id/dmi.h \
  scripts/mod/../../include/linux/device-id/eisa.h \
  scripts/mod/../../include/linux/device-id/fsl_mc.h \
  scripts/mod/../../include/linux/device-id/hda.h \
  scripts/mod/../../include/linux/device-id/hid.h \
  scripts/mod/../../include/linux/device-id/hv_vmbus.h \
  scripts/mod/../../include/linux/device-id/i2c.h \
  scripts/mod/../../include/linux/device-id/i3c.h \
  scripts/mod/../../include/linux/device-id/ieee1394.h \
  scripts/mod/../../include/linux/device-id/input.h \
  scripts/mod/../../include/linux/device-id/ipack.h \
  scripts/mod/../../include/linux/device-id/isapnp.h \
  scripts/mod/../../include/linux/device-id/ishtp.h \
  scripts/mod/../../include/linux/device-id/mcb.h \
  scripts/mod/../../include/linux/device-id/mdio.h \
  scripts/mod/../../include/linux/device-id/mei_cl.h \
  scripts/mod/../../include/linux/device-id/mhi.h \
  scripts/mod/../../include/linux/device-id/mips_cdmm.h \
  scripts/mod/../../include/linux/device-id/of.h \
  scripts/mod/../../include/linux/device-id/parisc.h \
  scripts/mod/../../include/linux/device-id/pci.h \
  scripts/mod/../../include/linux/device-id/pcmcia.h \
  scripts/mod/../../include/linux/device-id/platform.h \
  scripts/mod/../../include/linux/device-id/pnp.h \
  scripts/mod/../../include/linux/device-id/rio.h \
  scripts/mod/../../include/linux/device-id/rpmsg.h \
  scripts/mod/../../include/linux/device-id/sdio.h \
  scripts/mod/../../include/linux/device-id/sdw.h \
  scripts/mod/../../include/linux/device-id/serio.h \
  scripts/mod/../../include/linux/device-id/slim.h \
  scripts/mod/../../include/linux/device-id/spi.h \
  scripts/mod/../../include/linux/device-id/spmi.h \
  scripts/mod/../../include/linux/device-id/ssam.h \
  scripts/mod/../../include/linux/device-id/ssb.h \
  scripts/mod/../../include/linux/device-id/tb.h \
  scripts/mod/../../include/linux/device-id/tee_client.h \
  scripts/mod/../../include/linux/device-id/typec.h \
  scripts/mod/../../include/linux/device-id/ulpi.h \
  scripts/mod/../../include/linux/device-id/usb.h \
  scripts/mod/../../include/linux/device-id/vchiq.h \
  scripts/mod/../../include/linux/device-id/vio.h \
  scripts/mod/../../include/linux/device-id/virtio.h \
  scripts/mod/../../include/linux/device-id/wmi.h \
  scripts/mod/../../include/linux/device-id/x86_cpu.h \
  scripts/mod/../../include/linux/device-id/zorro.h \

scripts/mod/file2alias.o: $(deps_scripts/mod/file2alias.o)

$(deps_scripts/mod/file2alias.o):
