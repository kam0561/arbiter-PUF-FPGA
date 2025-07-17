# --- Corrected Makefile for Vitis/Windows ---
# This version fixes all pathing and compilation issues for custom IP drivers.

# Explicitly define the object files to be created from your C source files.
OBJECTS = arbiter_puf_fpga.o arbiter_puf_fpga_selftest.o

# The 'libs' rule is the main target called by the Vitis build process.
libs: $(OBJECTS)
	@echo "--- Using corrected repository Makefile to build custom IP driver ---"
	# Add the compiled object files to the main library archive.
	$(ARCHIVER) -r ../../../lib/libxil.a $(OBJECTS)
	# Clean up the intermediate object files.
	rm -f $(OBJECTS)

# This is a pattern rule that tells 'make' how to build a .o file from a .c file.
# It includes the path to the main BSP headers to fix "file not found" errors.
%.o: %.c
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) -I../../../include -c $< -o $@

# The 'include' rule copies the header file to the BSP's include directory.
include:
	cp arbiter_puf_fpga.h ../../../include

# The 'clean' rule removes the intermediate object files.
clean:
	rm -f $(OBJECTS)
