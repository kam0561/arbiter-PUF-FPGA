OBJECTS = arbiter_puf_fpga.o arbiter_puf_fpga_selftest.o

libs: $(OBJECTS)
	@echo "--- Using corrected repository Makefile to build custom IP driver ---"
	
	$(ARCHIVER) -r ../../../lib/libxil.a $(OBJECTS)
	
	rm -f $(OBJECTS)


%.o: %.c
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) -I../../../include -c $< -o $@


include:
	cp arbiter_puf_fpga.h ../../../include

clean:
	rm -f $(OBJECTS)
