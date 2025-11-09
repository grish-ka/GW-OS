run: os.img os.bin
	qemu-system-x86_64 -drive format=raw,file=os.img,if=floppy -m 128M -no-reboot -serial stdio

os.bin: boot.bin full_kernel.bin zeros.bin
	cat "boot.bin" "full_kernel.bin" > os.bin
	cat zeros.bin >> os.bin

os.img: boot.bin full_kernel.bin os.bin
	truncate -s 1474560 os.img                
	dd if=boot.bin   of=os.img conv=notrunc bs=512 count=1
	dd if=full_kernel.bin of=os.img conv=notrunc bs=512 seek=1
# 	qemu-system-x86_64 -drive format=raw,file=os.img,if=floppy -m 128M -no-reboot -serial stdio


boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

full_kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o "full_kernel.bin" -Ttext 0x1000 -e _start "kernel_entry.o" "kernel.o" --oformat binary

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