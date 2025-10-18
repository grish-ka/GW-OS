sudo nasm -f bin src/boot.asm -o build/GW-OS.bin
sudo qemu-system-x86_64 build/GW-OS.bin
