include $(DEVKITARM)/base_rules


all:	armv6k/fpu thumb \
	ds_arm7_vram_crt0.o thumb/ds_arm7_vram_crt0.o \
	ds_arm7_crt0.o thumb/ds_arm7_crt0.o \
	ds_arm9_crt0.o thumb/ds_arm9_crt0.o \
	gba_crt0.o thumb/gba_crt0.o \
	er_crt0.o thumb/er_crt0.o \
	gp32_crt0.o thumb/gp32_crt0.o \
	gp32_gpsdk_crt0.o thumb/gp32_gpsdk_crt0.o \
	armv6k/fpu/3dsx_crt0.o

install: all
	@mkdir -p $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib
	@cp -v *.specs *.ld *.mem $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib
	@cp -rv thumb armv6k *.o $(DESTDIR)/opt/devkitpro/devkitARM/arm-none-eabi/lib

clean:
	rm -fr thumb armv6k *.o

armv6k/fpu:
	@mkdir -p $@

thumb:
	@mkdir -p $@

armv6k/fpu/3dsx_crt0.o: 3dsx_crt0.s | armv6k/fpu
	$(CC) -march=armv6k -mfloat-abi=hard -c $< -o $@

thumb/%_vram_crt0.o: %_crt0.s | thumb
	$(CC)  -x assembler-with-cpp -DVRAM -mthumb -c $< -o$@

%_vram_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -DVRAM -marm -c $< -o$@

thumb/%_crt0.o: %_crt0.s | thumb
	$(CC)  -x assembler-with-cpp -mthumb -c $< -o$@

%_crt0.o: %_crt0.s
	$(CC)  -x assembler-with-cpp -marm -c $< -o$@
