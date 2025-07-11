COMPILER=arm-none-eabi-gcc
ARCHIVER=arm-none-eabi-ar
CP=cp
COMPILER_FLAGS=-O2 -c
EXTRA_COMPILER_FLAGS=-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -g -Wall -Wextra
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES=*.h
LIBSOURCES=$(wildcard *.c)
OUTS=$(LIBSOURCES:.c=.o)

libs:
	@echo "🛠️  Compiling arbiter_puf_fpga driver..."
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) -c $(LIBSOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS}
	@echo "✅  libxil.a created at ${RELEASEDIR}/${LIB}"
	make clean

include:
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -f ${OUTS}
