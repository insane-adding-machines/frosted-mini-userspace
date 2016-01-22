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

apps.elf: libfrosted.a $(APPS-y) apps/apps.ld
	$(CC) -o $@  $(APPS-y) -Tapps/apps.ld -lfrosted -lc -lfrosted -Wl,-Map,apps.map  $(LDFLAGS) $(CFLAGS) $(EXTRA_CFLAGS)

libfrosted.a: libfrosted
	make -C libfrosted FROSTED=$(FROSTED)

clean:
	make -C apps clean
	make -C libfrosted clean


