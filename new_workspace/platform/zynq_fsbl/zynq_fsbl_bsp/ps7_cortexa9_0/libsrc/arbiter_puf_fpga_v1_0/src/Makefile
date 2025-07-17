COMPILER = arm-none-eabi-gcc
ARCHIVER = arm-none-eabi-ar

OBJECTS = arbiter_puf_fpga.o arbiter_puf_fpga_selftest.o
LIB_OUT = ..\\..\\..\\lib\\libxil.a
INC_DIR = ..\\..\\..\\include

libs: $(OBJECTS)
	$(ARCHIVER) -r $(LIB_OUT) $(OBJECTS)
	del /Q $(OBJECTS)

%.o: %.c
	$(COMPILER) -O2 -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -g -Wall -Wextra -I$(INC_DIR) -c $< -o $@

include:
	copy arbiter_puf_fpga.h $(INC_DIR)

clean:
	del /Q $(OBJECTS)
