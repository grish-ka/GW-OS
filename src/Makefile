run: os.bin
	qemu-system-x86_64 -drive format=raw,file="os.bin",index=0,if=floppy, -m 128M

os.bin: boot.bin full_kernel.bin zeros.bin
	cat "boot.bin" "full_kernel.bin" > os.bin
	cat zeros.bin >> os.bin

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

full_kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o "full_kernel.bin" -Ttext 0x1000 "kernel_entry.o" "kernel.o" --oformat binary

# Object files

kernel.o: kernel.cpp
	i386-elf-g++ -ffreestanding -m32 -g -c "kernel.cpp" -o "kernel.o"

kernel_entry.o: kernel_entry.asm
	nasm -f elf "kernel_entry.asm" -o "kernel_entry.o"
# 	Can use -f elf32 maybe?

zeros.bin: zeros.asm
	nasm -f bin "zeros.asm" -o "zeros.bin"

clean:
	rm -f *.bin *.o