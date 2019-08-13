TOOLCHAIN_PATH ?= /usr/local/arm-4.8.3/
TOOLCHAIN_BIN  = $(TOOLCHAIN_PATH)bin/

CC=$(TOOLCHAIN_BIN)arm-none-eabi-gcc
AR=$(TOOLCHAIN_BIN)arm-none-eabi-ar
OBJCOPY=$(TOOLCHAIN_BIN)arm-none-eabi-objcopy
OBJDUMP=$(TOOLCHAIN_BIN)arm-none-eabi-objdump
SIZE=$(TOOLCHAIN_BIN)arm-none-eabi-size
RANLIB=$(TOOLCHAIN_BIN)arm-none-eabi-ranlib

CFLAGS += -DSTM32F103xB -DUSE_FULL_LL_DRIVER

CFLAGS += -mfloat-abi=soft
CFLAGS += -Wall -g -std=c99 -Os -fno-strict-aliasing
CFLAGS += -mlittle-endian -mcpu=cortex-m3 -mthumb

CFLAGS+=-ICMSIS/Include
CFLAGS+=-ICMSIS/Device/ST/STM32F1xx/Include
CFLAGS+=-ISTM32F1xx_HAL_Driver/Inc
CFLAGS+=-I.

LLSRC = $(wildcard STM32F1xx_HAL_Driver/Src/*_ll_*.c)
LLOBJ = $(LLSRC:.c=.o)

.PHONY: libll.a

all: libll.a

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^


libll.a: $(LLOBJ)
	$(AR) -r $@ $(LLOBJ)
	$(RANLIB) $@
clean:
	rm -f $(LLOBJ) libll.a

