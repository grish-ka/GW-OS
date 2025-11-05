run: os.bin
	qemu-system-x86_64 os.bin

os.bin: boot.bin
	cat boot.bin > os.bin

boot.bin: boot.asm
	nasm -f bin boot.asm -o boot.bin

clean:
	rm -f *.bin *.o