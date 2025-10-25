C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

# C object files
OBJ_C = ${C_SOURCES:.c=.o}

# List ONLY the assembly files that need to be linked into the kernel.
# Do NOT include boot/bootsect.asm here.
ASM_LINK_SOURCES = boot/kernel_entry.asm boot/32bit_print.asm
OBJ_ASM_LINK = ${ASM_LINK_SOURCES:.asm=.o}

# All object files for the kernel
OBJ = ${OBJ_ASM_LINK} ${OBJ_C}

# --- FIX: Use the i686 (32-bit x86) cross-compiler ---
CC = i686-linux-gnu-gcc
# We no longer need -m32, as this compiler is 32-bit by default.
# --- FIX: Add -fno-pic to stop PIC/GOT errors ---
CFLAGS = -g -ffreestanding -nostdlib -nostdinc -fno-pic

# --- FIX: Use the i686 cross-linker ---
LD = i686-linux-gnu-ld
# Linker flags for a 32-bit i386 kernel
LDFLAGS_BIN = -m elf_i386 -Ttext 0x1000 --oformat binary
LDFLAGS_ELF = -m elf_i386 -Ttext 0x1000

# --- FIX: Use the x86 assembler (nasm is correct) ---
AS = nasm
ASFLAGS = -f elf

# --- FIX: Use a multi-arch GDB for debugging ---
GDB = gdb-multiarch

# First rule is run by default
os-image.bin: boot/bootsect.bin kernel.bin
	cat $^ > os-image.bin

# Kernel binary (for loading)
kernel.bin: ${OBJ}
	${LD} -o $@ ${LDFLAGS_BIN} $^

# Kernel ELF file (for debugging)
kernel.elf: ${OBJ}
	${LD} -o $@ ${LDFLAGS_ELF} $^ 

run: os-image.bin
	qemu-system-i386 -fda os-image.bin

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image.bin kernel.elf
	qemu-system-i386 -s -fda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

# --- NEW RULE ---
# Flashes the OS image to a USB drive.
# This is DANGEROUS. Make sure you know which device is your USB!
flash-usb: os-image.bin
	@echo "--- WARNING! THIS WILL DESTROY ALL DATA ON THE SELECTED DRIVE ---"
	@echo "Please identify your USB drive from the list below."
	@echo "Common USB drives are /dev/sdb, /dev/sdc, etc."
	@echo "DO NOT select your main drive (e.g., /dev/sda or /dev/nvme0n1)!"
	@lsblk -d -o NAME,SIZE,MODEL
	@echo -n "Enter the device path (e.g., /dev/sdc): "
	@read DRIVE; \
	if [ -z "$$DRIVE" ]; then \
		echo "No drive selected. Aborting."; \
		exit 1; \
	fi; \
	echo "About to flash os-image.bin to $$DRIVE..."; \
	echo "This is your final chance. Press Ctrl+C to cancel, or Enter to continue."; \
	read -r; \
	echo "Flashing... (sudo may ask for your password)"; \
	sudo dd if=os-image.bin of=$$DRIVE bs=4M status=progress conv=fdatasync; \
	echo "Flash complete!"; \
	echo -n "Would you like to eject $$DRIVE? (y/n) "; \
	read EJECT; \
	case "$$EJECT" in \
		y|Y) \
			echo "Ejecting $$DRIVE... (sudo may ask for your password again)"; \
			sudo eject $$DRIVE; \
			echo "$$DRIVE ejected."; \
			;; \
		*) \
			echo "Skipping eject. Please unmount/eject manually before removing."; \
			;; \
	esac

# --- GENERIC RULES ---

# Compile C files
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

# Compile linkable .asm files (like kernel_entry.asm)
%.o: %.asm
	${AS} ${ASFLAGS} $< -o $@

# --- EXPLICIT RULE for BOOTSECTOR ---
# This rule is special and ONLY applies to bootsect.asm
boot/bootsect.bin: boot/bootsect.asm
	${AS} $< -f bin -o $@

clean:
	rm -rf *.bin *.dis *.o os-image.bin *.elf
	rm -rf kernel/*.o boot/*.bin drivers/*.o boot/*.o



