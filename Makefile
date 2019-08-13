# put your *.o targets here, make should handle the rest!

SRCS = system_stm32f1xx.c main.c 
OBJ = $(SRCS:.c=.o)

# all the files will be generated with this name (main.elf, main.bin, main.hex, etc)
PROJ_NAME=project

# Location of the Libraries folder from the STM32F1xx Standard Peripheral Library
LL_LIB=Drivers

# Location of the linker scripts
LDSCRIPT_INC=Device/ldscripts

TOOLCHAIN_PATH ?= /usr/local/arm-4.8.3/
TOOLCHAIN_BIN  = $(TOOLCHAIN_PATH)bin/

# that's it, no need to change anything below this line!

###################################################

CC=$(TOOLCHAIN_BIN)arm-none-eabi-gcc
OBJCOPY=$(TOOLCHAIN_BIN)arm-none-eabi-objcopy
OBJDUMP=$(TOOLCHAIN_BIN)arm-none-eabi-objdump
SIZE=$(TOOLCHAIN_BIN)arm-none-eabi-size

CFLAGS  = -Wall -g -std=gnu99 -Os
CFLAGS += -DSTM32F103xB -DUSE_FULL_LL_DRIVER 
CFLAGS += -mlittle-endian -mcpu=cortex-m3  -mthumb
CFLAGS += -ffunction-sections -fdata-sections
CFLAGS += -Wl,--gc-sections -Wl,-Map=$(PROJ_NAME).map
CFLAGS += -Werror -Wstrict-prototypes -Warray-bounds -fno-strict-aliasing -Wno-unused-const-variable
CFLAGS += -mfloat-abi=soft -specs=nano.specs -specs=nosys.specs
#-Wextra
###################################################

vpath %.c src
vpath %.a .

ROOT=$(shell pwd)

CFLAGS += -I $(LL_LIB) -I $(LL_LIB)/CMSIS/Device/ST/STM32F1xx/Include
CFLAGS += -I $(LL_LIB)/CMSIS/Include -I $(LL_LIB)/STM32F1xx_HAL_Driver/Inc -I src
CFLAGS += -I./src

SRCS += ./startup_stm32f103xb.s # add startup file to build

OBJS = $(SRCS:.c=.o)

###################################################

.PHONY: lib proj

all: proj

proj: 	$(PROJ_NAME).elf

%.o: %.c
	$(CC) $(CFLAGS) -c -o src/$@ $<

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ -L$(LL_LIB) -lll -L$(LDSCRIPT_INC) -lm -Tstm32f1xx.ld
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin
	$(OBJDUMP) -St $(PROJ_NAME).elf >$(PROJ_NAME).lst
	$(SIZE) -A $(PROJ_NAME).elf
		
clean:
	find ./ -name '*~' | xargs rm -f	
	rm -f *.o
	rm -f src/*.o 
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin
	rm -f $(PROJ_NAME).map
	rm -f $(PROJ_NAME).lst

