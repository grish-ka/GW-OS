extern "C" void main(){
    volatile unsigned short *vga = (unsigned short*)0xB8000;
    vga[0] = ('Q' | (9 << 8)); // char plus attribute in high byte
    for(;;) asm volatile("hlt");
}