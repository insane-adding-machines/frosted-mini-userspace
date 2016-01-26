-include ../kconfig/.config
-include ../config.mk

CROSS_COMPILE?=arm-none-eabi-
CC=$(CROSS_COMPILE)gcc
CFLAGS+=-DCONFIG_FRESH=1
CFLAGS += -DCONFIG_IDDLELEDS=1
APPS-y:=apps/init.o 
APPS-y+=apps/fresh.o
APPS-y+=apps/binutils.o
APPS-y+=apps/stubs.o
CFLAGS+=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -fno-common
CFLAGS+=-DCORE_M3 -DARCH_$(ARCH)
CFLAGS+=-DKLOG_LEVEL=6
#Include paths
CFLAGS+=-I. -I$(FROSTED)/include -I$(FROSTED)/newlib/include
#Freestanding options
CFLAGS+=-fno-builtin
CFLAGS+=-ffreestanding
#Debugging
CFLAGS+=-ggdb -nostartfiles
ASFLAGS:=-mcpu=cortex-m3 -mthumb -mlittle-endian -mthumb-interwork -ggdb
LDFLAGS+=-L.

all: $(FROSTED)/apps.img

$(FROSTED)/apps.img: apps.elf
	$(CROSS_COMPILE)objcopy -O binary --pad-to=$$PADTO $^ $@

apps/apps.ld: apps/apps.ld.in
	export KMEM_SIZE_B=`python2 -c "print '0x%X' % ( $(KFLASHMEM_SIZE) * 1024)"`;	\
	export AMEM_SIZE_B=`python2 -c "print '0x%X' % ( ($(RAM_SIZE) - $(KRAMMEM_SIZE)) * 1024)"`;	\
	export KFLASHMEM_SIZE_B=`python2 -c "print '0x%X' % ( $(KFLASHMEM_SIZE) * 1024)"`;	\
	export AFLASHMEM_SIZE_B=`python2 -c "print '0x%X' % ( ($(FLASH_SIZE) - $(KFLASHMEM_SIZE)) * 1024)"`;	\
	export KRAMMEM_SIZE_B=`python2 -c "print '0x%X' % ( $(KRAMMEM_SIZE) * 1024)"`;	\
	cat $^ | sed -e "s/__FLASH_ORIGIN/$(FLASH_ORIGIN)/g" | \
			 sed -e "s/__KFLASHMEM_SIZE/$$KFLASHMEM_SIZE_B/g" | \
			 sed -e "s/__AFLASHMEM_SIZE/$$AFLASHMEM_SIZE_B/g" | \
			 sed -e "s/__RAM_BASE/$(RAM_BASE)/g" |\
			 sed -e "s/__KRAMMEM_SIZE/$$KRAMMEM_SIZE_B/g" |\
			 sed -e "s/__AMEM_SIZE/$$AMEM_SIZE_B/g" \
			 >$@




apps.elf: libfrosted.a $(APPS-y) apps/apps.ld
	$(CC) -o $@  $(APPS-y) -Tapps/apps.ld -lfrosted -lc -lfrosted -Wl,-Map,apps.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)

libfrosted.a: libfrosted
	make -C libfrosted FROSTED=$(FROSTED)

clean:
	make -C apps clean
	make -C libfrosted clean
	@rm -f apps/apps.ld
	@rm -f apps.elf
	@rm -f apps.map


