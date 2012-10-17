# put your *.o targets here, make should handle the rest!

SRCS = start.c main.c
ASMS = startasm.S

LD_SCRIPT = baremetal.ld

TARGET=main

CC=arm-linux-gnueabi-gcc
OBJCOPY=arm-linux-gnueabi-objcopy
LD=arm-linux-gnueabi-ld
AS=arm-linux-gnueabi-as

CFLAGS  = -g3 -c -Wall --std=gnu99
CFLAGS += -mlittle-endian -mcpu=cortex-a8
CFLAGS += -mfloat-abi=soft -nostdlib -ffreestanding
CFLAGS += -save-temps

OBJS = $(ASMS:.S=.o)
OBJS += $(SRCS:.c=.o)

.PHONY: proj

all: proj

again: clean all

burn:
	st-flash write $(TARGET).bin 0x8000000

.S.o:
	$(AS) $*.S -o $*.o
.c.o:
	$(CC) $(CFLAGS) $*.c -o $*.o

proj: 	$(TARGET).elf

$(TARGET).elf: $(OBJS)
	$(LD) -T$(LD_SCRIPT) $(OBJS) -o $(TARGET).elf && \
	$(OBJCOPY) -O ihex $(TARGET).elf $(TARGET).hex && \
	$(OBJCOPY) -O binary $(TARGET).elf main.bin && \
    mkimage -A arm -O linux -T kernel -C none -a 0x80000000 -e 0x80000000 -n "ROFLcopter" -d main.bin uImage


clean:
	rm -f *.o *.i *.s
	rm -f $(TARGET).elf
	rm -f $(TARGET).hex
	rm -f $(TARGET).bin && \
    rm uImage
